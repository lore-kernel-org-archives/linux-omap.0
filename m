From: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 16:02:33 +0530
Message-ID: <5232E9C1.7070806@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com> <5232DCFE.5050700@ti.com> <5232DD53.3010706@ti.com> <5232DF61.6000109@ti.com> <5232E00E.9040400@ti.com> <5232E2A8.10409@ti.com> <5232E63E.9020804@ti.com> <5232E7E2.7050606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5232E7E2.7050606-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 13 September 2013 03:54 PM, Tomi Valkeinen wrote:
> On 13/09/13 13:17, Archit Taneja wrote:
>> On Friday 13 September 2013 03:32 PM, Tomi Valkeinen wrote:
>>> On 13/09/13 12:51, Archit Taneja wrote:
>>>
>>>> The calls in omap_generic_init() check the machine type via
>>>> of_machine_is_compatible(), even if it's a multiplatform image, the dtb
>>>> should be only of one platform. So it wouldn't be called at all.
>>>
>>> Hmm. BeagleBone is "ti,am33xx". The "Generic AM33XX (Flattened Device
>>> Tree)" machine definition uses omap_generic_init(). So if I'm not
>>> missing something here, omap_generic_init() is called for BeagleBone.
>>
>> I was talking about the calls within omap_generic_init() :
>>
>> omap_generic_init(void)
>> {
>>      ...
>>      if (of_machine_is_compatible("ti,omap4-panda")) {
>>          omap4_panda_display_init_of();
>>          legacy_init_ehci_clk("auxclk3_ck");
>>
>>      }
>> }
>>
>> omap4_panda_display_init_of() would be called only if a panda board dtb
>> was used. Are you talking about these display calls, or something else?
>
> Ah, right. I was looking at the DSS DT branch. There we have
> omapdss_init_of() call from omap_generic_init(). So that is a problem,
> but not in the mainline.
>
> You're right, the current mainline doesn't call the DSS init function on
> am33xx. But it does create omapfb and omapdrm devices, as you noted.
>
> Well, those devices don't do any actual harm, but I agree that they
> shouldn't be there. It's probably best to move the device creation into
> display.c, as you did. Just include omapfb also, and maybe remove the
> DMM creation as a first patch.

Sure, I'll do that.

I'm not sure either about how to deal with the direct call to 
omapdss_init_of().

Archit

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
