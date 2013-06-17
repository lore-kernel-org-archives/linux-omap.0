From: Roger Quadros <rogerq@ti.com>
Subject: Re: OMAP4 Panda DVI problem
Date: Mon, 17 Jun 2013 14:37:36 +0300
Message-ID: <51BEF500.4080308@ti.com>
References: <51BB201C.3000605@ti.com> <51BEC4D7.2080903@ti.com> <20130617111834.GR20992@atomide.com> <51BEF2BF.3000104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44668 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab3FQLhj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 07:37:39 -0400
In-Reply-To: <51BEF2BF.3000104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 06/17/2013 02:27 PM, Tomi Valkeinen wrote:
> On 17/06/13 14:18, Tony Lindgren wrote:
> 
>> You should be able to get the regulator based on the name just fine
>> from the drivers even if one driver is using DT and one is not. That is
>> as long as the regulator is defined. Then the regulator fwk will track
>> the usecount properly.
> 
> Doesn't the regulator need to be "bound" to a device for the driver to
> use the proper name for the regulator? I mean, in this case the dvi
> driver wants to get a regulator named "vdd_5v" (or something like that,
> I'm not sure what's the proper name). The USB host driver uses a name
> "vcc", while the real name of the regulator is "hsusbX_vcc".

Right. I think if the regulator is not bound to any device then you can
get it just by supply name.

http://lxr.free-electrons.com/source/drivers/regulator/core.c#L1175

But the USB PHY driver will always try to get the regulator for it's device
that has supply name "vcc".

cheers,
-roger
