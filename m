From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 1/4] AM35xx: DSS: there is no VDDS_DSI on AM35xx
Date: Wed, 09 Nov 2011 22:26:47 +0400
Message-ID: <4EBAC5E7.4060400@emcraft.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-2-git-send-email-yanok@emcraft.com> <4EBA518C.6050405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:45546 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab1KIS0t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 13:26:49 -0500
In-Reply-To: <4EBA518C.6050405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Archit,

09.11.2011 14:10, Archit Taneja wrote:
>> AM35xx don't have VDDS_DSI regulator.
>
> AM35xx do have vdds_dsi regulator. Are you saying that your particular
> board doesn't have vdds_dsi connected to a regulator?

Yes, you are right. But looking at the manual (and name) I think it's 
needed only for DSI operation. On our board we have LCD connected 
through DPI.

> I assumed that vdds_dsi regulator was required for DPI to function
> properly on omap3 devices.

Ok, please ignore this patch then. I think I'll create fake regulator 
from the board code to fix this.

Regards, Ilya.
