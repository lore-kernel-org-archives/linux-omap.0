From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: hwmod code: convert missing clockdomain
 warnings to debug messages
Date: Wed, 19 Sep 2012 22:48:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192247250.8278@utopia.booyaka.com>
References: <20120918211146.16484.85893.stgit@dusk.lan> <20120918211251.16484.18401.stgit@dusk.lan> <5058ECAF.7010609@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1632437826-1348094905=:8278"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57854 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab2ISWsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 18:48:25 -0400
In-Reply-To: <5058ECAF.7010609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1632437826-1348094905=:8278
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=C3=AEt,

On Tue, 18 Sep 2012, Cousson, Benoit wrote:

> On 9/18/2012 4:12 PM, Paul Walmsley wrote:
> > The decision was made a few months ago to allow struct omap_hwmod
> > records and struct clk records to omit clockdomain information if the
> > clockdomain is not software-controllable.  See for example commit
> > 868c157df9721675c19729eed2c96bac6c3f1d01 ("ARM: OMAP2+: hwmod: remove
> > prm_clkdm, cm_clkdm; allow hwmods to have no clockdomain").
> >=20
> > So convert an existing pr_warning() to a pr_debug() (regarding missing
> > clockdomains in clocks), and add a pr_debug() for missing hwmod
> > clockdomains.
>=20
> At some point I sent you a small RFC to still keep the message if neither
> oh->clkdm nor oh->_clk->clkdm was there. I've never had the time to test =
it,
> but that should then cover OMAP2, 3 & 4 cases.

OK let's plan to test and add something like that during the 3.8 time=20
frame... probably it should also depend on the value of clkdm_control. =20
It's not clear to me exactly what that conditional should look like...


- Paul
--843723315-1632437826-1348094905=:8278--
