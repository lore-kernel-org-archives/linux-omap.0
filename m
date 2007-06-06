From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [Patch 4/4] Updating TLB entry for ARM V7
Date: Tue, 5 Jun 2007 19:26:52 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701120B45@dlee13.ent.ti.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Updating TLB entry for ARM V7. Derived from ARM GIT

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 include/asm-arm/tlbflush.h
 1 files changed, 13 insertions(+)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/include/asm-arm/tlbflush.h	2007-05-25 13:27:14.000000000 =
-0500
+++ val_3430_GIT/include/asm-arm/tlbflush.h	2007-06-05 =
16:10:23.000000000 -0500
@@ -138,6 +138,19 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
=20
+#ifdef CONFIG_CPU_TLB_V7
+# define v7wbi_possible_flags	v6wbi_tlb_flags
+# define v7wbi_always_flags	v6wbi_tlb_flags
+# ifdef _TLB
+#  define MULTI_TLB 1
+# else
+#  define _TLB v7wbi
+# endif
+#else
+# define v7wbi_possible_flags	0
+# define v7wbi_always_flags	(-1UL)
+#endif
+
 #ifndef _TLB
 #error Unknown TLB model
 #endif
