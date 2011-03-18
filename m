From: "Boswell, Patrick" <Patrick.Boswell@Sypris.com>
Subject: Kernel Question
Date: Fri, 18 Mar 2011 16:00:11 -0400
Message-ID: <0E62BBF85AF134469094EB502CE90A321EAD53@TAMPA202EM.se.sypris.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og102.obsmtp.com ([64.18.2.157]:56030 "HELO
	exprod7og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756191Ab1CRUBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 16:01:47 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When in the boot process of the kernel do block devices get major and
minor devices added?

I can't get a Major/Minor number for /dev/mmcblk0p2 with
blk_lookup_devt(), but the klist iterator
sees ram0:15 and loop0:7, but nothing for mmc.

Thanks.


