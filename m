From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for first instance
Date: Tue, 20 Mar 2012 08:20:08 +0000
Message-ID: <201203200820.08471.arnd@arndb.de>
References: <1331080771-30687-1-git-send-email-khilman@ti.com> <201203192209.43906.arnd@arndb.de> <20120319224858.GD9859@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50271 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330Ab2CTIUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 04:20:11 -0400
In-Reply-To: <20120319224858.GD9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Monday 19 March 2012, Tony Lindgren wrote:
> Let's just keep bb60424af. There are more patches needed to make
> multiple smsc91x instances work, but we need to hear from people
> with such boards first. Then those can be tagged for stable.
> 

Ok, I'm just putting that into the fixes branch for 3.4 then.

Thanks,

	Arnd
