From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: usb: musb: regression since 4.9 on omap4-panda-es (caused by
 d8e5f0eca1e8)
Date: Wed, 5 Apr 2017 10:29:43 +0300
Message-ID: <492f32ab-573f-0228-5e2e-46a7b95ae67a@ti.com>
References: <2bf73b02-6e59-627a-c370-552ed94e7795@ti.com>
 <20170404122736.GA13673@uda0271908> <20170404140341.GO10760@atomide.com>
 <20170405003637.GB13234@atomide.com>
 <dda7b6b0-b533-dfd6-1b12-b320bd69b623@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dda7b6b0-b533-dfd6-1b12-b320bd69b623-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 2017-04-05 10:13, Peter Ujfalusi wrote:
> I had similar hunch first, but did not worked. I have tested this patch
> and did not helped.
>
> To be precise this is what I have tried:
> - boot w/o cable connected
> - boot w/ board connected to PC (device mode)
> - boot w/ OTG-A cable with USB keyboard
> - boot w/ OTG-A cable connected to powered USB hub and the same keyboard
>
> w/ and w/o this patch I have the same flood of prints in all cases.

the config I have for linux-next:
https://pastebin.com/KixvyiRR

>
> Fwiw I have checked where the is_active is set - which causes the prints:
> musb_core.c:musb_start()
>
> if (musb->port_mode != MUSB_PORT_MODE_HOST &&
>         musb->xceiv->otg->state != OTG_STATE_A_WAIT_BCON &&
>         (devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS) {
>     musb->is_active = 1;
> } else {
>     devctl |= MUSB_DEVCTL_SESSION;
> }
>
> this was the only place where the is_active was set to 1.
>
>
>> Regards,
>>
>> Tony
>>
>> 8< -----------------------
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -91,12 +91,6 @@ static void omap2430_musb_set_vbus(struct musb
>> *musb, int is_on)
>>              }
>>
>>              otg_set_vbus(otg, 1);
>> -        } else {
>> -            musb->is_active = 1;
>> -            otg->default_a = 1;
>> -            musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
>> -            devctl |= MUSB_DEVCTL_SESSION;
>> -            MUSB_HST_MODE(musb);
>>          }
>>      } else {
>>          musb->is_active = 0;
>
> - Péter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- Péter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
