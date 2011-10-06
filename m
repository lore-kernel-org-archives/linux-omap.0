From: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Subject: Re: [PATCH] omap: dmtimer: convert printk to pr_*
Date: Thu, 6 Oct 2011 18:26:14 +0200
Message-ID: <20111006162614.GH30222@lit.local.igalia.com>
References: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
 <1317914379.10495.5.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:34009 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935856Ab1JFQ0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 12:26:17 -0400
Content-Disposition: inline
In-Reply-To: <1317914379.10495.5.camel@Joe-Laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Timo Teras <timo.teras@solidboot.com>, Harvey Harrison <harvey.harrison@gmail.com>

On Thu, Oct 06, 2011 at 08:19:39AM -0700, Joe Perches wrote:
> On Thu, 2011-10-06 at 12:48 +0200, V=EDctor Manuel J=E1quez Leal wrot=
e:
> > Convert all the printk(<level>) messages in the driver to pr_<level=
>().
> []
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmti=
mer.c
> []
> > @@ -397,8 +397,7 @@ struct omap_dm_timer *omap_dm_timer_request_spe=
cific(int id)
> >  	spin_lock_irqsave(&dm_timer_lock, flags);
> >  	if (id <=3D 0 || id > dm_timer_count || dm_timers[id-1].reserved)=
 {
> >  		spin_unlock_irqrestore(&dm_timer_lock, flags);
> > -		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> > -		       __FILE__, __LINE__, __func__, id);
> > +		pr_warning("unable to get timer %d\n", id);
>=20
> For new conversions, please use pr_warn not pr_warning.
> It's shorter and similar to other dev_warn/netdev_warn
> uses.
>=20
> >  		dump_stack();
>=20
> To emit a message then dump stack, please use
> 	WARN(1, fmt, ...)
>=20

Thanks a lot!

I'll do that and then resend.

vmjl
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
