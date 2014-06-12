From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for
 v3.16
Date: Thu, 12 Jun 2014 09:33:57 +0100
Message-ID: <20140612083357.GB14323@lee--X1>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
 <20140528071313.GH4227@lee--X1>
 <20140528180607.GB4707@atomide.com>
 <20140602163841.GC11004@atomide.com>
 <20140603080632.GC3060@lee--X1>
 <20140612054348.GC17845@atomide.com>
 <20140612074705.GB11421@lee--X1>
 <20140612080030.GD17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40280 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbaFLIeD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2014 04:34:03 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so836867ier.30
        for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2014 01:34:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140612080030.GD17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 12 Jun 2014, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [140612 00:48]:
> > On Wed, 11 Jun 2014, Tony Lindgren wrote:
> >=20
> > > * Lee Jones <lee.jones@linaro.org> [140603 01:08]:
> > > > On Mon, 02 Jun 2014, Tony Lindgren wrote:
> > > > > * Tony Lindgren <tony@atomide.com> [140528 11:11]:
> > > > > > * Lee Jones <lee.jones@linaro.org> [140528 00:14]:
> > > > > > > Thanks Tony, here's the pull-request:
> > > > > > >=20
> > > > > > > The following changes since commit 455c6fdbd219161bd09b11=
65f11699d6d73de11c:
> > > > > > >=20
> > > > > > >   Linux 3.14 (2014-03-30 20:40:15 -0700)
> > > > > > >=20
> > > > > > > are available in the git repository at:
> > > > > > >=20
> > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.g=
it tags/mfd-omap-v3.16-1
> > > > > > >=20
> > > > > > > for you to fetch changes up to 43fef47f94a1ae46fb2720dada=
32fa3b5547bee2:
> > > > > > >=20
> > > > > > >   mfd: twl4030-power: Add a configuration to turn off osc=
illator during off-idle (2014-05-28 08:06:18 +0100)
> > > > > > >=20
> > > > > > > ---------------------------------------------------------=
-------
> > > > > > > Second immutable branch between MFD and OMAP due for the =
v3.16 merge window.
> > > > > >=20
> > > > > > Thanks a lot, this will make it easier for me to chase down=
 potential
> > > > > > PM related regressions ;) I'm merging this for testing only=
 into the
> > > > > > linux-omap master branch, no need for me to include it into=
 any
> > > > > > of my upstream heading branches.
> > > > >=20
> > > > > Lee, I'm not seeing this in linux next, did you maybe forget =
to merge
> > > > > it into the MFD tree?
> > > >=20
> > > > I didn't forget, but I didn't do it either. :)
> > > >=20
> > > > I have re-merged all of the IBs this morning, so should be in -=
next
> > > > by tomorrow.
> > >=20
> > > Still not seeing this branch being merged..
> >=20
> > Oh crap, I see what's happened and it's completely my fault.
> >=20
> > If you read the final merge commit carefully:
> >=20
> > 28fee3f: ("Merge branches 'ib-from-asoc-3.16', 'ib-from-pm-3.16',
> > 'ib-from-regulator-3.16', 'ib-mfd-gpio-3.16' and
> > 'ib-mfd-mmc-memstick-3.16', tags 'ib-mfd-extcon-3.16',
> > 'ib-mfd-omap-3.16' and 'ib-mfd-regulator-3.16' into
> > ibs-for-mfd-merged")
> >=20
> > I appear to have a _branch_ AND a _tag_ called ib-mfd-omap-3.16 and=
 it
> > looks like Git has taken the tag as a preference. heads/ib-mfd-omap=
-3.16
> > is actually at tag/ib-mfd-omap-3.16-1 (notice the appended '-1'),
> > which contains your most recent patches.  Since I created the MFD-O=
MAP
> > shared branch I have changed the naming convention to avoid this so=
rt
> > of ambiguity.  I'll send a second MFD pull-request to Linus today.
>=20
> Heh OK yeah I've hit that also at some point :)
> =20
> > Sorry Tony.
>=20
> No problem, good to hear you got it figured out.

Pull-request sent.  Hopefully it's sorted now.

If there are any more issues I'll sort them out as they appear, but I
may be a little slower than usual as I'm currently on holiday in Spain.

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
