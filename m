From: Paul Walmsley <paul@pwsan.com>
Subject: RE: 3430SDP crash at boot time
Date: Fri, 7 Nov 2008 07:36:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811070730460.13920@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE894413A94881@dlee02.ent.ti.com> <alpine.DEB.2.00.0811070458390.13920@utopia.booyaka.com> <A24693684029E5489D1D202277BE894413A9499B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38971 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbYKGOg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 09:36:59 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894413A9499B@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Sergio,

On Fri, 7 Nov 2008, Aguirre Rodriguez, Sergio Alberto wrote:

> I'm attempting this with a 3430SDP-VG5.0.1 (ES3.0), and I was using the same commit.

Sounds like the OMAP ES revision detection code is broken again for ES3 
chips.

You might want to try adding some printk()s to the if statement starting 
at line 212 in mach-omap2/board-3430sdp-flash.c, to determine which of the 
two branches are taken.  It should be the first branch, I guess.

You might also want to take a look at commit 
347109cc09dd5689f37fcb139a26cde7d4b69363 for background.  The exact 
same problem happened here before that patch was applied.

> I'll retry today with another board, to see if it helps.

Yes, if you have an ES2 SDP handy, you might want to do a quick 
doublecheck to verify that current git head boots cleanly there.

> Thanks for your time.

You're welcome.


- Paul
