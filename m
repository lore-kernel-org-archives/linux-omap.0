From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: correct the idlemodes for
 spinlock
Date: Thu, 13 Mar 2014 14:09:20 -0700
Message-ID: <20140313210919.GC23432@atomide.com>
References: <1387838928-57745-1-git-send-email-s-anna@ti.com>
 <alpine.DEB.2.02.1312260447320.15949@utopia.booyaka.com>
 <20140313202547.GD5981@atomide.com>
 <alpine.DEB.2.02.1403132101490.25824@utopia.booyaka.com>
 <53221E2C.9040109@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20301 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752823AbaCMVJZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 17:09:25 -0400
Content-Disposition: inline
In-Reply-To: <53221E2C.9040109@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org

* Benoit Cousson <bcousson@baylibre.com> [140313 14:11]:
> Hi Paul,
>=20
> On 13/03/2014 22:02, Paul Walmsley wrote:
> >On Thu, 13 Mar 2014, Tony Lindgren wrote:
> >
> >>* Paul Walmsley <paul@pwsan.com> [131225 20:51]:
> >>>(cc Beno=C3=AEt)
> >>>
> >>>On Mon, 23 Dec 2013, Suman Anna wrote:
> >>>
> >>>>The spinlock module's SYSCONFIG register does not support
> >>>>smart wakeup, so remove this flag from the idle modes in
> >>>>the spinlock hwmod definition.
> >>>>
> >>>>Signed-off-by: Suman Anna <s-anna@ti.com>
> >>>
> >>>Beno=C3=AEt Cousson is the primary maintainer of this file that yo=
u're
> >>>changing:
> >>>
> >>>$ scripts/get_maintainer.pl -f arch/arm/mach-omap2/omap_hwmod_44xx=
_data.c
> >>>"Beno=C3=AEt Cousson" <bcousson@baylibre.com> (maintainer:OMAP HWM=
OD DATA F...)
> >>>Tony Lindgren <tony@atomide.com> (maintainer:OMAP SUPPORT)
> >>>Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
> >>>linux-omap@vger.kernel.org (open list:OMAP HWMOD DATA F...)
> >>>linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHI=
TECT...)
> >>>linux-kernel@vger.kernel.org (open list)
> >>>$
> >>>
> >>>Please make sure that he's part of the address list when patches a=
re sent
> >>>that apply against this file.
> >>
> >>FYI untagging this in my inbox assuming it's being resent or queued=
 by Paul.
> >
> >Hmm, seems like it's either you or Beno=C3=AEt who is on the hook fo=
r this one.
> >
> >Beno=C3=AEt?
> >
> >Am happy to queue it if either of you want.
>=20
> Feel free to queue it, I don't have anything else pending so far, so
> I was not planning to do a pull request.
>=20
> Acked-by: Benoit Cousson <bcousson@baylibre.com>

OK applying into omap-for-v3.15/fixes then, thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
