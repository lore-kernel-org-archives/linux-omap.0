From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v4 5/5(7)] OMAP1: Amstrad Delta: modify
	defconfig for external keyboard support
Date: Wed, 28 Apr 2010 03:14:27 +0200
Message-ID: <201004280314.28994.jkrzyszt@tis.icnet.pl>
References: <201004280252.58420.jkrzyszt@tis.icnet.pl>
Reply-To: Discussion of the Amstrad E3 emailer hardware/software
	<e3-hacking@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e3-hacking-bounces@earth.li>
In-Reply-To: <201004280252.58420.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
List-Unsubscribe: <http://www.earth.li/cgi-bin/mailman/options/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=unsubscribe>
List-Archive: <http://www.earth.li/pipermail/e3-hacking>
List-Post: <mailto:e3-hacking@earth.li>
List-Help: <mailto:e3-hacking-request@earth.li?subject=help>
List-Subscribe: <http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=subscribe>
Sender: e3-hacking-bounces@earth.li
Errors-To: e3-hacking-bounces@earth.li
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The patch adds a CONFIG directive required for supporting the Amstrad Delta
connected external keyboard by default.

Created and tested against linux-omap master, 
commit 104a77440f05430f29f9d3f4ecb88c1536819585 dated 2010-04-27.

Works on top of PATCH v4 4/5(7), "input: serio: add support for Amstrad Delta 
serial keyboard port".

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v2 changes:
- no functional changes,
- refreshed against linux-2.6.34-rc2.
v3 changes:
- since CONFIG_KEYBOARD_ATKBD and CONFIG_AMS_DELTA_FIQ are now selected 
  automatically, limit defconfig changes to CONFIG_SERIO_AMS_DELTA selection.
v4 changes: none (CONFIG_KEYBOARD_ATKBD=y already present in defconfig).

 arch/arm/configs/ams_delta_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- git.orig/arch/arm/configs/ams_delta_defconfig	2010-04-27 21:40:18.000000000 +0200
+++ git/arch/arm/configs/ams_delta_defconfig	2010-04-27 22:50:58.000000000 +0200
@@ -699,6 +699,7 @@ CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
+CONFIG_SERIO_AMS_DELTA=y
 # CONFIG_GAMEPORT is not set
 
 #
