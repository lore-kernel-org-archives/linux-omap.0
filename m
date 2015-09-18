From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
Date: Fri, 18 Sep 2015 10:48:36 -0700
Message-ID: <20150918174836.GG8020@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
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
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sourav Poddar <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@dowhile0.org> [150918 10:39]:
> Hello Tony,
> 
> [snip]
> 
> >
> > +       vmmcsdio_fixed: fixedregulator-mmcsdio {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "vmmcsdio_fixed";
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               gpio = <&gpio5 12 GPIO_ACTIVE_HIGH>;    /* gpio140 WLAN_EN */
> 
> I know that other OMAP boards use a fake fixed regulator to toggle the
> WiFi enable pin but now the MMC subsystem has proper support for power
> sequence providers so that should be used instead. For simple uses
> like this, Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> should be enough.

Hmm OK great, I'll take a look. Looks like that might also provide a
nice solution for handling the 32k clock from palmas to the wl12xx.

In the wl12xx case it's a real regulator on wl12xx though, not a fake.
It gets the power directly from VBAT and generates it's own clocks..
Of course nobody knows what the chip is actually doing with the GPIO
pin, it's probably just a hint to some wl12xx internal state machine.

Regards,

Tony
