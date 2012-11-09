From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving omap_devices
 to mach-omap2)
Date: Fri, 09 Nov 2012 15:59:38 -0700
Message-ID: <509D8ADA.6040408@wwwdotorg.org>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com> <02FF5400-9F97-4B8A-AEF0-267B01C8099F@antoniou-consulting.com> <CAD=GYpbeKtW37Cj9cXr8F7F83d9Fgs-moqu9p6cOaPE1VxwbSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46813 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab2KIW7l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 17:59:41 -0500
In-Reply-To: <CAD=GYpbeKtW37Cj9cXr8F7F83d9Fgs-moqu9p6cOaPE1VxwbSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Deepak Saxena <dsaxena@linaro.org>, Scott Wood <scottwood@freescale.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 11/08/2012 10:32 PM, Joel A Fernandes wrote:
...
> Alternatively to hashing, reading David Gibson's paper I followed,
> phandle is supposed to 'uniquely' identity node. I wonder why the node
> name itself is not sufficient to uniquely identify. The code that does
> the tree walking can then just strcmp the node name while it walks the
> tree instead of having to find a node with a phandle number.

Node names or node paths?

If you're talking node names, consider an SoC with two different I2C
controllers each attached to an I2C EEPROM with the same I2C address.
The nodes representing those EEPROMs might both get the name "eeprom@2c"
for example. The node paths should be unique though.

