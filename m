From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Tue, 31 Mar 2009 07:50:14 -0700
Message-ID: <20090331145013.GB1685@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB085D68@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB02FB085DF0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB085DF0@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Gadiyar, Anand <gadiyar@ti.com> [090331 06:38]:
> > > * Tony Lindgren <tony@atomide.com> [090316 11:14]:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090315 08:48]:
> > > > > On Sun, Mar 15, 2009 at 03:47:01PM +0000, Russell King - ARM Linux wrote:
> > > > > > On Fri, Mar 13, 2009 at 03:47:26PM -0700, Tony Lindgren wrote:
> > > > > > > +#include <mach/mcspi.h>
> > > > > > > +#include <mach/gpio.h>
> > > > > > 
> > > > > > Shouldn't this be linux/gpio.h ?
> > > > > 
> > > > > Note that Syed Mohammed Khasim <x0khasim@ti.com> address is not valid.
> > > > 
> > > > Thanks, updated patch below.
> > > 
> > > Oops, forgot to run stg refresh before sending out this, v3 below
> > > 
> > > Tony
> > > 
> > 
> > Tony, Russell,
> > 
> > Sorry for not catching this before it got merged.
> > 
> > I could not run the 3430 SDP defconfig from mainline. The image hangs at
> > "Starting kernel ...". Enabling CONFIG_DEBUG_LL does not help.
> >  
> > The omap_3430sdp_defconfig seems to have too many differences from the
> > defconfigs for other OMAP3 boards. In fact, it's not even similar to the
> > file present in the linux-omap tree.
> > 
> > So I took the SDP defconfig from the l-o tree and replaced the one on
> > mainline with it. And we have a compile break in a display file. Removing
> > CONFIG_FB_OMAP works around the compile break.
> > 
> > Please consider merging this patch (l-o SDP defconfig minus CONFIG_FB_OMAP)
> > so that we can finally use an SDP with mainline.
> > 
> 
> 
> Oops. Now, this doesn't work for me either. Sorry for the noise.

What do you get with CONFIG_DEBUG_LL and the attached hack applied?

Tony

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="debug-ll.hack"

--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -44,6 +44,10 @@ void asmlinkage __attribute__((weak)) early_printk(const char *fmt, ...)
 
 #define __LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
 
+#ifdef CONFIG_DEBUG_LL
+extern void printascii(char *);
+#endif
+
 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
 
@@ -667,6 +671,9 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	printed_len += vscnprintf(printk_buf + printed_len,
 				  sizeof(printk_buf) - printed_len, fmt, args);
 
+#ifdef	CONFIG_DEBUG_LL
+	printascii(printk_buf);
+#endif
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--/04w6evG8XlLl3ft--
