From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] WLAN regression fixes for omap4 after moving to DT
 based booting
Date: Fri, 13 Sep 2013 12:09:48 -0700
Message-ID: <20130913190811.24617.97699.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23087 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753552Ab3IMTJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 15:09:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Looks like these two patches are still missing as I did not
update the kernel on my panda for a while but was testing with
my 4430sdp that does not have the WLAN card..

Regards,

Tony

---

Tony Lindgren (2):
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for pandaboard
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze


 arch/arm/boot/dts/omap4-panda-common.dtsi |   46 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap4-sdp.dts           |   39 ++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

-- 
Signature
