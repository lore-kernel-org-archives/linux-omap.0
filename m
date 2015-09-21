From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
Date: Mon, 21 Sep 2015 07:10:18 -0700
Message-ID: <20150921141018.GC23801@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
 <20150918174836.GG8020@atomide.com>
 <20150918202718.GH8020@atomide.com>
 <CABxcv=nUuqHSJmP=z3X7F=ukeaFi+9cYTYW-wRwuv+mA8Jw2HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=nUuqHSJmP=z3X7F=ukeaFi+9cYTYW-wRwuv+mA8Jw2HQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sourav Poddar <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@dowhile0.org> [150921 02:17]:
> [adding Ulf and Tomeu to cc list]
> 
> On Fri, Sep 18, 2015 at 10:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [150918 10:54]:
> >> * Javier Martinez Canillas <javier@dowhile0.org> [150918 10:39]:
> >> > Hello Tony,
> >> >
> >> > [snip]
> >> >
> >> > >
> >> > > +       vmmcsdio_fixed: fixedregulator-mmcsdio {
> >> > > +               compatible = "regulator-fixed";
> >> > > +               regulator-name = "vmmcsdio_fixed";
> >> > > +               regulator-min-microvolt = <1800000>;
> >> > > +               regulator-max-microvolt = <1800000>;
> >> > > +               gpio = <&gpio5 12 GPIO_ACTIVE_HIGH>;    /* gpio140 WLAN_EN */
> >> >
> >> > I know that other OMAP boards use a fake fixed regulator to toggle the
> >> > WiFi enable pin but now the MMC subsystem has proper support for power
> >> > sequence providers so that should be used instead. For simple uses
> >> > like this, Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> >> > should be enough.
> >>
> >> Hmm OK great, I'll take a look. Looks like that might also provide a
> >> nice solution for handling the 32k clock from palmas to the wl12xx.
> >
> > It seems it's not quite working yet.. It seems pwrseq_simple.c can't
> > deal with delay on a power pin. It might be best to treat those using
> > the regulator framework because of the refcounting and start-up delay.
> 
> Yes, pwrseq_simple does not support delaying a power pin. IIRC Tomeu
> wanted to add a delay for power / reset pins at some point but then
> the SDIO device he wanted to power up didn't need it so he dropped
> that change at the end. I may be missremembering though.
>
> > I don't think also having regulator handling in pwrseq_simple.c
> > conflicts with the MMC regulators as they can be separate?
> >
> 
> The original "mmc: add support for power-on sequencing through DT" [0]
> patch from Olof that added just properties to the MMC controller slot
> dev node had a "card-external-vcc-supply" for SDIO devices that needed
> an external supply separate to vqmmc and vmmc supplies. The
> pwrseq_simple does not support having an input supply regulator right
> now but one can be added if that is needed.

Yes I think adding support for regulators to pwerseq_simple would
solve the issues for power line for start-up latency and usecount for
shared resources.

> > Also not related to wl12xx, the power pin on mwifiex_sdio 8787 wlan
> > must be asserted low while reset is asserted and must stay low for
> > 300ms after power pin has deasserted. Again using a regulator there
> > for the power pin might make more sense.
> >
> 
> Interesting, I've a patch queued on my tree to convert pwrseq_simple
> to use the GPIO descriptors array API since all the code do now is to
> set GPIO levels high or low for all the pins at the same time. But for
> such a fine grained timing control as you said, I wonder if we should
> just keep the code as it is now. Even when is open coding what
> gpiod_{get,set,put}_array already do, it may make sense if we add
> assert and deassert delay time for each pin.

Well the power pin typically has a latency because of a regulator
somewhere.. And it needs to disabled for PM when not used.. And
it may be shared.. So rather than reinvent the roundish thingy
again, I suggest we just let a regulator handle that.

A reset pin just needs to be toggled, but may have a dependency
to the power pin like in the 8787 case.

> Or maybe such a HW should have its own power sequence provider instead
> of making pwrseq_simple more and more complex?
> 
> > Then getting the 32k clock from palmas is not working either, it
> > seems some better deferred probe handling is needed there if
> > omap_hsmmc is built-in and palmas-clk is a loadable module.
> >
> 
> IIUC from another email, you already solved this.

That deferred probe fix did not solve this one, need to debug further.

> > I think for the fix I'll stick with regulator fixed, let's update
> > it later on unless you have better suggestions.
> 
> Yes, I didn't want to block your fixed regulator approach. I was just
> pointing out that the MMC infrastructure already has support for power
> sequence providers but if what is there doesn't fit your use case, I
> agree that we can go with the regulator fixed for now and then change
> it later.

OK yeah let's fix the issues in the pwrseq so we can finally have
resets working for 8787 too :)

Regards,

Tony

> [0]: http://patchwork.ozlabs.org/patch/312444/
