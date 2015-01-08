From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Wed, 7 Jan 2015 16:19:22 -0800
Message-ID: <20150108001921.GR13010@atomide.com>
References: <1417800739-13146-1-git-send-email-nm@ti.com>
 <1417801732-24620-1-git-send-email-nm@ti.com>
 <20150107234442.GI13010@atomide.com>
 <20150107235815.GA17239@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51157 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbAHAXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 19:23:06 -0500
Content-Disposition: inline
In-Reply-To: <20150107235815.GA17239@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com

* Nishanth Menon <nm@ti.com> [150107 16:01]:
> On 15:44-20150107, Tony Lindgren wrote:
> > * Nishanth Menon <nm@ti.com> [141205 09:51]:
> > > TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> > > a fan (such as AFB02505HHB) over J1 connector for various purposes.
> > > Provide device tree node to enable the same.
> > > 
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > 
> > Applying into omap-for-v3.20/dt thanks.
> > 
> > Tony
> Could you pick up the very latest rev:
> https://patchwork.kernel.org/patch/5569521/ ?

Yeah sorry just noticed I had tagged two versions,
will use the v4 instead.

Regards,

Tony
