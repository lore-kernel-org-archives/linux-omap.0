From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap defconfig changes for v3.20
Date: Tue, 20 Jan 2015 10:25:39 -0800
Message-ID: <18984.8557035022$1421778576@news.gmane.org>
References: <pull-1421777718-852183>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58122 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751713AbbATS3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 13:29:31 -0500
In-Reply-To: <pull-1421777718-852183>
In-Reply-To: <pull-1421777718-852183>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/defconfig-modular

for you to fetch changes up to 697549cdd637841e7c88d0014fe25dfbb72565de:

  ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD support (2015-01-20 09:46:31 -0800)

----------------------------------------------------------------
Defconfig changes for omap2plus_defconfig to make it more modular,
and to add few more drivers found on various boards.

----------------------------------------------------------------
Felipe Balbi (2):
      ARM: omap2plus_defconfig: reduce zImage size on omap2plus_defconfig
      ARM: omap2plus_defconfig: enable TPS65218 power button

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable misc options for BeagleBoard-X15 platform

Sjoerd Simons (1):
      ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD support

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Enable support for davinci_emac
      ARM: omap2plus_defconfig: Add NOR flash support
      ARM: omap2plus_defconfig: Enable pcf857x

 arch/arm/configs/omap2plus_defconfig | 128 +++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 44 deletions(-)
