From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle-xm: Add fixed 26MHz clock as fck
 for twl
Date: Tue, 1 May 2018 08:39:56 -0700
Message-ID: <20180501153956.GG98604@atomide.com>
References: <20180405115239.17370-1-peter.ujfalusi@ti.com>
 <CAHCN7x+Ow7B4kTmd+4PkDd=azn-qKMYmEyjqfb8GkXA7Y7pEPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7x+Ow7B4kTmd+4PkDd=azn-qKMYmEyjqfb8GkXA7Y7pEPA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180501 15:32]:
> On Thu, Apr 5, 2018 at 6:52 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > The board uses 26MHz oscillator for the twl4030 HFCLK.
> > This way we will not depend on the bootloader to configure the
> > CFG_BOOT:HFCLK_FREQ
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > Hi,
> >
> > there might be other boards (all omap3 boards with twl4030?) which uses the same
> > setup, but I only have schematics for beagle-xm.
> >
> 
> I know I am late coming into this, but we have twl4030_omap3.dtsi for
> the items common to omap3. Can we put the clock reference in that
> file?
> 
> It seems like it would be cleaner than having a dozen boards or so
> boards having the exact same copy of the same stuff. SHould something
> change in the future, I would think it would make
> maintenance easier too.  Just my two cents.

Well we don't know if it's a 26MiHz clock on all of them. Some use
38MiHz at least. Sure the board can override it but let's first
fix up each board then later on add the common node.

Regards,

Tony
