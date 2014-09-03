From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to
 not conflict with regulators
Date: Wed, 03 Sep 2014 10:38:32 +0200
Message-ID: <5406D388.5050104@linutronix.de>
References: <20140819152405.GA12002@atomide.com> <20140902082931.GA32460@breakpoint.cc> <20140903002445.GD11766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42198 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbaICIik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 04:38:40 -0400
In-Reply-To: <20140903002445.GD11766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Lee Jones <lee.jones@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/03/2014 02:24 AM, Tony Lindgren wrote:
> I assume you mean beagleboard-ab, not beaglebone-ab :)

you assume correct.

>> reverting this commit on top of -rc3 makes mmc0 work again.
> 
> Again, I assume you're talking about reverting daebabd57,
> not 43fef47f94a1. Anyways, here's a debug hack I used earlier to

Yes, I reverted daebabd57 which was pointed to me by git bisect.

> dump out the twl configuration in late_initcall and via sysfs
> so maybe try that and see what the values are with working
> and non-working case?

good.txt and bad.txt are from the late_initcall.

 $ diff -u good.txt bad.txt
--- good.txt    2014-09-03 10:29:58.920317368 +0200
+++ bad.txt     2014-09-03 10:28:57.064313222 +0200
@@ -1,13 +1,13 @@
  1: addr: 0x0017 grp: 0x0000 type: 0x0000 remap: 0x0008
- 2: addr: 0x001b grp: 0x0000 type: 0x0000 remap: 0x0008
- 3: addr: 0x001f grp: 0x0000 type: 0x0000 remap: 0x0008
+ 2: addr: 0x001b grp: 0x002e type: 0x0000 remap: 0x0008
+ 3: addr: 0x001f grp: 0x002e type: 0x0000 remap: 0x0008
  4: addr: 0x0023 grp: 0x0000 type: 0x0000 remap: 0x0008
  5: addr: 0x0027 grp: 0x002e type: 0x0000 remap: 0x0008
  6: addr: 0x002b grp: 0x0000 type: 0x0000 remap: 0x0008
  7: addr: 0x002f grp: 0x002e type: 0x000b remap: 0x0000
  8: addr: 0x0033 grp: 0x002e type: 0x0000 remap: 0x0008
  9: addr: 0x0037 grp: 0x002e type: 0x0000 remap: 0x0008
-10: addr: 0x003b grp: 0x0000 type: 0x0000 remap: 0x0008
+10: addr: 0x003b grp: 0x002e type: 0x0000 remap: 0x0008
 11: addr: 0x003f grp: 0x00ef type: 0x0011 remap: 0x0008
 12: addr: 0x0043 grp: 0x00ef type: 0x0010 remap: 0x0008
 13: addr: 0x0047 grp: 0x00ef type: 0x0011 remap: 0x0008
@@ -17,12 +17,8 @@
 17: addr: 0x0071 grp: 0x0000 type: 0x0000 remap: 0x0008
 18: addr: 0x0074 grp: 0x0000 type: 0x0000 remap: 0x0008
 19: addr: 0x0077 grp: 0x00ef type: 0x0000 remap: 0x0008
-mmc0: host does not support reading read-only switch. assuming
write-enable.
 20: addr: 0x007a grp: 0x0000 type: 0x0000 remap: 0x0000
-mmc0: new high speed SDHC card at address 1234
-mmcblk0: mmc0:1234 SA04G 3.63 GiB
 21: addr: 0x007f grp: 0x00ef type: 0x000a remap: 0x0008
- mmcblk0: p1 p2 p3
 22: addr: 0x0082 grp: 0x00ee type: 0x0008 remap: 0x0008
 23: addr: 0x0085 grp: 0x00af type: 0x0013 remap: 0x0000
 24: addr: 0x0088 grp: 0x00ef type: 0x000e remap: 0x0008


> 
> Regards,
> 
> Tony

Sebastian
