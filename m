From: Tony Lindgren <tony@atomide.com>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Mon, 10 Jun 2013 07:28:13 -0700
Message-ID: <20130610142812.GG8164@atomide.com>
References: <51B1C9D2.6060703@ti.com>
 <51B1D3D6.2020803@ti.com>
 <51B1D654.9070107@ti.com>
 <20130607175705.GC3331@atomide.com>
 <42EC710806A55841BBE342FAEBBEF172D26A1F@DNCE04.ent.ti.com>
 <20130607183628.GD3331@atomide.com>
 <51B59C83.9090701@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49895 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab3FJO2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 10:28:20 -0400
Content-Disposition: inline
In-Reply-To: <51B59C83.9090701@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@iki.fi> [130610 02:35]:
> On 07/06/13 21:36, Tony Lindgren wrote:
> 
> > Maybe check that the i2c related pins are muxed properly for your board
> > with pinctrl-single?
> 
> Reading the bytes individually with i2cget works fine, so I think that
> tells us that the pins are configured ok.

Yes OK. Maybe there's some i2c driver errata that's not getting
configured with the DT based boot?

Regards,

Tony
