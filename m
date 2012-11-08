From: Timur Tabi <timur@freescale.com>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving omap_devices
 to mach-omap2)
Date: Thu, 8 Nov 2012 08:09:19 -0600
Message-ID: <509BBD0F.3030702@freescale.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com> <6AE080B68D46FC4BA2D2769E68D765B708174B7D@039-SN2MPN1-023.039d.mgd.msft.net> <509AE247.3000404@gmail.com> <356155A1-776B-4AA5-A912-14CE7D9AE42C@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <356155A1-776B-4AA5-A912-14CE7D9AE42C@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Ryan Mallon <rmallon@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Pantelis Antoniou <panto@antoniou-consulting.com>, Rob Herring <robherring2@gmail.com>, Deepak Saxena <dsaxena@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wood Scott-B07421 <B07421@freescale.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-omap@vger.kernel.org

Koen Kooi wrote:
> And as Pantelis mentioned before, I really don't want my users to change the bootloader whenever they add a new LED.

Well, U-Boot does allow you to manipulate the device tree from the
command-line, but I understand that this feature doesn't work that well.

-- 
Timur Tabi
Linux kernel developer at Freescale
