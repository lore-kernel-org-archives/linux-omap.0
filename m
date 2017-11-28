From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Tue, 28 Nov 2017 08:18:34 -0800
Message-ID: <20171128161834.GE28152@atomide.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [171128 16:17]:
> Hi Tony,
> 
> > Am 28.11.2017 um 17:04 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > 
> > * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [171128 15:52]:
> >> We can remove the unnecessary "omapdss," prefix because
> >> the omapdrm driver takes care of it when matching with
> >> the driver table.
> > 
> > So is this needed as a fix or is this another clean-up?
> > 
> > So is this is really needed as a fix?
> 
> Hm. How do you differentiate between "fix" and "cleanup"?
> Maybe it is more a wording than a content issue...
> 
> For me it is a "fix" because it is semantically wrong to have
> a prefix where it is not needed. And "fixing" it changes the
> compiler output by 8 bytes.

How about let's call it a "typo fix" then? :)

> "Cleanup" would be for me removing whitespace or empty lines
> or typos in comments.
>
> > If this is just clean-up, again, please resend once the driver
> > changes have cleared.
> 
> There is no change to the pandora driver involved here. The Pandora
> panel driver is already correct. Just the DTS has some redundant
> content which should be removed.
> 
> So there is no dependency for this patch.

OK please resend separately after the driver changes have merged
then.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
