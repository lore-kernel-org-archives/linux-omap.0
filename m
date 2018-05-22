From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] [PATCHv2 0/5] Runtime PM support for wlcore
Date: Tue, 22 May 2018 06:37:10 -0700
Message-ID: <20180522133710.GF98604@atomide.com>
References: <20180517185029.71716-1-tony@atomide.com>
 <bff51dcc6fd441d9ab42db273219aaf4@ti.com>
 <20180521163830.GZ98604@atomide.com>
 <87efi4f78j.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87efi4f78j.fsf-HodKDYzPHsUD5k0oWYwrnHL1okKdlPRT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Loewy, Chen" <c-loewy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> [180522 08:05]:
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> 
> > * Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180521 07:31]:
> >> > Here's a series of patches to add runtime PM support for wlcore. It does not
> >> > yet implement autosuspend support, but let's get this tested first as the
> >> > autosuspend can mask enable/disable issues easily.
> >> 
> >> Testing on BBB+WL1837 cape, scan, recovery, down/up and basic traffic seems ok now.
> >> Of course we need to test some more.
> >
> > Thanks for testing. Yes let's do more testing, no rush with these.
> > Hopefully they'll be ready for v4.19 merge window though.
> 
> So I can drop the patchset now and you will resend once it's ready?

Yes thanks I will send at least one more version of this series.

Regards,

Tony
