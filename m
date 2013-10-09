From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Wed, 09 Oct 2013 09:54:56 +0200
Message-ID: <52550BD0.1060901@collabora.co.uk>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk> <5254F0ED.5030800@ti.com> <5255094B.2060207@collabora.co.uk> <52550A28.4060508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42052 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3JIHzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 03:55:35 -0400
In-Reply-To: <52550A28.4060508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

On 10/09/2013 09:47 AM, Tomi Valkeinen wrote:
> On 09/10/13 10:44, Javier Martinez Canillas wrote:
> 
>> I can't do it yet because the two are still needed for different boot paths.
>> Once the board DTS has all the hardware support that is currently available on
>> the board file I'll delete the board file but until then I can't remove anything
>> from the legacy code since that is what users are using right now.
> 
> Yes, right, I meant that move the code from the board file to
> dss_common.c, and call the same display init code from both the board
> file and from the quirks system.
>

Sorry I misunderstood and yes you are right. I'll remove it from the board file
and use the info in dss_common.c.

If Tony drop the patch I can send a new version that does this or if he already
sent a pull request I can do it as an incremental patch.

>  Tomi
> 
> 

Thanks a lot and best regards,
Javier

