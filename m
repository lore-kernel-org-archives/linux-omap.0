From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] ARM: OMAP: Add support to Nokia N810 WiMAX
Date: Tue, 01 Jul 2008 06:55:58 -0500
Message-ID: <d75ac35476c9f829df19fd455b1c2155@felipebalbi.com>
References: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com> <26a54b1545ac8acab8dae9c92cf3a285@felipebalbi.com> <20080701132539.b4f89f1a.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49536 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbYGAL4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 07:56:03 -0400
In-Reply-To: <20080701132539.b4f89f1a.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org



On Tue, 1 Jul 2008 13:25:39 +0300, Jarkko Nikula <jarkko.nikula@nokia.com>
wrote:
> Hopefully someone finds a way to keep it running longer than just few
> seconds :-)
> 
> I forgot to mention that it seems that HS OMAP or something is ceasing
> the operation just few seconds after bootup. Initfs gets more scripts
> executed but Debian from mtdblock4 hangs just in init.

hmm.. weird, should be transparent to kernel as long as bootloader
does its job, right ?

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

