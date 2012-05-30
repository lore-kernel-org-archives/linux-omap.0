From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] watchdog: omap_wdt: add device tree support
Date: Wed, 30 May 2012 17:30:11 +0200
Message-ID: <4FC63D03.8080501@ti.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
 <1337942552-28218-4-git-send-email-jgq516@gmail.com>
 <4FC51008.1050004@ti.com> <4FC59171.8040009@gmail.com>
 <4FC5D21F.2030702@ti.com> <4FC636C9.2050902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FC636C9.2050902@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux@arm.linux.org.uk, linux-watchdog@vger.kernel.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, Xiao Jiang <jgq516@gmail.com>, rob.herring@calxeda.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, wim@iguana.be, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On 5/30/2012 5:03 PM, Jon Hunter wrote:
> Hi Benoit,
>
> On 05/30/2012 02:54 AM, Cousson, Benoit wrote:
>> On 5/30/2012 5:18 AM, Xiao Jiang wrote:
>>> Jon Hunter wrote:
>>>> On 05/25/2012 05:42 AM, jgq516@gmail.com wrote:
>>>>> From: Xiao Jiang<jgq516@gmail.com>
>>>>>
>>>>> Add device table for omap_wdt to support dt.
>>>>>
>>>>> Signed-off-by: Xiao Jiang<jgq516@gmail.com>
>>>>> ---
>>>>> drivers/watchdog/omap_wdt.c | 8 ++++++++
>>>>> 1 files changed, 8 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
>>>>> index 8285d65..d98c615 100644
>>>>> --- a/drivers/watchdog/omap_wdt.c
>>>>> +++ b/drivers/watchdog/omap_wdt.c
>>>>> @@ -430,6 +430,13 @@ static int omap_wdt_resume(struct
>>>>> platform_device *pdev)
>>>>> #define omap_wdt_resume NULL
>>>>> #endif
>>>>>
>>>>> +static const struct of_device_id omap_wdt_of_match[] = {
>>>>> + { .compatible = "ti,omap3-wdt", },
>>>>> + { .compatible = "ti,omap4-wdt", },
>>
>> If there is no difference between the OMAP3 and the OMAP4 WDT IP, just
>> add one entry "ti,omap3-wdt". And then in the OMAP4 DTS you will just
>> put : compatible = "ti,omap3-wdt"; or compatible =  "ti,omap4-wdt",
>> "ti,omap3-wdt";
>
> Hmmm ... comparing the omap3 and omap4 wdt registers there are some
> differences. omap4 seems to have more registers than omap3. May be we
> are not using these right now, but from a register perspective the wdt
> in omap2, omap3 and omap4 appear to be slightly different. The revision
> ID register on omap3 and omap4 have different values too.
>
> I guess from a driver perspective there is no difference, but it seemed
> to me that the IP is not completely the same.

Well, in that case, and assuming that there is no proper HW_REVISION 
information to detect the IP difference, the proper compatible entries 
will indeed have to be used.

>
>> I'm still a little bit confused about the real need for the
>> "ti,omap4-wdt: entry, but it seems to be the way to do it in PPC.
>>
>>>>> + {},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, omap_wdt_of_match);
>>>>> +
>>>>> static struct platform_driver omap_wdt_driver = {
>>>>> .probe = omap_wdt_probe,
>>>>> .remove = __devexit_p(omap_wdt_remove),
>>>>> @@ -439,6 +446,7 @@ static struct platform_driver omap_wdt_driver = {
>>>>> .driver = {
>>>>> .owner = THIS_MODULE,
>>>>> .name = "omap_wdt",
>>>>> + .of_match_table = omap_wdt_of_match,
>>>>> },
>>>>> };
>>>>>
>>>>
>>>> I think we need to add some code to the probe function that calls
>>>> of_match_device() and ensures we find a match. For example ...
>>>>
>>>> if (of_have_populated_dt())
>>>> if (!of_match_device(omap_wdt_of_match,&pdev->dev))
>>>> return -EINVAL;
>>>>
>>> Will add it in v2, thanks for suggestion.
>>
>> No, in fact this is not needed. We need that mainly when several
>> instances can match the same driver and thus we select the proper one
>> using the of_match_device. Otherwise, just check is the device_node is
>> there.
>>
>> In that case, the driver does not even care about any DT node so there
>> is no need to add extra code for that. Keep it simple.
>
> Ok. So are you saying get rid of the match table altogether? In other
> words, drop this patch?

No, the match table is used by the LDM to find the proper driver to be 
bound to a device. So we do need it. But we do not have to use the 
of_match_device if we do not want to get the entry in the device table.

> I agree that it does not really do anything today, but I did not know if
> in the future you were planning to pass things like, register addresses,
> via DT.

Well, yes we will have to, otherwise people will keep complaining that 
our DTS sucks and are not compliant with the DTS standards :-)

Regards,
Benoit
