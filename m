From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/8] RFC: dt-bindings: add img,pvrsgx.yaml for
 Imagination GPUs
Date: Fri, 8 Nov 2019 08:45:43 -0800
Message-ID: <20191108164543.GD5610@atomide.com>
References: <cover.1573124770.git.hns@goldelico.com>
 <4292cec1fd82cbd7d42742d749557adb01705574.1573124770.git.hns@goldelico.com>
 <CAL_Jsq+ri3AXb=qhedBzQ6WufLm4aPrSqNxXiHd3_=mH3vJ8xw@mail.gmail.com>
 <52549A4C-F49D-4FE9-9CD2-B331FB486BA9@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52549A4C-F49D-4FE9-9CD2-B331FB486BA9@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, OpenPVRSGX Linux Driver Group <openpvrsgx-devgroup@letux.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, "open list:MIPS" <linux-mips@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [191107 16:56]:
> > Am 07.11.2019 um 15:35 schrieb Rob Herring <robh+dt@kernel.org>:
> > On Thu, Nov 7, 2019 at 5:06 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >> Clock, Reset and power management should be handled
> >> by a parent node or elsewhere.
> > 
> > That's probably TI specific...
> 
> Yes and no.
> 
> For example the img4780 seems to need a clock reference in the
> gpu node. But it could maybe connected in a parent node like recent
> TI SoC do with the target-module approach.

The clocks are implemented at the SoC glue layer and/or the
interconnect layer, and then the device probably has it's
own clock gate controls.

> And our goal is to end up with a common driver for all SoC and architectures
> in far future. Then, probably clock, reset and power management should
> be handled in the same way.

Yeah so that's standard Linux features such as PM runtime
and genpd basically :)

So you can just leave out the clocks paragraph from the
binding. Then if clocks are really needed beyond PM runtime
and genpd, those can always be added later.

We just need a super minimal binding to start with that
only uses standard properties, then more can be added
later if needed.

Regards,

Tony
