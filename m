From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: linux-omap-2.6 does not allow configuring rt2xx
Date: Wed, 11 Nov 2009 08:51:49 +0200
Message-ID: <4AFA5F05.7060201@compulab.co.il>
References: <4AF9DCB8.9050305@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52253 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506AbZKKGvp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 01:51:45 -0500
In-Reply-To: <4AF9DCB8.9050305@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sboyce@blueyonder.co.uk
Cc: linux-omap@vger.kernel.org



Sid Boyce wrote:
> Spotted over the last few days.
> "make ARCH=arm CROSS_COMPILE=/opt/arm-2009q1/bin/arm-none-linux/gnueabi-
> omap3_beagle_defconfig", then xconfig/menuconfig/config, the option
> never shows up.

Have you tried enabling cfg80211 and mac80211 in "Networking support -> Wireless"?

> Regards
> Sid.

-- 
Sincerely yours,
Mike.

