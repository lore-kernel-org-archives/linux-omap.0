From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 0/2 rev2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Mon,  8 Sep 2008 13:29:42 +0300
Message-ID: <1220869784-16607-1-git-send-email-jarkko.nikula@nokia.com>
References: <20080905165641.GI24202@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62347 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYIHKaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 06:30:15 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m88ATec6013118
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 05:30:13 -0500
Received: from localhost.localdomain (esdhcp04045.research.nokia.com [172.21.40.45])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m88ATseK031367
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 13:29:55 +0300
In-Reply-To: <20080905165641.GI24202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here is second version of patch adding support for 2430 in McBSP driver.
Updated version uses phys_base instead of virt_base. See following commits from Russell King:

ecec3b3e080464cc1b4e792cf4d8e7e89d50b011
2cfd6fcda3b8c6ee7a5fa9a4573e3246532a0716

Second patch is the same than first version. It's for testing ASoC OMAP
and eventually it will go through the alsa-devel.

-- 
Jarkko
