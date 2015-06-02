From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap defconfig changes for v4.2
Date: Tue,  2 Jun 2015 10:22:16 -0700
Message-ID: <28525.0418507077$1433265785@news.gmane.org>
References: <pull-1433265658-688305>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from erouter8.ore.mailhop.org ([54.187.218.212]:28170 "HELO
	outbound3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759019AbbFBRWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 13:22:45 -0400
In-Reply-To: <pull-1433265658-688305>
In-Reply-To: <pull-1433265658-688305>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/o2_dc

for you to fetch changes up to 4cbb08336f506cde30c0dfb3e49c55a52842fb5c:

  ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR (2015-06-02 07:54:50 -0700)

----------------------------------------------------------------
Few omap2plus_defconfig changes for v4.2 merge window:

- Enable dm9000 as built-in for NFSroot

- Enable dm816x USB phy as a loadable module

- Enable Pixcir touch screen as a loadable module

----------------------------------------------------------------
Anthoine Bourgeois (1):
      ARM: omap2plus_defconifg: Enable DM9000 in omap2plus_defconfig

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Add dm816x USB PHY as a loadable module

 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)
