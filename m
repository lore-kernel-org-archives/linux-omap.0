From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] arm: davinci: Make the usb20 clock available to PM
 runtime
Date: Thu, 19 Jan 2017 10:49:04 -0600
Message-ID: <fe7720b2-5623-1b14-6d4c-965eeeceecd4@ti.com>
References: <20170119140944.19051-1-abailon@baylibre.com>
 <cba200b6-1858-22e7-8d5a-f017c311c832@ti.com>
 <628c4afa-20c0-812c-1172-873391b27f1f@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <628c4afa-20c0-812c-1172-873391b27f1f-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 01/19/2017 09:08 AM, Alexandre Bailon wrote:
> On 01/19/2017 03:48 PM, Sekhar Nori wrote:
>> On Thursday 19 January 2017 07:39 PM, Alexandre Bailon wrote:
>>> Add usb20 to the list of clock supported by PM runtime.
>>>
>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>> ---
>>>  arch/arm/mach-davinci/pm_domain.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
>>> index 78eac2c..66471f2 100644
>>> --- a/arch/arm/mach-davinci/pm_domain.c
>>> +++ b/arch/arm/mach-davinci/pm_domain.c
>>> @@ -23,7 +23,7 @@ static struct dev_pm_domain davinci_pm_domain = {
>>>  
>>>  static struct pm_clk_notifier_block platform_bus_notifier = {
>>>  	.pm_domain = &davinci_pm_domain,
>>> -	.con_ids = { "fck", "master", "slave", NULL },
>>> +	.con_ids = { "fck", "master", "slave", "usb20", NULL },
>>
>> Instead of doing this, can we drop the con_id from musb clock? Looking
>> at the USB clocking diagram in the TRM. There is a single clock input to
>> the USB 2.0 subsystem. There is no real need for a con_id at all.
> Currently, the con_id is required to get the usb20 clock from usb-da8xx.c
> I will try to figure out which changes are required remove con_id.

It most probably should be renamed to "fck" then it should work with your
patch "[PATCH v3 5/5] usb: musb: da8xx: Add a primary support of PM runtime".

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
