From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 16/23] ARM: OMAP4: omapdss: remove legacy pad muxing support
Date: Fri, 28 Nov 2014 09:58:32 +0200
Message-ID: <54782B28.7010306@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-17-git-send-email-t-kristo@ti.com> <54774CCD.5060600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55410 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbaK1H6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2014 02:58:05 -0500
In-Reply-To: <54774CCD.5060600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

On 11/27/2014 06:09 PM, Tomi Valkeinen wrote:
> On 27/11/14 17:51, Tero Kristo wrote:
>> OMAP4 is DT only now, so the legacy mux support is not needed anymore.
>> Padconf is used instead from the driver / DT. This removes the need
>> for having the mux APIs exported from the control module driver.
>
> We still use those mux functions for DT. The mux registers for DSI are
> so funny that we can't use the normal padconf for them.

Ah hmm, so it seems, I overlooked the omapdss_init_of() function. Looks 
like some of the patches in this set needs to be dropped for now then, 
namely 16, 17, and patch 18 has to be modified.

The direct omap4 padconf hacks are very bad though. Maybe it should be 
changed to only allow access to that single DSIPHY register.

-Tero

> I did do some work to use syscon, but I never had time to finish it.
>
>   Tomi
>
>

