From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v7 2/5] OMAP: McBSP: Modify macros/functions API for easy cache access
Date: Mon, 14 Dec 2009 11:11:27 +0100
Message-ID: <200912141111.29392.jkrzyszt@tis.icnet.pl>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BC141E94@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:41230 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755719AbZLNKLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 05:11:48 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC141E94@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Monday 14 December 2009 07:05:06 Varadarajan, Charu Latha napisa=C5=82(=
a):
> <snip>
>
> >> >@@ -612,7 +597,6 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
> >> > int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
> >> > {
> >> > 	struct omap_mcbsp *mcbsp;
> >> >-	void __iomem *base;
> >> >
> >> > 	if (!omap_mcbsp_check_valid_id(id)) {
> >> > 		printk(KERN_ERR "%s: Invalid id (%d)\n",
> >> >__func__, id + 1);
> >> >@@ -620,28 +604,25 @@ int omap_mcbsp_pollwrite(unsigned int id
> >> > 	}
> >> >
> >> > 	mcbsp =3D id_to_mcbsp_ptr(id);
> >> >-	base =3D mcbsp->io_base;
> >> >
> >> >-	OMAP_MCBSP_WRITE(base, DXR1, buf);
> >> >+	MCBSP_WRITE(mcbsp, DXR1, buf);
> >>
> >> OMAP3/4 allows 32 bit data access also.
> >> How is it taken care?
> >
> >Not at all in case of those several particular changes above.
> >I'm pretty sure
> >that just replacing old OMAP_MCBSP_WRITE(base, ...) with new
> >MCBSP_WRITE(mcbsp, ...) changed nothing in terms of OMAP3/4
> >32-bit data
> >access. Again, beyond the scope.
> >
> >> Please refer to
> >> http://patchwork.kernel.org/patch/54896/ for more details.
> >>
> >> Quoting Tony's words:
> >> "To me it smells like the all drivers using the the
> >> omap_mcbsp_pollread/write are broken legacy drivers.
> >> So maybe we should just remove these two functions?
> >> If we really want to keep these around, we should review
> >> the drivers using these functions. "
> >
> >Please have a look at patch 1/5, there readw()/writew() has
> >been replaced with
> >OMAP_MCBSP_READ()/_WRITE() inside
> >omap_mcbsp_pollwrite()/_pollread(). If you
> >think there is something wrong with it, please comment that
> >patch, not this
> >one that changes nothing related here, I believe.
>
> The point here is to review the driver before pushing any patch
> touching these functions.
>
> <snip>

If these functions are obsolete and going to be removed, I don't think =
it=20
could be of any importance whether they are modified before removal or =
not.=20
Otherwise, a solution seems simple to me: you submit a patch that addre=
sses=20
all concearns, yours, Tony's (BTW, have you already reviewed the driver=
s as=20
Tony suggested?), maybe others. Then, after your patch is accepted for=20
inclusion and it appears in conflict with this series still not applied=
 for=20
any reason (possibly waiting for your changes if that decided), Jarkko,=
 or=20
Tony, or anyone else pointed out by Tony, decides which one goes first =
and=20
which is going to be refreshed on top of the other. Does it sound like =
a good=20
plan for you?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
