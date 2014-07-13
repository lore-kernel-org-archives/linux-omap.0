From: Nick Krause <xerofoify@gmail.com>
Subject: Fix Me in file gpmc-onenand.c
Date: Sun, 13 Jul 2014 17:06:20 -0400
Message-ID: <CAPDOMVhMeqHzRsae-TqeNsO2hQF9gE9au9y2oMPohVHOXrs70A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:64606 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaGMVGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Jul 2014 17:06:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hey Kevin,
I am using cscope to find fix mes in the latest git kernels that still
need cleanup. Furthermore  I seem to hitting one in a that file that
you maintain.
Due to this I am wondering should I remove this code or does it still
need to be in the mainline kernel and what mach-omap2 cpus does it
check for.
to support with this if statement.  I am pasting the FiXME and the
code that code around it.
Cheers Nick
else {
               /*
                * FIXME: Appears to be legacy code from initial ONENAND commit.
                 * Unclear what boards this is for and if this can be removed.
                 */
               if (!cpu_is_omap34xx())
                       onenand_sync.wait_on_read = true;
         }
