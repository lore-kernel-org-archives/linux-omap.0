From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for
 v3.16
Date: Tue, 3 Jun 2014 09:06:32 +0100
Message-ID: <20140603080632.GC3060@lee--X1>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
 <20140528071313.GH4227@lee--X1>
 <20140528180607.GB4707@atomide.com>
 <20140602163841.GC11004@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37623 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbaFCIG7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2014 04:06:59 -0400
Received: by mail-ie0-f177.google.com with SMTP id y20so5354266ier.8
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2014 01:06:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140602163841.GC11004@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 02 Jun 2014, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140528 11:11]:
> > * Lee Jones <lee.jones@linaro.org> [140528 00:14]:
> > > Thanks Tony, here's the pull-request:
> > >=20
> > > The following changes since commit 455c6fdbd219161bd09b1165f11699=
d6d73de11c:
> > >=20
> > >   Linux 3.14 (2014-03-30 20:40:15 -0700)
> > >=20
> > > are available in the git repository at:
> > >=20
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/=
mfd-omap-v3.16-1
> > >=20
> > > for you to fetch changes up to 43fef47f94a1ae46fb2720dada32fa3b55=
47bee2:
> > >=20
> > >   mfd: twl4030-power: Add a configuration to turn off oscillator =
during off-idle (2014-05-28 08:06:18 +0100)
> > >=20
> > > ----------------------------------------------------------------
> > > Second immutable branch between MFD and OMAP due for the v3.16 me=
rge window.
> >=20
> > Thanks a lot, this will make it easier for me to chase down potenti=
al
> > PM related regressions ;) I'm merging this for testing only into th=
e
> > linux-omap master branch, no need for me to include it into any
> > of my upstream heading branches.
>=20
> Lee, I'm not seeing this in linux next, did you maybe forget to merge
> it into the MFD tree?

I didn't forget, but I didn't do it either. :)

I have re-merged all of the IBs this morning, so should be in -next
by tomorrow.

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
