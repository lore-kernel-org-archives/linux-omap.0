From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 0/6] OMAP SMPS regulator driver
Date: Mon, 18 Jul 2011 20:55:00 +0300
Message-ID: <1311011700.10230.11.camel@sokoban>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51692 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab1GRRzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 13:55:09 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Hilman, Kevin" <khilman@ti.com>, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>

On Mon, 2011-07-18 at 19:35 +0200, Kristo, Tero wrote:
> Hello,
> 
> Main changes compared to v2:
> 
> - cleanup should now work better
> - register all available regulators always, if no initdata => readonly
> - added board init support functionality to twl-common
> - constraints not touched by the driver anymore
> 

forgot to mention, this set was also rebased on top of
linux-omap/pm/wip/voltdm branch.

> Tested on omap3 beagle.
> 
> -Tero
> 
> 
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

