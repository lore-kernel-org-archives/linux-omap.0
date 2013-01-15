From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Tue, 15 Jan 2013 09:16:39 +0100
Message-ID: <50F51067.5090008@ti.com>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58436 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab3AOIQq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Jan 2013 03:16:46 -0500
In-Reply-To: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chuansheng Liu <chuansheng.liu@intel.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Paul,

On 01/14/2013 06:59 PM, Paul Walmsley wrote:
> Failing tests: needing investigation
> ------------------------------------
>=20
> Build tests:
>=20
> * rmk_3430_ldp_allnoconfig, rmk_4430_sdp_allnoconfig: twl4030 build f=
ailures
>   - in drivers/mfd/twl-core.c

The following patch fixes these:
https://lkml.org/lkml/2012/12/24/3


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
