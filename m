From: Drew Moseley <dmoseley@mvista.com>
Subject: Need to call kgdb8250_add_platform_port in omap_serial_init()?
Date: Thu, 11 Oct 2007 10:56:04 -0700
Message-ID: <470E63B4.40103@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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


The patch below calls kgdb8250_add_platform_port() from omap_serial_init().
This is copied from mach-omap/serial.c.  Without this patch kgdbwait
will fail.

Comments?

Drew



Index: linux/arch/arm/mach-omap2/serial.c
===================================================================
--- linux.orig/arch/arm/mach-omap2/serial.c
+++ linux/arch/arm/mach-omap2/serial.c
@@ -162,6 +162,9 @@ void __init omap_serial_init()
 		}

 		omap_serial_reset(p);
+#ifdef CONFIG_KGDB_8250
+		kgdb8250_add_platform_port(i, &serial_platform_data[i]);
+#endif
 	}
 }


-- 
mailto:dmoseley@mvista.com
