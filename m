From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 06/12] MFD: twl4030-codec -> twl4030-audio: Rename the driver
Date: Thu, 9 Jun 2011 21:37:28 +0200
Message-ID: <201106092137.28678.arnd@arndb.de>
References: <1307626230-29660-1-git-send-email-peter.ujfalusi@ti.com> <1307626230-29660-7-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56809 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab1FIThr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 15:37:47 -0400
In-Reply-To: <1307626230-29660-7-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>

On Thursday 09 June 2011 15:30:24 Peter Ujfalusi wrote:
> Rename the driver, and header file from twl4030-codec to
> twl4030-audio.
> To avoid breakage change depending drivers at the same time.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Misael Lopez Cruz <misael.lopez@ti.com>
> ---
>  drivers/input/misc/Kconfig         |    2 +-
>  drivers/input/misc/twl4030-vibra.c |   10 +-
>  drivers/mfd/Kconfig                |    2 +-
>  drivers/mfd/Makefile               |    2 +-
>  drivers/mfd/twl4030-audio.c        |  277 +++++++++++++++++++++++++++++++++++
>  drivers/mfd/twl4030-codec.c        |  278 ------------------------------------
>  include/linux/mfd/twl4030-audio.h  |  272 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/twl4030-codec.h  |  272 -----------------------------------

Better use the -M flag to git-format-patch when moving files, to make it
obvious what has or has not changed, and to reduce the size of the email.

Also, shouldn't this file go into the sound/soc/ directory? It seems that this
is really the device driver, not part of the multi-function layer.

	Arnd
