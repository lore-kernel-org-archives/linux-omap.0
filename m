From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap: usb: fix build warning
Date: Thu, 19 Aug 2010 10:23:57 +0300
Message-ID: <20100819072357.GW4385@nokia.com>
References: <1282123527-7205-1-git-send-email-gadiyar@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:54449 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab0HSHYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 03:24:08 -0400
Content-Disposition: inline
In-Reply-To: <1282123527-7205-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anand Gadiyar <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Aug 18, 2010 at 11:25:27AM +0200, ext Anand Gadiyar wrote:
>Fix this and similar build warnings when building with
>omap_4430sdp_defconfig.
>
> CC      arch/arm/mach-omap2/board-4430sdp.o
>In file included from arch/arm/mach-omap2/board-4430sdp.c:36:
>arch/arm/plat-omap/include/plat/usb.h:109: warning: return type defaults to 'int'
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi

DefectiveByDesign.org
