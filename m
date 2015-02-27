From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bluetooth on n900 -- working patch
Date: Fri, 27 Feb 2015 21:44:03 +0100
Message-ID: <20150227204403.GA17650@amd>
References: <20150211104136.GA1788@amd>
 <201502272015.00226@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49330 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbbB0UoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 15:44:09 -0500
Content-Disposition: inline
In-Reply-To: <201502272015.00226@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

Hi!

> > Here's current version of the bluetooth patch, I hope I did
> > not miss anything. This time including dts changes, so that
> > driver is active.
> > 
> > I have firmware in /lib/firmware/nokia/bcmfw.bin
> > 
> > Best regards,
> > 								Pavel
> > 
> 
> Do you have userspace application for initializing mac address?

bluez-5.26 should be able to do the trick. Non-mandatory patch below.

I'm using

../bluez-5.26/tools/btmgmt public-addr 01:02:03:04:05:06

diff -ur bluez-5.26.ofic/tools/btmgmt.c bluez-5.26/tools/btmgmt.c
--- bluez-5.26.ofic/tools/btmgmt.c	2014-12-14 12:32:19.742595000 +0100
+++ bluez-5.26/tools/btmgmt.c	2014-12-14 20:06:40.432497973 +0100
@@ -2603,7 +2603,7 @@
 
 static void static_addr_usage(void)
 {
-	printf("Usage: btmgmt static-addr <address>\n");
+	printf("Usage: btmgmt static-addr ??:??:??:??:??:??\n");
 }
 
 static void cmd_static_addr(struct mgmt *mgmt, uint16_t index,
@@ -2660,7 +2660,8 @@
 	struct mgmt_cp_set_public_address cp;
 
 	if (argc < 2) {
-		printf("Usage: btmgmt public-addr <address>\n");
+		printf("Usage: btmgmt public-addr ??:??:??:??:??:??\n"
+		       "Note: interface must be down for this to work\n");
 		exit(EXIT_FAILURE);
 	}
 
@@ -2934,7 +2935,7 @@
 
 static void add_device_usage(void)
 {
-	printf("Usage: btmgmt add-device [-a action] [-t type] <address>\n");
+	printf("Usage: btmgmt add-device [-a action] [-t type] ??:??:??:??:??:??\n");
 }
 
 static struct option add_device_options[] = {
@@ -3007,7 +3008,7 @@
 
 static void del_device_usage(void)
 {
-	printf("Usage: btmgmt del-device [-t type] <address>\n");
+	printf("Usage: btmgmt del-device [-t type] ??:??:??:??:??:??\n");
 }
 
 static struct option del_device_options[] = {
@@ -3153,7 +3154,7 @@
 
 	printf("\n"
 		"For more information on the usage of each command use:\n"
-		"\tbtmgmt <command> --help\n" );
+		"\tbtmgmt <command>\n" );
 }
 
 static struct option main_options[] = {
Only in bluez-5.26/tools: btmgmt.c~




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
