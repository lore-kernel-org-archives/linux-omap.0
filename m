From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Fri, 19 Jun 2009 03:35:50 -0700
Message-ID: <200906190335.50621.david-b@pacbell.net>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com> <13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BED5CF1-EovWT4A8QTWIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>
Cc: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 18 May 2009, Woodruff, Richard wrote:
> 
> > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Niilo Minkkinen
> > Sent: Monday, May 18, 2009 9:54 AM
> 
> > Omap3 MUSB AUTOIDLE functionality configured through OTG_SYSCONFIG
> > register prevents the device from going into retention.
> > This is a workaround (by Richard Woodruff/TI), as his comment :
> > > A new MUSB bug which is a match to data below was identified very
> > > recently (on hardware and in simulation).
> > > This bug is in 3430 and not 3630.
> > > As a priority test (and as new default) you should have engineers
> > > disable autoidle for MUSB block.
> > > This is the workaround which will show up in next errata.
> >
> > Signed-off-by: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> Signed-off-by: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
> 
> Yes this is needed for 34xx. Side note is this cost around 1mW of power
> during active mode of MUSB. When device is not active cost is not
> significant.  System impact depends on duty cycle of MUSB in usecase.  

There's also some initialization goofiness in that code ... it's supposed
to set initialize the transceiver with several distinct writes, of which
setting AUTOIDLE (to auto-gate the L3 clock) is ISTR the last step.

The goofiness shows up with OTG initialization, which is documented as
needing a slightly different sequence ... my notes have it as being
an extra write to set ENABLEFORCE.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
