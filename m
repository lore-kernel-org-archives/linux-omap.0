From: Igor Mazanov <i.mazanov@gmail.com>
Subject: TPS65217 declarations is missed in omap2defconfig
Date: Sun, 18 Nov 2012 19:43:14 +0400
Message-ID: <50A90212.80406@gmail.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33897 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212Ab2KRPmo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Nov 2012 10:42:44 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Ta71J-0005d0-Mc
	for linux-omap@vger.kernel.org; Sun, 18 Nov 2012 16:42:53 +0100
Received: from 77.232.56.122 ([77.232.56.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 18 Nov 2012 16:42:53 +0100
Received: from i.mazanov by 77.232.56.122 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 18 Nov 2012 16:42:53 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

TPS65217 is described in the arch/arm/boot/dts/AM335x-bone.dts file but not 
declared in the arch/arm/configs/omap2plus_defconfig.

Is it a known issue? Should I send a patch to fix it?

Regards,
Igor.

