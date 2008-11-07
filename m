From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: 3430SDP crash at boot time
Date: Fri, 7 Nov 2008 09:35:48 -0600
Message-ID: <A24693684029E5489D1D202277BE894413B38FEC@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894413A94881@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0811070458390.13920@utopia.booyaka.com>
 <A24693684029E5489D1D202277BE894413A9499B@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0811070730460.13920@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36459 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbYKGPfz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 10:35:55 -0500
In-Reply-To: <alpine.DEB.2.00.0811070730460.13920@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul,

It seems it was a problem with my git clone, bc I did a "git-gc --prune", recompiled the kernel, and don't longer see the issue. (i.e. I can boot completely without any kernel crash)

But one other thing is that with latest commit, the Tux that shows up on the LCD looks greenish. Does it happen on your SDP ES2.0? If that's not your case, I think that could be because some drivers still don't use omap_rev() function for revision checking?

Anyway, thanks for your support.

Regards,
Sergio
-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Friday, November 07, 2008 8:37 AM
To: Aguirre Rodriguez, Sergio Alberto
Cc: linux-omap@vger.kernel.org
Subject: RE: 3430SDP crash at boot time

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

