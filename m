From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 2/4] omap_dss: add FocalTech ETM070003DH6 display support
Date: Sun, 20 Nov 2011 22:12:22 +0400
Message-ID: <4EC94306.4060505@emcraft.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com>	 <1320797568-11169-3-git-send-email-yanok@emcraft.com> <1321525575.1919.78.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:40495 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1KTSMV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Nov 2011 13:12:21 -0500
In-Reply-To: <1321525575.1919.78.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Tomi,

On 17.11.2011 14:26, Tomi Valkeinen wrote:
>> +		.acbi			= 0x0,
>> +		.acb			= 0x28,
> 
> You could just remove .acbi and .acb, I don't think they are needed.

You are right.

>> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
>> +					  OMAP_DSS_LCD_IHS,
>> +		.power_on_delay		= 50,
>> +		.power_off_delay	= 100,
> 
> Did you check from the panel spec if any delays are needed? These look
> like just copied from the Sharp panel data.

Actually they were copied from some vendor code, but you are right
again, I can't see anything concerning the delays in the panel spec and
panel works ok with the delays thrown out.

Regards, Ilya.
