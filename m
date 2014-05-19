From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Mon, 19 May 2014 18:22:13 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACE24C@DBDE04.ent.ti.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-2-git-send-email-pekon@ti.com>
 <20140519162532.GF4849@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EACE21E@DBDE04.ent.ti.com>
 <20140519181640.GA6957@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53963 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbaESSW2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 14:22:28 -0400
In-Reply-To: <20140519181640.GA6957@arch.cereza>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>

From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
>On 19 May 05:52 PM, Gupta, Pekon wrote:
>> >From: Tony Lindgren [mailto:tony@atomide.com]
>> >Based on the recent discussions on the capes, it seems that nobody
>> >wants to implement toggling of the capes in u-boot. And as there
>> >can be other capes using GPMC bus, we can't merge this. And because
>> >the capes are stackable, we can't really have .dts files for all
>> >the combinations. And no, we're not merging any unconnected .dts
>> >files either, sorry.
>> >
>> Yes, I fully understand. This is like death for most of the capes from point
>> of view of mainline support. But I have submitted this patch just for sake
>> of completion. And to provide reference if someone wants to locally work
>> on beaglebone NAND cape.
>
>While I fully agree with Tony on this, I think the reference is much
>appreciated. Do you think you can push the NAND cape DT example somewhere?
>
>Maybe some TI wiki page?

Yes, that's my intent. I usually keep updating following TI wiki pages [1] and [2]
which I think are helpful for NAND users on OMAP platforms.

[1]  https://processors.wiki.ti.com/index.php/Linux_Core_NAND_User%27s_Guide#Board_specific_configurations
[2] https://processors.wiki.ti.com/index.php/Linux_Core_NAND_User%27s_Guide

with regards, pekon
