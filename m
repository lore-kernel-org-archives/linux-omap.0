From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][RFT][PATCH 3/4 v6] OMAP: McBSP: Introduce caching in
 register write operations
Date: Tue, 8 Dec 2009 15:39:16 -0800
Message-ID: <20091208233915.GY24013@atomide.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
 <20091208164028.GQ24013@atomide.com>
 <20091208165931.GR24013@atomide.com>
 <200912082046.28642.jkrzyszt@tis.icnet.pl>
 <20091208233247.GX24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62061 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966427AbZLHXjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 18:39:15 -0500
Content-Disposition: inline
In-Reply-To: <20091208233247.GX24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

* Tony Lindgren <tony@atomide.com> [091208 15:32]:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091208 11:45]:
> > Tuesday 08 December 2009 17:59:31 Tony Lindgren napisa=C5=82(a):
> > > * Tony Lindgren <tony@atomide.com> [091208 08:39]:
> > > >
> > > > How about just set the cache size above based on the processor,
> > > > then do kzalloc here:
> > > >
> > > > mcbsp->reg_cache =3D kzalloc(size, GFP_KERNEL);
> > > >
> > > > > +	if (!mcbsp->reg_cache)
> > > > > +		return -ENOMEM;
> > > > > +
> > > >
> > > > That way the kzalloc and error checking are in the same place.
> > >
> > > Actually since we already have mach-omap1/mcbsp.c and mach-omap2/=
mcbsp.c,
> > > it would be best to pass the cache size from omap1_mcbsp_init and
> > > omap2_mcbsp_init. That leaves some of the if cpu_is_omapxxxx() el=
se
> > > stuff.
> >=20
> > Tony,
> > Almost ready with it, one more question: what do you think about sp=
litting and=20
> > moving omap_mcbsp_read()/_write() there as well? If you agree, shou=
ld I=20
> > submit 2 patches, one with this cleanup, the other one actually int=
roducing=20
> > cache support, or is one combined OK?
>=20
> Sounds good to me!

Oh sorry forgot to reply to your question. If a single patch looks unre=
adable,
then split it into two where the first patch splits omap_mcbsp_read/wri=
te.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
