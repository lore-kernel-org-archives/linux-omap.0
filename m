From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: No console output (omap-3.2 branch)
Date: Sat, 10 Dec 2011 14:55:50 +0100
Message-ID: <jbvod7$rj2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52914 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab1LJN4E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Dec 2011 08:56:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RZNPH-0003Hp-4F
	for linux-omap@vger.kernel.org; Sat, 10 Dec 2011 14:56:03 +0100
Received: from vpn12.rz.tu-ilmenau.de ([141.24.172.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 14:56:03 +0100
Received: from andre.puschmann by vpn12.rz.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 14:56:03 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi list, Steve,

I am trying to boot a kernel I built (using omap2plus_defconfig) based
on Steve's omap-3.2 branch without much success.

I don't get any console output after Uboot finished uncompressing the
kernel. Is there anything I need to configure? The kernel image based on
Tony's tree boots fine on the same hardware (Gumstix Overo Tide)
(despite having MMC issues as mentioned earlier).

Thanks in advance.

-Andre

