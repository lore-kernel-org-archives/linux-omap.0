From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: usb: musb: regression since 4.9 on omap4-panda-es (caused by
 d8e5f0eca1e8)
Date: Wed, 5 Apr 2017 10:13:43 +0300
Message-ID: <dda7b6b0-b533-dfd6-1b12-b320bd69b623@ti.com>
References: <2bf73b02-6e59-627a-c370-552ed94e7795@ti.com>
 <20170404122736.GA13673@uda0271908> <20170404140341.GO10760@atomide.com>
 <20170405003637.GB13234@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170405003637.GB13234-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,

On 2017-04-05 03:36, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170404 07:06]:
>> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170404 05:30]:
>>> On Tue, Apr 04, 2017 at 10:09:50AM +0300, Peter Ujfalusi wrote:
>>>> Tony,
>>>>
>>>> since 4.9 (4.8 was fine) I can not boot omap4-panda-es if the musb
>>>> is compiled in. The kernel will stuck printing:
>>>>
>>>> ** 206 printk messages dropped ** [    8.926727] musb_bus_suspend
>>>> 2584: trying to suspend as a_idle while active
>>
>> OK so compiled in. Do you have something connected also when
>> booting?
>>
>>> Does it sound a similar issue to
>>> http://marc.info/?l=linux-usb&m=149036531809506&w=2
>>
>> Yup.
>>
>>>> The bisect (log is [1]) points to:
>>>> d8e5f0eca1e8 usb: musb: Fix hardirq-safe hardirq-unsafe lock order error
>>>>
>>>> and reverting the d8e5f0eca1e8 makes the board to boot up fine
>>>> (Linux 4.11-rc5 and next-20170331).
>>
>> OK thanks for bisecting it.
>>
>>>> any idea on how to fix this w/o reverting the commit?
>>
>> I'll take a look.
>
> OK I was able to reproduce this with loadable modules by reloading
> the modules while having OTG-A cable inserted with a hub and USB
> drive connected.
>
> Peter, care to check if the following fixes the problem for you?
> There should no longer be much any musb core tinkering happening
> in the glue layers..

I had similar hunch first, but did not worked. I have tested this patch 
and did not helped.

To be precise this is what I have tried:
- boot w/o cable connected
- boot w/ board connected to PC (device mode)
- boot w/ OTG-A cable with USB keyboard
- boot w/ OTG-A cable connected to powered USB hub and the same keyboard

w/ and w/o this patch I have the same flood of prints in all cases.

Fwiw I have checked where the is_active is set - which causes the prints:
musb_core.c:musb_start()

if (musb->port_mode != MUSB_PORT_MODE_HOST &&
		musb->xceiv->otg->state != OTG_STATE_A_WAIT_BCON &&
		(devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS) {
	musb->is_active = 1;
} else {
	devctl |= MUSB_DEVCTL_SESSION;
}

this was the only place where the is_active was set to 1.


> Regards,
>
> Tony
>
> 8< -----------------------
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -91,12 +91,6 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
>  			}
>
>  			otg_set_vbus(otg, 1);
> -		} else {
> -			musb->is_active = 1;
> -			otg->default_a = 1;
> -			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> -			devctl |= MUSB_DEVCTL_SESSION;
> -			MUSB_HST_MODE(musb);
>  		}
>  	} else {
>  		musb->is_active = 0;

- Péter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
