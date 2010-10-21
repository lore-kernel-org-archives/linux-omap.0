From: Luciano Coelho <luciano.coelho@nokia.com>
Subject: Re: Unknown symbol errors when insmod wl1271_sdio.ko and wl1271.ko
Date: Thu, 21 Oct 2010 09:55:08 +0300
Message-ID: <1287644108.12797.1.camel@chilepepper>
References: <381AAAD4-5CBA-4E65-8FC8-38DDF1CEF727@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61322 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0JUGzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 02:55:41 -0400
In-Reply-To: <381AAAD4-5CBA-4E65-8FC8-38DDF1CEF727@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, 2010-10-21 at 08:30 +0200, ext Elvis Dowson wrote:
> Hi,
>         I'm using the following wl127xx.git branch, and trying to bringup my board using the kernel drivers for wl1271 wlan module with a beagleboard design.
> 
> I haven't yet applied luca's patches, and thought I'd try with seeing if the built drivers are loading properly. 
> 
> I get the following errors, when attempting to insmod wl1271_sdio.ko and wl1271.ko. What dependent modules am I missing?

You're missing mac80211.ko and cfg80211.ko, at least.

Try using "modprobe wl1271_sdio" instead.


-- 
Cheers,
Luca.

