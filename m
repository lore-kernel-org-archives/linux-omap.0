From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Mon, 11 Dec 2017 07:16:03 -0800
Message-ID: <20171211151603.GG24344@atomide.com>
References: <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
 <20171130152430.GM28152@atomide.com>
 <20171130220633.imkfyeiqtftnw4j4@earth>
 <6ca5f2ea-e725-9a9e-ac02-e16beca4a1a0@ti.com>
 <0324FA0E-F06A-41F1-84AD-5BC72F6B6BFF@goldelico.com>
 <a27001ba-5ffd-365d-93e3-06fd1a2e01c2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a27001ba-5ffd-365d-93e3-06fd1a2e01c2-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Discussions
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [171201 02:03]:
> On 01/12/17 11:48, H. Nikolaus Schaller wrote:
> 
> > Just a note: there is no toppoly->tpo change for *this* panel and
> > Pandora board. Just omapdss removal.
> > 
> > The GTA04 needs a toppoly->tpo change but no omapdss, removal.
> > 
> > So they solve different problems and are independent of each other.
> > 
> > GTA04: change vendor string
> > Pandora: remove omapdss, prefix
> 
> Oh, right, I totally missed that. I thought they were changes to the
> same file...
> 
> In that case, Tony, can you pick this one as a fix? I'll pick the
> toppoly->tpo patch and merge via drm tree, if you give the ack.
> 
> For this:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Sorry I've lost track of this thread and what if anything is really
needed as a fix for v4.16. And now there's newer version of the two
dts patches in thread "[PATCH v4 0/2] Fixes for omapdrm on
OpenPandora and GTA04" so let's move the discussion there.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
