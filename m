From: Anil Kumar <anilk4.v@gmail.com>
Subject: [PATCH 0/2] arm/dts: OMAP3: Add gpmc DT node support
Date: Sat, 16 Feb 2013 17:08:26 +0530
Message-ID: <1361014708-1659-1-git-send-email-anilk4.v@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, grant.likely@secretlab.ca, zonque@gmail.com, thomas@tomweber.eu, anilk4.v@gmail.com
List-Id: linux-omap@vger.kernel.org

Add gpmc DT node in dtsi file.
Add nand DT node and partitions information for devkit8000.

This series is based on top of branch =E2=80=9Comap-for-v3.9/gpmc=E2=80=
=9D git tree=20
http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
and patches.

Anil Kumar:-
ARM: dts: add minimal DT support for DevKit8000

Jon Hunter:-=20
  ARM: OMAP2+: Fix-up gpmc merge error

Done basic testing:-
 - #cat /proc/mtd     (shows nand partitions)=20
 - Nand partitions by command line.

Anil Kumar (2):
  ARM: dts: omap3: Add gpmc node
  ARM: dts: omap3-devkit8000: add nand dt node

 arch/arm/boot/dts/omap3-devkit8000.dts |   52 ++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/omap3.dtsi           |   11 +++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
