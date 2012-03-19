From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for first instance
Date: Mon, 19 Mar 2012 21:18:09 +0000
Message-ID: <201203192118.09286.arnd@arndb.de>
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64021 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab2CSVSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 17:18:15 -0400
In-Reply-To: <1331080771-30687-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Matt Porter <mporter@ti.com>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>

On Wednesday 07 March 2012, Kevin Hilman wrote:
> commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
> regulators) added regulators which are registered during
> gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
> than one instance of the SMSC911x and result in attempting to register
> the same regulator more than once which causes a panic().
> 
> Fix this by only registering the regulator when the platform_data id
> field is zero, indicating its the first instance.
> 
> Cc: Matt Porter <mporter@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

It seems that both Olof and I forgot to forward this one to Linus.

If it's ok for you, I'll add it to the fixes branch for v3.4 now
and mark it for backporting to v3.3-stable.

Sorry for the inconvenience.


	Arnd
