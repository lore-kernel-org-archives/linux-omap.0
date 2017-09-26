From: Claudio Foellmi <claudio.foellmi@ergon.ch>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Tue, 26 Sep 2017 14:24:59 +0200
Message-ID: <3778fa75-0327-0c36-1721-e89e23a782b6@ergon.ch>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
 <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
 <0a506277-6c9b-1407-dea3-f9895fdc3e63@ergon.ch>
 <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 19.09.2017 12:50, Vignesh R wrote:
> 
> 
> On Monday 18 September 2017 05:31 PM, Claudio Foellmi wrote:
>> On 18.09.2017 07:24, Vignesh R wrote:
>>>
>>>
>>> On Saturday 16 September 2017 05:01 AM, Strashko, Grygorii wrote:
>>>>
>>>>
>>>> On 09/14/2017 10:39 AM, Claudio Foellmi wrote:
>>>>> A very conservative check for bus activity (to prevent interference
>>>>> in multimaster setups) prevented the bus recovery methods from being
>>>>> triggered in the case that SDA or SCL was stuck low.
>>>>> This defeats the purpose of the recovery mechanism, which was introduced
>>>>> for exactly this situation (a slave device keeping SDA pulled down).
>>>>>
>>>>> Note that bus lockups can persist across reboots. The only other options
>>>>> are to reset or power cycle the offending slave device, and many i2c
>>>>> slaves do not even have a reset pin.
>>>>>
>>>>> If we see that one of the lines is low for the entire timeout duration,
>>>>> we can actually be sure that there is no other master driving the bus.
>>>>> It is therefore save for us to attempt a bus recovery.
>>>>>
>>>>
>>>> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>
>>>>> Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
>>>>> ---
>>>>> Caveat: It turns out I don't have the hardware to fully test the
>>>>> recovery mechanism. My faulty i2c slave device actually pulls down SCL,
>>>>> not SDA (so the recovery will not succeed in my case).
>>>
>>> Maybe, you could detect SCL stuck low case by reading status of SCL line
>>> from OMAP_I2C_SYSTEST_REG and then call IP reset (there is nothing much
>>> that can be done) instead of bus recovery.
>>>
>>
>> I plan on posting a related patch soon, that will print better messages
>> if the generic recovery fails. If SCL is stuck low, I think the best we
>> can do is make the problem visible in the kernel log.
>>
>>>>> But by directly connecting SDA to ground, I could at least make sure
>>>>> the recovery function gets called after applying this patch.
>>>>>
>>>
>>> I had seen flood of XRDY & RRDY interrupts as soon as TMODE is set to
>>> 0x3 as part of omap_i2c_prepare_recovery() leading to unusable system.
>>> Did you observe this behavior on your system? Could you mention the
>>> platform on which this experiment done?
>>>
>>
>> So attempting bus recovery is dangerous on some platforms?
>> I did not notice any obvious problems (assuming an 'unusable system'
>> would be hard to miss), but then again I only have one target to test on.
>> I'm working with a TI AM3352, the slave is a NXP NT3H2211 on i2c-1.
>>
> 
> I hit a situation where when communicating with a faulty i2c device, the
> last transaction on the bus does not end with proper STOP condition on
> the i2c bus. Since, STOP condition was not detected by IP, Bus Busy will
> remain set even though both SCL and SDA are high. Thus,
> omap_i2c_wait_for_bb() function would end up calling bus recovery. And
> as soon as TMODE is set to 0x3 and ST_EN to 0x1, there is a flood of
> XRDY & RRDY interrupts.
> 
> This spurious irqs can be reproduced easily by setting TMODE to 0x3 and
> ST_EN to 0x1 in OMAP_I2C_SYSTEST_REG when both SCL and SDA are high (bus
> is idle) even on AM335x.
> 
> So, if you are not seeing irq flood when SCL/SDA is stuck low, then
> maybe its safe to enter TMODE 0x3 in such cases. Could you modify the
> patch to test whether or not SDA is stuck low before initiating bus
> recovery?
> 

This sounds more like a problem with the interrupt handler than with
bus recovery, so I'm a bit hesitant to just add such a workaround.
Instead, I spent a few hours looking through the interrupt handling
(and poking my i2c bus with a wire to induce random faults), and
I suspect to have found the underlying cause, or at least part of it:

We sometimes ignore some interrupts (such as RRDY if we think we are
not in receiving mode), but don't really deal with their cause.
As a result, the same interrupt will just be raised again as soon as
we leave the handler. It will then be ignored again, and raised again...

I'm still not quite sure how we can reliably get into such situations in
the first place, but not sending a stop condition seems to be part of it.
Maybe it is somehow connected to the automatic internal state change
that happens as part of AL or NACK interrupts.


Below is a small patch that should test my assumptions.
It clears the incoming fifo and acks the ignored RRDY interrupts.

Sebastian, can you please check if this helps with your problems on N950?
If it does, I'll turn it into a proper standalone patch.


Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
---
 drivers/i2c/busses/i2c-omap.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1ebb5e9..1ad1b0c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1009,6 +1009,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 	struct omap_i2c_dev *omap = dev_id;
 	u16 bits;
 	u16 stat;
+	u16 buf;
 	int err = 0, count = 0;
 
 	do {
@@ -1016,11 +1017,21 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
 		stat &= bits;
 
-		/* If we're in receiver mode, ignore XDR/XRDY */
-		if (omap->receiver)
+		/* If we're in receiver mode, ignore XDR/XRDY and vice versa */
+		if (omap->receiver && stat & (OMAP_I2C_STAT_XDR |
+				OMAP_I2C_STAT_XRDY)) {
+			dev_err(omap->dev, "ignoring TX interrupts\n");
 			stat &= ~(OMAP_I2C_STAT_XDR | OMAP_I2C_STAT_XRDY);
-		else
+		} else if (!omap->receiver && stat & (OMAP_I2C_STAT_RDR |
+				OMAP_I2C_STAT_RRDY)) {
+			dev_err(omap->dev, "ignoring RX interrupts\n");
 			stat &= ~(OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_RRDY);
+			buf = omap_i2c_read_reg(omap, OMAP_I2C_BUF_REG);
+			buf |= OMAP_I2C_BUF_RXFIF_CLR;
+			omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, buf);
+			omap_i2c_ack_stat(omap,
+				OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR);
+		}
 
 		if (!stat) {
 			/* my work here is done */
-- 
2.7.4
