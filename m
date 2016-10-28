From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resent v3 2/3] dts: omap5: board-common: enable twl6040
 headset jack detection
Date: Fri, 28 Oct 2016 06:11:00 -0700
Message-ID: <20161028131059.jbcmlmakfmovq2jj@atomide.com>
References: <cover.1477417090.git.hns@goldelico.com>
 <b918b86fd1d1f7e6fb2c15bb507b84d5cf1f0d3e.1477417090.git.hns@goldelico.com>
 <06084abe-015a-ed84-2ce3-779be5744773@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06084abe-015a-ed84-2ce3-779be5744773@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, kernel@pyra-handheld.com, marek@goldelico.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [161026 01:03]:
> On 10/25/16 20:38, H. Nikolaus Schaller wrote:
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> I'm not sure if this is valid for igep0500 as I have not seen the schematics.
> It might be safer to enable the jack detection only for omap5-uevm?

FYI it's pretty much the same design and audio worked fine on igepv5
the last time I tested it. I guess a good reason to drill a new hole
to my pi-top case for the audio jack :)

Tony
