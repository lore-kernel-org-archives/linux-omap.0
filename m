From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] to revert the drivers/video/Kconfig changes
Date: Fri, 2 Mar 2007 18:13:15 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47622CC4@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47622CB5@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47622CB5@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

To correct the drivers/video/Kconfig (old style).

 Signed off by:
 Syed Mohammed Khasim (x0khasim@ti.com)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/video/Kconfig	2007-03-02 17:38:12.000000000 -0600
+++ drivers/video/Kconfig	2007-03-02 17:52:15.000000000 -0600
@@ -1635,10 +1635,6 @@ config FB_PS3_DEFAULT_SIZE_M
 	  The default value can be overridden on the kernel command line
 	  using the "ps3fb" option (e.g. "ps3fb=3D9M");
=20
-if ARCH_OMAP
-	source "drivers/video/omap/Kconfig"
-endif
-
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
@@ -1661,9 +1657,7 @@ config FB_VIRTUAL
=20
 	  If unsure, say N.
=20
-if ARCH_OMAP
-	source "drivers/video/omap/Kconfig"
-endif
+source "drivers/video/omap/Kconfig"
=20
 if VT
 	source "drivers/video/console/Kconfig"
