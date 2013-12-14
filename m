From: Daniel Santos <danielfsantos@att.net>
Subject: "Cannot obtain needed commit" when trying to clone?
Date: Fri, 13 Dec 2013 18:33:39 -0600
Message-ID: <52ABA763.2050705@att.net>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm3-vm4.access.bullet.mail.gq1.yahoo.com ([216.39.63.91]:39068
	"HELO nm3-vm4.access.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753011Ab3LNAiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 19:38:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Daniel Santos <daniel.santos@pobox.com>

Hey guys. I'm trying to grab v2.6.32.60 from 
http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git and 
I'm getting this sad little error:

# git clone --reference /mnt/gentoo32/usr/src/linux-2.6.32.y --branch 
v2.6.32.60 
http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git 
linux-omap-2.6.32.y
Cloning into 'linux-omap-2.6.32.y'...
error: Unable to find 811e7c87340b75dce5c488d9496075b00853942b under 
http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git
Cannot obtain needed commit 811e7c87340b75dce5c488d9496075b00853942b
while processing commit e942cc06e2d183975dd47d8da9e569316cb870ea.
error: Fetch failed.

Tried w/o a --reference and also tried to grab master, similar error:

# git clone 
http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git linux-omap
Cloning into 'linux-omap'...
error: Unable to find 8bb9660418e05bb1845ac1a2428444d78e322cc7 under 
http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git
Cannot obtain needed object 8bb9660418e05bb1845ac1a2428444d78e322cc7
while processing commit 9556974843c5a75c98a5e070c80b5bf7c304c85d.
error: Fetch failed.

Is there some type of server maintenance going on or is something 
broken? Any other clones out there where I can grab this from in the 
mean time?

Thanks,
Daniel
