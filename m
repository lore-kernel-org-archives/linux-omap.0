From: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving omap_devices
 to mach-omap2)
Date: Tue, 13 Nov 2012 09:09:09 -1000
Message-ID: <50A29AD5.60303@firmworks.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com> <50999145.2070306@wwwdotorg.org> <CACxGe6v=+8UKerzp9z5cZo6TbXJQ4Nb=fpKgfkuvib_B-BoVdw@mail.gmail.com> <509D9089.7020407@wwwdotorg.org> <5B124797-6DFD-4C5E-90D7-665AFD4A7873@antoniou-consulting.com> <50A12950.6090808@wwwdotorg.org> <20121113072517.GE25915@truffula.fritz.box> <50A27BF1.4030502@wwwdotorg.org> <50A28D03.7050002@firmworks.com> <50A2919D.5030006@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50A2919D.5030006@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <panto@antoniou-consulting.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Deepak Saxena <dsaxena@linaro.org>, Russ Dill <Russ.Dill@ti.com>, Scott Wood <scottwood@freescale.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On 11/13/2012 8:29 AM, Stephen Warren wrote:
> On 11/13/2012 11:10 AM, Mitch Bradley wrote:
>> It seems to me that this capebus discussion is missing an important
>> point.  The name capebus suggests that it is a bus, so there should be a
>> parent node to represent that bus.  It should have a driver whose API
>> implements all of the system-interface functions a cape needs.
> 
> It was discussed earlier that capebus isn't actually a bus. It's simply
> a collection of a bunch of pins from the SoC hooked up to connectors.
> I'd agree that it's mis-named.
> 

Nevertheless, to the extent that the set of pins is finite and
well-defined, it should be possible to define a set of software
interfaces to support the functionality represented by those pins.

It might depend on the underlying SoC, but even so, it would still be
best to encapsulate the interface set.  I hear all these use cases that
presuppose a wide variety of user skill sets.  If one really wants to
support such users well, it's important to define a coherent single
point of interface.
