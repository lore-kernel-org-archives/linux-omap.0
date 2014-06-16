From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for
 v3.16
Date: Mon, 16 Jun 2014 11:17:43 +0100
Message-ID: <20140616101743.GO14323@lee--X1>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
 <20140528071313.GH4227@lee--X1>
 <20140528180607.GB4707@atomide.com>
 <20140602163841.GC11004@atomide.com>
 <20140603080632.GC3060@lee--X1>
 <20140612054348.GC17845@atomide.com>
 <20140612074705.GB11421@lee--X1>
 <20140612080030.GD17845@atomide.com>
 <20140612083357.GB14323@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35552 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbaFPKRs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 06:17:48 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so2741890igq.15
        for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2014 03:17:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140612083357.GB14323@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> > > > Still not seeing this branch being merged..
> > >=20
> > > Oh crap, I see what's happened and it's completely my fault.
> > >=20
> > > If you read the final merge commit carefully:
> > >=20
> > > 28fee3f: ("Merge branches 'ib-from-asoc-3.16', 'ib-from-pm-3.16',
> > > 'ib-from-regulator-3.16', 'ib-mfd-gpio-3.16' and
> > > 'ib-mfd-mmc-memstick-3.16', tags 'ib-mfd-extcon-3.16',
> > > 'ib-mfd-omap-3.16' and 'ib-mfd-regulator-3.16' into
> > > ibs-for-mfd-merged")
> > >=20
> > > I appear to have a _branch_ AND a _tag_ called ib-mfd-omap-3.16 a=
nd it
> > > looks like Git has taken the tag as a preference. heads/ib-mfd-om=
ap-3.16
> > > is actually at tag/ib-mfd-omap-3.16-1 (notice the appended '-1'),
> > > which contains your most recent patches.  Since I created the MFD=
-OMAP
> > > shared branch I have changed the naming convention to avoid this =
sort
> > > of ambiguity.  I'll send a second MFD pull-request to Linus today=
=2E
> >=20
> > Heh OK yeah I've hit that also at some point :)
> > =20
> > > Sorry Tony.
> >=20
> > No problem, good to hear you got it figured out.
>=20
> Pull-request sent.  Hopefully it's sorted now.

bae14e7a2dcb726476b5020396923a24ccc4c40b

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
