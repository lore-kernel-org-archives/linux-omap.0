From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Fri, 16 Nov 2012 08:18:01 +0000
Message-ID: <201211160818.01302.arnd@arndb.de>
References: <1353016879-15007-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59225 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab2KPISK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 03:18:10 -0500
In-Reply-To: <1353016879-15007-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Russell King <rmk+kernel@arm.linux.org.uk>, Rob Clark <rob@ti.com>

On Thursday 15 November 2012, Rob Clark wrote:
> 
> From: Rob Clark <rob@ti.com>
> 
> A new atomic modeset/pageflip ioctl being developed in DRM requires
> get_user() to work for 64bit types (in addition to just put_user()).
> 
> v1: original
> v2: pass correct size to check_uaccess, and better handling of narrowing
>     double word read with __get_user_xb() (Russell King's suggestion)
> v3: explain in comment about why this works for narrowing fetch to 1,
>     2, or 4 byte type on ARM.
> 
> Signed-off-by: Rob Clark <rob@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
