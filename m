From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/1] ARM: OMAP2+: omap2plus_defconfig: enable
 devtmpfs and automount
Date: Fri, 14 Dec 2012 10:44:49 -0800
Message-ID: <20121214184449.GF4989@atomide.com>
References: <1355508168-32565-1-git-send-email-javier.martinez@collabora.co.uk>
 <50CB6FFB.2060600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18194 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756906Ab2LNSo4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:44:56 -0500
Content-Disposition: inline
In-Reply-To: <50CB6FFB.2060600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [121214 10:31]:
> On Friday 14 December 2012 07:02 PM, Javier Martinez Canillas wrote:
> >Since udev-176 [1], udev no longer creates device nodes under
> >/dev and this has to be managed by the kernel devtmpfs filesystem.
> >
> >This makes devtmpfs filesystem a requirement on newer systems and
> >a kernel built with the current OMAP2+ config will not boot on them.
> >
> >Also, it is good to have devtmpfs at /dev automount enabled by default.
> >
> >[1]: http://permalink.gmane.org/gmane.linux.hotplug.devel/17230
> >
> >Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>

Thanks, got the previous version of the same patch applied, adding
your ack. 

Tony
