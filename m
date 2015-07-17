From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Remove legacy booting support for Pandora
Date: Thu, 16 Jul 2015 21:54:05 -0700
Message-ID: <20150717045405.GQ17550@atomide.com>
References: <1437047951-22300-1-git-send-email-tony@atomide.com>
 <1437047951-22300-3-git-send-email-tony@atomide.com>
 <CANOLnOPQHOY5Up8+uKQn-JTK4zN=iK+owSN2KjhJGNFLVzN9yQ@mail.gmail.com>
 <20150716162616.GO17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150716162616.GO17550@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150716 09:28]:
> * Grazvydas Ignotas <notasas@gmail.com> [150716 07:16]:
> > Hi,
> > 
> > On Thu, Jul 16, 2015 at 2:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > We've been moving all omap2+ based systems to boot in device tree only
> > > mode for a few years now. Only omap3 has legacy booting support
> > > remaining. Most omap3 boards already have related arch/arm/boot/*.dts*
> > > files for booting with device tree.
> > >
> > > This board has support for device tree based booting, and we've been
> > > printing warnings about the legacy booting being deprecated for a
> > > few merge cycles now. Let's attempt to remove the legacy booting
> > > for it.
> > >
> > > The reason for removing the legacy booting support now rather than
> > > later is we can simply revert this patch if necessary if we run
> > > into some unexpected issues that are not trivial to fix for the
> > > device tree based booting.
> > 
> > It seems we lose wifi, backlight, audio and usb host mainline support
> > with this as pandora's .dts currently lacks all that stuff.

More on that later on, but a question on the vendor kernel first..

> > That said I'm not aware of any mainline users (everyone seems to be on
> > our "vendor" kernel), so maybe we can add those later.

What all is keeping people from using mainline kernel on pandora?
Is it the sgx or are there other reasons too remaining?  

> Hmm wifi should be easy, isn't that just libertas_sdio?

Nope wl1251, we can initialize with pdata-quirks.c for now if it
does not yet support device tree except for the SPI version.
The same goes for the other devices too if needed, I'd assume
the the EHCI is similar to beagle though.

And of course we can still wait on removing the pandora board file
if you want to. Sounds like that may not be needed though because of
people using "vendor" kernel in this case even with the legacy
booting?

Regards,

Tony
