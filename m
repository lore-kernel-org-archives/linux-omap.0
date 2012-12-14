From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] ARM: OMAP4: clock data fixes for early 3.8-rc
Date: Fri, 14 Dec 2012 00:32:48 -0700
Message-ID: <20121214072028.24383.41000.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56601 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2LNHfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 02:35:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

A few bugs in the OMAP4 common clock framework data caused boot-time
warnings on OMAP4460 PandaBoard-ES; these patches fix those.  They
apply after the arm-soc merge during pre-3.8-rc1.

Also needed are Jon Hunter's clock fixes series; the pull request will
combine his patches and this series.


- Paul

---

Paul Walmsley (2):
      ARM: OMAP4: clock data: div_iva_hs_clk is a power-of-two divider
      ARM: OMAP4: clock data: DPLLs are missing bypass clocks in their parent lists


 arch/arm/mach-omap2/cclock44xx_data.c |   37 +++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 9 deletions(-)

