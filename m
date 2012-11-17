From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Sat, 17 Nov 2012 23:27:18 +0100
Message-ID: <20121117222718.GF31527@game.jcrosoft.org>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <50999145.2070306@wwwdotorg.org>
 <CACxGe6v=+8UKerzp9z5cZo6TbXJQ4Nb=fpKgfkuvib_B-BoVdw@mail.gmail.com>
 <509D9089.7020407@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <509D9089.7020407@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <panto@antoniou-consulting.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Deepak Saxena <dsaxena@linaro.org>, Scott Wood <scottwood@freescale.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On 16:23 Fri 09 Nov     , Stephen Warren wrote:
> On 11/09/2012 09:28 AM, Grant Likely wrote:
> > On Tue, Nov 6, 2012 at 10:37 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> ...
> >> I do rather suspect this use-case is quite common. NVIDIA certainly has
> >> a bunch of development boards with pluggable
> >> PMIC/audio/WiFi/display/..., and I believe there's some ability to
> >> re-use the pluggable components with a variety of base-boards.
> >>
> >> Given people within NVIDIA started talking about this recently, I asked
> >> them to enumerate all the boards we have that support pluggable
> >> components, and how common it is that some boards support being plugged
> >> into different main boards. I don't know when that enumeration will
> >> complete (or even start) but hopefully I can provide some feedback on
> >> how common the use-case is for us once it's done.
> > 
> > From your perspective, is it important to use the exact same .dtb
> > overlays for those add-on boards, or is it okay to have a separate
> > build of the overlay for each base tree?
> 
> I certainly think it'd be extremely beneficial to use the exact same
> child board .dtb with arbitrary base boards.
> 
> Consider something like the Arduino shield connector format, which I
> /believe/ has been re-used across a wide variety of Arduino boards and
> other compatible or imitation boards. Now consider a vendor of an
> Arduino shield. The shield vendor probably wants to publish a single
> .dtb file that works for users irrespective of which board they're using
> it with.
> 
> (Well, I'm not sure that Arduino can run Linux; perhaps that's why you
> picked BeagleBone capes for your document!)
> 
> I suppose it would be acceptable for the shield vendor to ship the .dts
> file rather than the .dtb, and hence need to build the shield .dtb for a
> specific base board.
> 
> However, I think the process for an end-user needs to be as simple as
> "drop this .dts/.dtb file into some standard directory", and I imagine
> it'll be much easier for distros/... to make that process work if
> they're dealing with a .dtb that they can just blast into the kernel's
> firmware loader interface, rather than having to also locate the
> base-board .dts/.dtb file, and run dtc and/or other tools on both .dts
> files together.
I've exactly the same issue on Calao or the new atmel boards

We have lego boards

with different cpu-modues running on differetn mother boards with
diferrentdaugther boards

on atmel we are lucky enough we can identity via 1-wire all of them but
on Calao no

On Somfy platform we can detect hardware version and need different pinctrl

So personally I'll prefer to be able to request dtb from the kernel or push
them from the userspace as it will depends where you will detect the hardware
present

The main concern will which part of the kenel will now handle hw detection?

Best Regards,
J.
