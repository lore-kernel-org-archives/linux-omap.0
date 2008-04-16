From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: CLKFW: Initial sysfs support for omap
	clock framework
Date: Wed, 16 Apr 2008 13:51:19 -0700
Message-ID: <20080416205119.GF17055@atomide.com>
References: <1208335478-19816-1-git-send-email-Hiroshi.DOYU@nokia.com> <200804160958.17439.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55843 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYDPUvX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 16:51:23 -0400
Content-Disposition: inline
In-Reply-To: <200804160958.17439.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080416 09:58]:
> On Wednesday 16 April 2008, Hiroshi DOYU wrote:
> > =A0 =A0 =A0 =A0 omap:~# tree -d /sys/kernel/clock/omap_32k_fck/
> > =A0 =A0 =A0 =A0 /sys/kernel/clock/omap_32k_fck/
> > =A0 =A0 =A0 =A0 |-- gpt10_fck
> > =A0 =A0 =A0 =A0 |-- gpt11_fck
> > =A0 =A0 =A0 =A0 |-- gpt1_fck
> > =A0 =A0 =A0 =A0 |-- per_32k_alwon_fck
> > =A0 =A0 =A0 =A0 | =A0 |-- gpio3_fck
> > =A0 =A0 =A0 =A0 | =A0 |-- gpio4_fck
> > =A0 =A0 =A0 =A0 | =A0 |-- gpio5_fck
> > =A0 =A0 =A0 =A0 | =A0 `-- gpio6_fck
> > =A0 =A0 =A0 =A0 |-- ts_fck
> > =A0 =A0 =A0 =A0 `-- wkup_32k_fck
> > =A0 =A0 =A0 =A0 =A0 =A0 `-- gpio1_fck
> >=20
> > =A0 =A0 =A0 =A0 11 directories
> >=20
> > =A0 =A0 =A0 =A0 omap:~# tree /sys/kernel/clock/omap_32k_fck/gpt10_f=
ck
> > =A0 =A0 =A0 =A0 /sys/kernel/clock/omap_32k_fck/gpt10_fck
> > =A0 =A0 =A0 =A0 |-- flags
> > =A0 =A0 =A0 =A0 |-- rate
> > =A0 =A0 =A0 =A0 `-- usecount
>=20
> Does this need to be in sysfs?  I'd think debugfs would be
> more appropriate ... that information isn't needed for normal
> operation.
>=20
> Appended is a small patch I've been carrying around.  This
> doesn't move the clocks info from procfs to debugfs, but
> that'd be an easy patch.  (Probably needs minor updates given
> the recent clocktree changes, but it still applies.  The
> coupling to the device tree is a bit weak, and I'd think
> displaying power domains would be useful too.)

Yeah, debugfs would be best. And that /proc/clocks entry will
disappear once that's available (it's currently only in l-o tree).

Tony

> - Dave
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
> Make /proc/omap_clocks show the clock hierarchy through indentation,
> and the ids for devices (like i2c and spi; but oddly not uart, gpt,
> mcbsp, or wdt) with multiple instances.
>=20
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  arch/arm/plat-omap/clock.c |   23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> --- a/arch/arm/plat-omap/clock.c	2007-11-23 18:29:46.000000000 -0800
> +++ b/arch/arm/plat-omap/clock.c	2007-11-23 18:45:44.000000000 -0800
> @@ -465,13 +465,30 @@ static void omap_ck_stop(struct seq_file
>  {
>  }
> =20
> -int omap_ck_show(struct seq_file *m, void *v)
> +/* show clock hierarchy */
> +static void omap_cktree_show(struct seq_file *m, unsigned n, struct =
clk *p)
>  {
>  	struct clk *cp;
> =20
> -	list_for_each_entry(cp, &clocks, node)
> -		seq_printf(m,"%s %ld %d\n", cp->name, cp->rate, cp->usecount);
> +	if (p) {
> +		seq_printf(m, "%*s%-*s %9ld Hz, use %2d",
> +			n, "", 30 - n, p->name,
> +			p->rate, p->usecount);
> +		if (p->id)
> +			seq_printf(m, " (id %d)", p->id);
> +		seq_printf(m, "\n");
> +		n +=3D 2;
> +	}
> =20
> +	list_for_each_entry(cp, &clocks, node) {
> +		if (cp->parent =3D=3D p)
> +			omap_cktree_show(m, n, cp);
> +	}
> +}
> +
> +static int omap_ck_show(struct seq_file *m, void *v)
> +{
> +	omap_cktree_show(m, 0, NULL);
>  	return 0;
>  }
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
