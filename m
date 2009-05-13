From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Patch "REMOVE OMAP LEGACY CODE: Reset mach-omap1/board-*.c files
	to mainline" breaks nokia770
Date: Thu, 14 May 2009 00:46:51 +0100
Message-ID: <20090514004651.77342rqoq5tz86ww@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:44503 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbZEMX5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 19:57:22 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi, I've just discovered that the patch at:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=3eae3ea7c443fc4330574dffea65b6f2f53a2574

Breaks the nokia770's framebuffer as it removes the platform data for  
the HWA742 LCD controller.

As the patch says "Patches against the mainline tree are welcome to  
add back the missing functionality if needed!", I'm happy to do this.

However, since I'm fairly new to the linux-omap project, is simply  
extracting the removed nokia770 code and generating a patch against  
the mainline kernel sufficient? or is there a newer style of some sort  
that should be adopted for this?

Thanks


