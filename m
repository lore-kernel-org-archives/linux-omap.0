From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 0/7] musb/tusb6010 fixes for host mode
Date: Fri, 04 May 2007 09:22:50 -0700
Message-ID: <1178295770.2017.67.camel@paris.hilman.org>
References: musb-2007-05-03-164131 <11782105181141-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11782105181141-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2007-05-03 at 16:41 +0000, Tony Lindgren wrote:

> Here are some USB patches that make tusb6010 host mode work
> finally reliably on at least N800. Now all testusb cases pass
> with N800 running as a host.

Tony,

There are some uses of tusb_dma_omap() that are not defined when
compiling for !tusb platforms.  The hack below gets it to compile on
2430, but is probably not "the right thing."

Also, with your fixes, it's still not working on 2430.  Looks like I
have some more digging to do.

Kevin




Index: dev/drivers/usb/musb/musbdefs.h
===================================================================
--- dev.orig/drivers/usb/musb/musbdefs.h
+++ dev/drivers/usb/musb/musbdefs.h
@@ -518,6 +518,10 @@ extern void musb_platform_set_mode(struc
 extern int __init musb_platform_init(struct musb *musb);
 extern int musb_platform_exit(struct musb *musb);
 
+#ifndef tusb_dma_omap
+#define tusb_dma_omap() 0
+#endif
+
 /*-------------------------- ProcFS definitions ---------------------*/
 
 struct proc_dir_entry;
