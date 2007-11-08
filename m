From: "Kamat, Nishant" <nskamat@ti.com>
Subject: [PATCH] Re-enable watchdog menuconfig
Date: Thu, 8 Nov 2007 14:43:48 -0600
Message-ID: <6E3DC4E6E09EF440B55B7AD683608D6D02540D07@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

After the movement of drivers/char/watchdog directory to =
drivers/watchdog, the following patch is necessary to view the WATCHDOG =
option in 'make menuconfig'
for ARM platforms.

Signed-off-by: Nishant Kamat <nskamat@ti.com>
---

Index: linux/arch/arm/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/arm/Kconfig	2007-11-08 14:05:01.000000000 -0600
+++ b/arch/arm/Kconfig	2007-11-08 14:06:25.000000000 -0600
@@ -1053,6 +1053,8 @@
=20
 source "drivers/hwmon/Kconfig"
=20
+source "drivers/watchdog/Kconfig"
+
 source "drivers/ssb/Kconfig"
=20
 #source "drivers/l3/Kconfig"
