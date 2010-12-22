From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] OMAP3&4: Fixes in setup/suspend/powerdomain
Date: Tue, 21 Dec 2010 20:43:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012212039260.1446@utopia.booyaka.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1818379575-1292989389=:1446"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41137 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0LVDnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 22:43:10 -0500
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, rnayak@ti.com, santosh.shilimkar@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1818379575-1292989389=:1446
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra, Santosh, Beno=EEt, Kevin,

On Mon, 13 Dec 2010, Benoit Cousson wrote:

> This is a series of fixes on OMAP3/4 in setup apis,
> in the suspend framework and in powerdomain modelling
> for OMAP4.
>=20
> The series is based on your power domain series and is available here:
> git://gitorious.org/omap-pm/linux.git for_2.6.38/power
>=20
> Tested on 4430sdp + ES2.0 with omap2plus_defconfig.
> Tested on 3430sdp - validate OFF in suspend, with omap3_pm_defconfig
> from Kevin's tree.
> Tested on 2430sdp after fixing the break on linux-omap master.
> See http://www.spinics.net/lists/linux-omap/msg42050.html

Thanks, queued for 2.6.38 in the 'omap4_pm_clk_pwrdm_a_2.6.38' branch of=20
git://git.pwsan.com/linux-2.6.  I used the v2 versions of the first and=20
second patches.

Also added to the integration branch at tag=20
'integration-2.6.38-20101221-009' of git://git.pwsan.com/linux-integration


- Paul
--155748971-1818379575-1292989389=:1446--
