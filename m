From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Mon, 2 Oct 2017 18:01:19 -0500
Message-ID: <9520300c-4cbb-b905-a534-103ae7ca3f5f@ti.com>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
 <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
 <0a506277-6c9b-1407-dea3-f9895fdc3e63@ergon.ch>
 <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
 <3778fa75-0327-0c36-1721-e89e23a782b6@ergon.ch>
 <20170929125213.by5mwverw2a47lmo@earth>
 <ad684ace-272a-1e45-f65b-b280be86ffc2@ergon.ch>
 <20170929163716.nprxehj7eyld4io5@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170929163716.nprxehj7eyld4io5@earth>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 09/29/2017 11:37 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Sep 29, 2017 at 05:17:47PM +0200, Claudio Foellmi wrote:
>>>> Sebastian, can you please check if this helps with your problems on N950?
>>>> If it does, I'll turn it into a proper standalone patch.
>>>
>>> No, it does not. Also no interrupts ignoring messages appearing
>>> in dmesg:
>>>
>>> n950# dmesg | grep -E "48072000.i2c|lp5523x"
>>> [    0.791046] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
>>> [    4.934265] lp5523x 1-0032: reset command sent (no ACK)!
>>> [    6.003875] omap_i2c 48072000.i2c: controller timed out
>>> [    6.033874] lp5523x 1-0032: device detection err: -110
>>> [    6.039154] lp5523x: probe of 1-0032 failed with error -110
>>>
>>
>> Hi Sebastian
>>
>> Thank you for trying it out.
>> It seems that your symptoms are quite different from the ones that Vignesh
>> described earlier. He had never-ending storms of spurious interrupts
>> (which that patch would have addressed), but you don't seem to get
>> any interrupts at all. Not even the NACK one, which just looks wrong.

regarding spurious interrupts during recovery. In my opinion,
I2C IRQs should be disabled on entering recovery and re-enabled after, as
bus state is unpredictable during recovery and OMAP I2C driver expect to
receive IRQs only and only when omap_i2c_xfer() is called.
(omap->receiver will have correct value only in above case)

>>
>> If you want to still dig deeper, you can enable debug logs for i2c-omap,
>> so you can see every single interrupt. But if there are none, I don't see
>> what we could possibly do to fix it.
>>
>>
>> Vignesh, do you still have access to any of those devices with interrupt
>> floods? If so, could you try the previous patch on one of them?
>>
>> Also note that Sebastian's issue is definitely not caused (or helped)
>> by bus recovery, the timeout he sees resets the adapter right away.
>> So he is not affected by my original patch either way.
>>
>> -- Claudio
> 
> Yeah, I don't see IRQ storm, so this might be a different issue.
> FWIW this is what I see on N950:
> 
> n950# dmesg | grep -E "48072000.i2c|lp55"
> [    2.136383] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
> [    8.212951] omap_i2c 48072000.i2c: addr: 0x0032, len: 2, flags: 0x0, stop: 1
> [    8.213287] omap_i2c 48072000.i2c: IRQ (ISR = 0x0010)
> [    8.213592] omap_i2c 48072000.i2c: IRQ (ISR = 0x0002)
> [    8.213897] lp5523x 1-0032: reset command sent (no ACK)!
> [    8.242462] omap_i2c 48072000.i2c: addr: 0x0032, len: 2, flags: 0x0, stop: 1
> [    8.243255] omap_i2c 48072000.i2c: IRQ (ISR = 0x0014)
> [    8.243469] omap_i2c 48072000.i2c: IRQ (ISR = 0x0010)

this second XRDY looks suspicious, as it's received after ARDY.

> [    8.253387] omap_i2c 48072000.i2c: addr: 0x0032, len: 1, flags: 0x0, stop: 0
> [    8.253631] omap_i2c 48072000.i2c: IRQ (ISR = 0x0010)
> [    9.272735] omap_i2c 48072000.i2c: controller timed out
> [    9.278167] lp5523x 1-0032: device detection err: -110
> [    9.283843] lp5523x: probe of 1-0032 failed with error -110
> [    9.662780] omap_i2c 48072000.i2c: addr: 0x0060, len: 1, flags: 0x0, stop: 0
> [    9.670166] omap_i2c 48072000.i2c: IRQ (ISR = 0x0010)
> [    9.675659] omap_i2c 48072000.i2c: IRQ (ISR = 0x0004)
> [    9.682617] omap_i2c 48072000.i2c: addr: 0x0060, len: 1, flags: 0x1, stop: 1
> [    9.689819] omap_i2c 48072000.i2c: IRQ (ISR = 0x0008)
> [    9.695007] omap_i2c 48072000.i2c: IRQ (ISR = 0x0004)

 
Wouldn't below diff help:

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1ebb5e9..e52bdae 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -959,7 +959,7 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
 {
        u16             w;
 
-       while (num_bytes--) {
+       while (omap->buf_len && num_bytes--) {
                w = *omap->buf++;
                omap->buf_len--;




-- 
regards,
-grygorii
