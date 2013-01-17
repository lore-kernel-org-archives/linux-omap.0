From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Thu, 17 Jan 2013 18:43:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301171841350.14118@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com> <50F51067.5090008@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1118731500-1358448180=:14118"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41858 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab3AQSnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 13:43:01 -0500
In-Reply-To: <50F51067.5090008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chuansheng Liu <chuansheng.liu@intel.com>, Samuel Ortiz <sameo@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1118731500-1358448180=:14118
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter,

On Tue, 15 Jan 2013, Peter Ujfalusi wrote:

> On 01/14/2013 06:59 PM, Paul Walmsley wrote:
> > Failing tests: needing investigation
> > ------------------------------------
> >=20
> > Build tests:
> >=20
> > * rmk_3430_ldp_allnoconfig, rmk_4430_sdp_allnoconfig: twl4030 build fai=
lures
> >   - in drivers/mfd/twl-core.c
>=20
> The following patch fixes these:
> https://lkml.org/lkml/2012/12/24/3

Thanks, I've added that info in the v3.8-rc3 test summary, and moved the
paragraph to the 'resolved by posted patches' section.


- Paul
--843723315-1118731500-1358448180=:14118--
