From: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Mon, 18 May 2009 14:23:11 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Niilo Minkkinen
> Sent: Monday, May 18, 2009 9:54 AM

> Omap3 MUSB AUTOIDLE functionality configured through OTG_SYSCONFIG
> register prevents the device from going into retention.
> This is a workaround (by Richard Woodruff/TI), as his comment :
> > A new MUSB bug which is a match to data below was identified very
> > recently (on hardware and in simulation).
> > This bug is in 3430 and not 3630.
> > As a priority test (and as new default) you should have engineers
> > disable autoidle for MUSB block.
> > This is the workaround which will show up in next errata.
>
> Signed-off-by: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Signed-off-by: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>

Yes this is needed for 34xx. Side note is this cost around 1mW of power during active mode of MUSB. When device is not active cost is not significant.  System impact depends on duty cycle of MUSB in usecase.

Regards,
Richard W.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
