From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
Date: Mon, 21 Jan 2019 12:00:30 -0800
Message-ID: <20190121200030.GJ5544@atomide.com>
References: <20190121032109.10220-1-spinal.by@gmail.com>
 <CAOMZO5DDM5=ZL8_-JZpX23ChoKhuBY7-bNaTE7JjDW0jwsHb4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DDM5=ZL8_-JZpX23ChoKhuBY7-bNaTE7JjDW0jwsHb4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Arthur Demchenkov <spinal.by@gmail.com>, bcousson@baylibre.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Fabio Estevam <festevam@gmail.com> [190121 17:52]:
> On Mon, Jan 21, 2019 at 5:43 AM Arthur Demchenkov <spinal.by@gmail.com> wrote:
> >
> > Wrong polarity of card detect GPIO pin leads to the system not
> > booting from external mmc, if the back cover of N900 is closed.
> > When the cover is open the system boots fine.
> >
> > This wasn't noticed before, because of a bug, which was fixed
> > by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
> > CD and WP).
> >
> > Kernels up to 4.19 ignored the card detect GPIO from DT.
> 
> Signed-off-by tag is missing.

Arthur, please reply with your Signed-off-by for this
thread so I can apply it. That is unless you want to
repost the patch for updated comments etc.

Regards,

Tony
