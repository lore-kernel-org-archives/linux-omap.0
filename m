From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/3] omap gpmc changes for v3.10 merge window
Date: Mon, 8 Apr 2013 19:54:54 +0200
Message-ID: <201304081954.54959.arnd@arndb.de>
References: <0MLQ4w-1UONym4BnO-000gHb@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55866 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934750Ab3DHRzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:55:03 -0400
In-Reply-To: <0MLQ4w-1UONym4BnO-000gHb@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 04 April 2013, Tony Lindgren wrote:
> GPMC updates from Jon Hunter <jon-hunter@ti.com>:
> 
> Adds GPMC (General Purpose Memory Controller) DT support for
> NOR flash and Ethernet and includes various GPMC cleans-up
> and fixes.
> 
> This series is dependent on commit 7185684 (ARM: OMAP: use
> consistent error checking) from RMK's clean-up branch and commit
> 31d9adc (ARM: OMAP2+: Fix broken gpmc support).

Pulled into the next/drivers branch, thanks!

	Arnd
