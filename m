From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: Extend clock data.
Date: Thu, 30 Sep 2010 02:57:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009300247170.5439@utopia.booyaka.com>
References: <1285833630-23044-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-598310944-1285837076=:5439"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57445 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab0I3I56 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 04:57:58 -0400
In-Reply-To: <1285833630-23044-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-598310944-1285837076=:5439
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Thara,

On Thu, 30 Sep 2010, Thara Gopinath wrote:

> This patch extends the OMAP4 clock data to include
> various x2 clock nodes as the clock framework
> skips a *2 whie calculating the dpll locked frequency.
>=20
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Currently the framework is extended to include x2 nodes
> only for a few clocks critical for OMAP4 DVFS. This
> exercise needs to be done for most of the other post divider
> clocks as and when necessary.

Beno=EEt and I have been discussing this - I think we should probably fix=
=20
this problem for all of the DPLLs and HSDIVIDERs in one patch.  I'll let=20
Beno=EEt comment further, but I think the current plan will be to generate =
a=20
CLKOUTX2 node after the DPLLs, and then to use that as the parent for=20
the various HSDIVIDERs that use that X2 output.

Also, I think we should make this change in a consistent way with regards=
=20
to what the autogeneration scripts should generate.  This way, we won't=20
have to redo it later and cause unnecessary patch noise.

Perhaps you can help Beno=EEt update the autogeneration scripts for the=20
above changes?


- Paul
--155748971-598310944-1285837076=:5439--
