From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH 0/2] AM3517: Booting up
Date: Tue, 09 Aug 2011 14:50:40 +0200
Message-ID: <4E412D20.40500@visionsystems.de>
References: <1312473547-1147-1-git-send-email-abhilash.kv@ti.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:42458 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab1HJKgH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 06:36:07 -0400
In-Reply-To: <1312473547-1147-1-git-send-email-abhilash.kv@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Am 04.08.2011 17:59, schrieb Abhilash K V:
> This patch-set gets the kernel booting up on a AM3517 EVM.
> The board is able to boot with ramdisk after this,but the MMC and Ethernet
> drivers are not up yet. Lots of warnings remain which will be addressed in
> subsequent patches.

Are there some more patches for testing? USB OTG in host mode seems to find my cardreader and USB memory stick, but no sdx devices were allocated. 

Yegor
