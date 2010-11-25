From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH v3 6/7] omap3: Export omap3isp platform device
 structure
Date: Thu, 25 Nov 2010 13:23:11 +0200
Message-ID: <20101125112311.GV2468@legolas.emea.dhcp.ti.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com>
 <20101125070241.GX2468@legolas.emea.dhcp.ti.com>
 <201011251218.00331.laurent.pinchart@ideasonboard.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48388 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751581Ab0KYLXT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 06:23:19 -0500
Content-Disposition: inline
In-Reply-To: <201011251218.00331.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, linux-media@vger.kernel.org

Hi,

On Thu, Nov 25, 2010 at 12:17:59PM +0100, Laurent Pinchart wrote:
>> pass platform_data as an argument to this call ? Then remove the static
>> inline and export this one ?
>
>Yes indeed, why ? :-)
>
>I guess things like that are difficult to spot when you've had your nose on
>the code for too long. Thanks for the review, I'll fix this.

no problem :-)

-- 
balbi
