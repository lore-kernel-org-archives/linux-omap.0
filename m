From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Fri, 9 Nov 2012 23:32:10 +0000
Message-ID: <CACxGe6vAqO-JFAVssYyZ8MXtgp=yVDW8aKw_jB4Uz4bHtBJz=A@mail.gmail.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <509D8C69.7060004@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:46505 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab2KIXcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 18:32:32 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1866672dak.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Nov 2012 15:32:31 -0800 (PST)
In-Reply-To: <509D8C69.7060004@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Rob Herring <robherring2@gmail.com>, Deepak Saxena <dsaxena@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Fri, Nov 9, 2012 at 11:06 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/05/2012 01:40 PM, Grant Likely wrote:
>> As promised, here is my early draft to try and capture what device
>> tree overlays need to do and how to get there. Comments and
>> suggestions greatly appreciated.
>
> Here's one other requirement I'd like that I don't think I saw
> explicitly mentioned in your document:
>
> Assuming a base file board.dts and a child board file child.dts, the
> compiled file child.dtb should be usable with a modified board.dtb
> assuming it exports the same set of attachment-points (hashed phandles,
> socket objects, whatever). This allows bug-fixes etc. to board.dts
> without forcing every child.dts to be recompiled.

No, I hadn't explicitly captured that one, but yes it is the intent.

> If the attachment points is hashed node names or node content from
> board.dts, I'm not sure how this is possible?

Ummm, I think there is misunderstanding about the hashed phandles. My
thought is merely that using a hash to generate a phandle is 'better'
than starting at 1 and counting upwards when dtc compiles the tree.
That way, if the path to the node has not changed, then the phandle
will not have changed.

However, phandles can still be explicitly specified if slightly
different trees need to have the same target point.

That said, if portability of dtb files is a strong requirement, then
it will be difficult to do with simple overlays. Even if the phandles
line up, the irq/gpio specifiers probably need to be different. That
makes things harder.

g.
