From: Tony Lindgren <tony@atomide.com>
Subject: Re: kexec on Nokia Internet Tablets
Date: Tue, 17 Feb 2009 14:09:36 -0800
Message-ID: <20090217220936.GD11928@atomide.com>
References: <20090217213228.GH24800@guug.org> <20090217214612.GB11928@atomide.com> <20090217215848.GJ24800@guug.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51738 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbZBQWJj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 17:09:39 -0500
Content-Disposition: inline
In-Reply-To: <20090217215848.GJ24800@guug.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Otto Solares <solca@guug.org>
Cc: linux-omap@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Otto Solares <solca@guug.org> [090217 13:59]:
> On Tue, Feb 17, 2009 at 01:46:12PM -0800, Tony Lindgren wrote:
> > * Otto Solares <solca@guug.org> [090217 13:37]:
> > > Hi all!
> > > 
> > > I want to make kexec work on current Nokia Internet Tablets but
> > > maybe someone here have a clue or better if a patch :)
> > 
> > Do you need to patch anything for this, or does it work out of the box?
> 
> Tried with l-o out of the box and tried too with this patch applied but same
> results so far:
> 
> http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-jaunty.git;a=commit;h=6cd8dd766aec17ce66aa4f732928d05534da0937
> 
> Although it seems it was reverted here:
> 
> http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-jaunty.git;a=commit;h=484b70239a16c01d706a82e5e4afe2f82f24d950

OK, thanks for the links.

> > > When I run a kexec enabled linux-omap kernel and try to boot the
> > > production Maemo kernel or a linux-omap kernel I only succeed if
> > > the serial-console flag in r&d mode is set, if not the device
> > > just hangs.
> > 
> > Sounds like something does not get correctly initialized..
> > 
> > > It seems as a timing problem because if I insert small delays to
> > > the kexeced kernel via CONFIG_BOOT_PRINTK_DELAY it works too 
> > > without the serial-console flag set.
> > > 
> > > Any idea what to debug or where to start?
> > 
> > Well since the LCD is on, you could write a little function that
> > writes the output to the LCD. You just need to find out the virtual
> > address of the LCD and then add a function for displaying fonts..
> > Pretty easy to do.
> 
> Ok, btw do you known a function name I should patch with the debugging
> output?

We have the DEBUG_LL patch in l-o tree that's for low-level debug
output to serial port. You could could add a function called
printlcd() and call that instead of printascii().

> > BTW, do you have some Maemo package for kexec?
> 
> Nope, although I host a userland patch and the statically compiled binary
> here:
> 
> http://guug.org/nit/kexec/

Great, it would be nice to switch between Maemo and whatever easily.

Tony

--ew6BAiZeqk4r7MaW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="debug-ll.patch"

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
 
@@ -668,6 +672,9 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	printed_len += vscnprintf(printk_buf + printed_len,
 				  sizeof(printk_buf) - printed_len, fmt, args);
 
+#ifdef	CONFIG_DEBUG_LL
+	printascii(printk_buf);
+#endif
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide

--ew6BAiZeqk4r7MaW--
