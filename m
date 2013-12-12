From: Andreas Naumann <dev-c3EzeJ48v2U@public.gmane.org>
Subject: Re: WG: [PATCH] usb: musb: omap2430: fix occasional musb breakage
 on boot
Date: Thu, 12 Dec 2013 22:29:12 +0100
Message-ID: <52AA2AA8.4090402@andin.de>
References: <EE4E4767751A8B40949306E403F4DDD8032AA82A@sv03ultra002.ultratronik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EE4E4767751A8B40949306E403F4DDD8032AA82A-zDU4f0UzlK41cL/Vr7vMjYWky2maIgj/G9Ur7JDdleE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: fbalbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grazvydas,

> Von: Grazvydas Ignotas [mailto:notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Gesendet: Donnerstag, 12. Dezember 2013 01:21
> An: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Felipe Balbi; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Naumann Andreas; Grazvydas Ignotas; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Betreff: [PATCH] usb: musb: omap2430: fix occasional musb breakage on boot
>
> This is a hard to reproduce problem which leads to non-functional
> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
> e25bec160158abe86c "omap2+: save and restore OTG_INTERFSEL",
> which introduces save/restore of OTG_INTERFSEL over suspend.
>
> Since the resume function is also called early in driver init, it uses a
> non-initialized value (which is 0 and a non-supported setting in DM37xx
> for INTERFSEL). Shortly after the correct value is set. Apparently this
> works most time, but not always.
>
> Fix it by not writing the value on runtime resume if it is 0
> (0 should never be saved in the context as it's invalid value,
> so we use it as an indicator that context hasn't been saved yet).
>
> This issue was originally found by Andreas Naumann:
> http://marc.info/?l=linux-usb&m=138562574719654&w=2
>
> Reported-and-bisected-by: Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> ---
> This is a regression from 3.2, so should go to -rc and stable, IMO.
> It's really annoying issue if you want to have a stable OTG behavior,
> I've burned quite a lot of time on it myself over a year ago and gave up
> eventually. Good thing Andreas finally found it, many thanks to him!
>
>   drivers/usb/musb/omap2430.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 2a408cd..737b3da 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -672,7 +672,8 @@ static int omap2430_runtime_resume(struct device *dev)
>
>   	if (musb) {
>   		omap2430_low_level_init(musb);
> -		musb_writel(musb->mregs, OTG_INTERFSEL,
> +		if (musb->context.otg_interfsel != 0)
> +			musb_writel(musb->mregs, OTG_INTERFSEL,
>   				musb->context.otg_interfsel);
>   		phy_power_on(musb->phy);
>   	}
>

Oh, easy way out. I like it but I've also been thinking about your 
comment on my original post, which was that initializing otg_interfsel 
to the PHYSEL bits only might be dangerous because we cant be sure that 
there are other bits in the register.
However, isnt assuming that 0 is invalid on all OMAPs just as dangerous?

After thinking about my patch again, I would propose to change 
otg_interfsel into otg_physel and read-modify-write only those bits in 
resume() as you suggested in your first answer. That way I could discard 
the problematic first read in probe() while leaving other bits 
untouched. If you agree I post a patch for this tomorrow.

cheers,
Andreas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
