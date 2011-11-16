From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 1/4] AM35xx: DSS: there is no VDDS_DSI on AM35xx
Date: Thu, 17 Nov 2011 01:03:29 +0400
Message-ID: <4EC42521.1070004@emcraft.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-2-git-send-email-yanok@emcraft.com> <4EBA518C.6050405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:57858 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab1KPVD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 16:03:26 -0500
In-Reply-To: <4EBA518C.6050405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Archit,

On 09.11.2011 14:10, Archit Taneja wrote:
>> AM35xx don't have VDDS_DSI regulator.
> 
> AM35xx do have vdds_dsi regulator. Are you saying that your particular
> board doesn't have vdds_dsi connected to a regulator?
> 
> I assumed that vdds_dsi regulator was required for DPI to function
> properly on omap3 devices.

Could you please give me some pointer how to find VDDS_DSI on AM3517?
Looking at the AM3517 datasheet neither I nor board manufactured can't
find any reference of VDDS_DSI so we can't determine how it is powered.

Of course I can register fake fixed regulator from the board code but
I'd like to find the proper solution for this.

Regards, Ilya.
