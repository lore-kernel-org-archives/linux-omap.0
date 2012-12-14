From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 1/1] ARM: OMAP2+: omap2plus_defconfig: enable devtmpfs
 and automount
Date: Fri, 14 Dec 2012 19:29:15 +0100
Message-ID: <50CB6FFB.2060600@ti.com>
References: <1355508168-32565-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37893 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756671Ab2LNS2p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 13:28:45 -0500
In-Reply-To: <1355508168-32565-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 14 December 2012 07:02 PM, Javier Martinez Canillas wrote:
> Since udev-176 [1], udev no longer creates device nodes under
> /dev and this has to be managed by the kernel devtmpfs filesystem.
>
> This makes devtmpfs filesystem a requirement on newer systems and
> a kernel built with the current OMAP2+ config will not boot on them.
>
> Also, it is good to have devtmpfs at /dev automount enabled by default.
>
> [1]: http://permalink.gmane.org/gmane.linux.hotplug.devel/17230
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>

