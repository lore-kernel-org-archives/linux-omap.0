From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support to Nokia N810 WiMAX
Date: Tue, 1 Jul 2008 13:25:39 +0300
Message-ID: <20080701132539.b4f89f1a.jarkko.nikula@nokia.com>
References: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com>
	<26a54b1545ac8acab8dae9c92cf3a285@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22241 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbYGAKZl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 06:25:41 -0400
In-Reply-To: <26a54b1545ac8acab8dae9c92cf3a285@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Hopefully someone finds a way to keep it running longer than just few
seconds :-)

I forgot to mention that it seems that HS OMAP or something is ceasing
the operation just few seconds after bootup. Initfs gets more scripts
executed but Debian from mtdblock4 hangs just in init.


Jarkko

On Tue, 01 Jul 2008 04:39:55 -0500
"ext Felipe Balbi" <me@felipebalbi.com> wrote:

> Cool,
> 
> thanks dude :-)
> 
> On Tue,  1 Jul 2008 10:53:39 +0300, Jarkko Nikula
> <jarkko.nikula@nokia.com> wrote:
> > This adds basic booting support and selects CONFIG_MACH_NOKIA_N810
> > since most of the HW and configuration are the same in N810 and
> > N810 WiMAX.
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://blog.felipebalbi.com
> me@felipebalbi.com
> 
