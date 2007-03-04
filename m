From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] add ssi/Kconfig to arch/arm/Kconfig
Date: Sun, 04 Mar 2007 13:30:41 +0100
Message-ID: <85ps7pgphq.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--=-=-=


If one wants to use ssi/Kconfig on arm, it should be added to
arch/arm/Kconfig.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=ssi_kconfig.patch

---
 arch/arm/Kconfig |    2 	2 +	0 -	0 !
 1 file changed, 2 insertions(+)

Index: linux-omap-2.6/arch/arm/Kconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/Kconfig	2007-03-02 22:41:27.000000000 +0100
+++ linux-omap-2.6/arch/arm/Kconfig	2007-03-02 22:41:39.000000000 +0100
@@ -991,6 +991,8 @@ if ARCH_OMAP
 source "drivers/cbus/Kconfig"
 endif
 
+source "drivers/ssi/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
