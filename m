From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][RFT][PATCH 3/4 v6] OMAP: McBSP: Introduce caching in register write operations
Date: Tue, 8 Dec 2009 20:46:27 +0100
Message-ID: <200912082046.28642.jkrzyszt@tis.icnet.pl>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <20091208164028.GQ24013@atomide.com> <20091208165931.GR24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:51529 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965879AbZLHTqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 14:46:35 -0500
In-Reply-To: <20091208165931.GR24013@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Tuesday 08 December 2009 17:59:31 Tony Lindgren napisa=C5=82(a):
> * Tony Lindgren <tony@atomide.com> [091208 08:39]:
> >
> > How about just set the cache size above based on the processor,
> > then do kzalloc here:
> >
> > mcbsp->reg_cache =3D kzalloc(size, GFP_KERNEL);
> >
> > > +	if (!mcbsp->reg_cache)
> > > +		return -ENOMEM;
> > > +
> >
> > That way the kzalloc and error checking are in the same place.
>
> Actually since we already have mach-omap1/mcbsp.c and mach-omap2/mcbs=
p.c,
> it would be best to pass the cache size from omap1_mcbsp_init and
> omap2_mcbsp_init. That leaves some of the if cpu_is_omapxxxx() else
> stuff.

Tony,
Almost ready with it, one more question: what do you think about splitt=
ing and=20
moving omap_mcbsp_read()/_write() there as well? If you agree, should I=
=20
submit 2 patches, one with this cleanup, the other one actually introdu=
cing=20
cache support, or is one combined OK?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
