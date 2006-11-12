From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH] ARM: OMAP: OMAP310 i2c fix
Date: Sun, 12 Nov 2006 19:30:35 +0100
Message-ID: <200611121930.36087.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Mh2VFw0Gk8JeGO9"
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

--Boundary-00=_Mh2VFw0Gk8JeGO9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

when I turned on i2c on my omap310 based palmz71 and booted the kernel, it=
=20
hanged. I=B4ve tracked the place where it hangs and fixed it. Here=B4s the =
small=20
patch.

--Boundary-00=_Mh2VFw0Gk8JeGO9
Content-Type: text/x-diff; charset="us-ascii"; name="omap310-i2c-no-hang.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap310-i2c-no-hang.patch"

diff -Naur linux-omap-current/arch/arm/plat-omap/dsp/dsp_common.c linux-omap/arch/arm/plat-omap/dsp/dsp_common.c
--- linux-omap-current/arch/arm/plat-omap/dsp/dsp_common.c	2006-11-12 11:24:41.000000000 +0100
+++ linux-omap/arch/arm/plat-omap/dsp/dsp_common.c	2006-11-12 12:30:55.000000000 +0100
@@ -273,7 +273,7 @@
 
 	dspmem_size = 0;
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		dspmem_base = OMAP1510_DSP_BASE;
 		dspmem_size = OMAP1510_DSP_SIZE;
 		daram_base = OMAP1510_DARAM_BASE;

--Boundary-00=_Mh2VFw0Gk8JeGO9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_Mh2VFw0Gk8JeGO9--
