From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH v3 6/7] omap3: Export omap3isp platform device
 structure
Date: Thu, 25 Nov 2010 09:03:27 +0200
Message-ID: <20101125070327.GY2468@legolas.emea.dhcp.ti.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45674 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751253Ab0KYHDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 02:03:34 -0500
Received: by mail-yx0-f176.google.com with SMTP id 8so326275yxm.21
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 23:03:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com

On Thu, Nov 25, 2010 at 03:54:37AM +0100, Laurent Pinchart wrote:
>From: Stanimir Varbanov <svarbanov@mm-sol.com>
>
>The omap3isp platform device requires platform data. As the data can be
>provided by a kernel module, the device can't be registered during arch
>initialization.

BTW, IMO platform_data should be passed in by architecture code and
*used* by the kernel module, not the other way around.

-- 
balbi
