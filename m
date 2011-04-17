From: Roy Lee <tsaoyu.lee@msa.hinet.net>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update to kernel-2.6.37
Date: Sun, 17 Apr 2011 17:05:26 +0000 (UTC)
Message-ID: <loom.20110417T190324-913@post.gmane.org>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com> <20110119110607.GA30211@legolas.emea.dhcp.ti.com> <AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com> <20110120063321.GA10094@m-desktop> <AANLkTi=9yAGvOLyBBHkeNL4-HJgVL2FKqKuW1tpqDoMu@mail.gmail.com> <20110120065029.GH2389@legolas.emea.dhcp.ti.com> <AANLkTinNe76Wq-w78m7tMDY-gfMu7zt6jT7zs_KGL-iG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55149 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab1DQRKH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 17 Apr 2011 13:10:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1QBVU6-0005gE-2S
	for linux-omap@vger.kernel.org; Sun, 17 Apr 2011 19:10:07 +0200
Received: from 114-33-239-160.HINET-IP.hinet.net ([114.33.239.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 17 Apr 2011 19:10:06 +0200
Received: from tsaoyu.lee by 114-33-239-160.HINET-IP.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 17 Apr 2011 19:10:06 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Bob Liu <lliubbo <at> gmail.com> writes:


> I use buildroot to generate an initramfs 
> Of course I made some changes.
> 
> If using 8250 serial driver, my fs works well,it can enter console correctly.
> But using omap-serial driver, it can't.
> 
> I think there maybe some problem about the ttyO2 node in my fs.
> So I add it to my fs by hand, so i need to know it's major & minor number,
> so I added major &minor number to omap-serial driver.
> It seems working okay now.
> 

Bob, I also encountered the same issue. May I have the major & minor number of
ttyO2 that you use? Thanks.


