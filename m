From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Beagle PM hangs
Date: Fri, 30 Jan 2009 15:31:48 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376E9A582@dlee02.ent.ti.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	<87zlhbqtrv.fsf@deeprootsystems.com>	<87skn3qq6x.fsf@deeprootsystems.com>
	<8bf247760901300616k53722fb0if55e2d07c71df10c@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE89671620376DEC131@dlee02.ent.ti.com>
 <87hc3gk9au.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39271 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbZA3Vb5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 16:31:57 -0500
In-Reply-To: <87hc3gk9au.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sriram V <vshrirama@gmail.com>, Peter Reid <ppeter.reid@gmail.com>, Koen Kooi <koen@beagleboard.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, January 30, 2009 11:12 AM

> Another possibility is that the the memory timings for the custom
> board are not set correctly.

Yes this is correct also.  For example if the XSR field is wrong in SDRC registers (exit from self refresh timing).

> Richard, Do you have pointers to CDP/zoom code that has a workaround
> for the 3430 > es3 errata as well as the 'ctrl sequence issue' you
> mentioned?

If you look for ES3 in code you'll find pointers.

Latest version is here (plus a bit of C code also not in link):
http://git.omapzoom.org/?p=omapkernel.git;a=blob;f=arch/arm/mach-omap2/sleep_34xx.S;h=1fcd9df16f5cbd5650c8c1c1775024e0ffd3bf7b;hb=b60074dc4c793cfc79273b178acc1eef364712f9

You'll find a bit better broken out version here:
http://git.omapzoom.com/?p=omapkernel.git;a=commitdiff;h=9543e96f5fdb32dbcd83437ac67e48edabdf9373

ROM code changed a bit and it resulted in self-refresh command not being sent.  Prior to sleep you need to set refresh on timeout and at wake up you need to hop into sram to reprogram ddr controller then hop back to complete context restore.

Regards,
Richard W.


