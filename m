From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Sun, 9 Dec 2018 00:41:39 +0000
Message-ID: <20181209004138.GC9507@n2100.armlinux.org.uk>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ext Tony Lindgren <tony@atomide.com>, viresh kumar <viresh.kumar@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, David Brown <david.brown@linaro.org>, Xu Wei <xuwei5@hisilicon.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>, Patrice CHOTARD <patrice.chotard@st.com>, shiraz hashim <shiraz.linux.kernel@gmail.com>And
List-Id: linux-omap@vger.kernel.org

On Sun, Dec 09, 2018 at 12:15:35AM +0100, Linus Walleij wrote:
> On Fri, Dec 7, 2018 at 2:00 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> 
> > I think the bigger question is why are all these platforms using this.
> > For the ARM development platforms, it's fair as they have no way to
> > power down the CPUs or reset the other CPUs, and the "boot lock" was
> > there originally to prevent the delay calibration going awry.  (I've
> > been saying this for years but obviously people like to stuff their
> > fingers in their ears.)
> >
> > It annoys me when people cargo-cult copy code and don't bother trying
> > to understand it, which is shown clearly in your diffstat.
> 
> It's a very good point.
> 
> I did away with "my" culprit at one point in
> commit c00def71efd9
> "ARM: ux500: simplify secondary CPU boot"
> so people could look at that for an example to see how pointless
> this "pen holding" (what does it even mean, I never figured it
> out?) and boot_lock is.

It's a "holding pen" - in normal parlence, it's a place where livestock
are temporarily confined.

In this case, our livestock are CPUs, and they are temporarily confined
in a tight loop.  Early ARM development boards did not have a way to
wake individual secondary CPUs from the boot loader, so the only way to
boot them as Linux wanted was to direct the boot loader to release all
CPUs into a "holding pen" and then release them from the holding pen
one at a time when Linux wanted a secondary CPU to come online.

The early systems also did not have very good bandwidth between the
CPUs and memory, which meant that the CPU requesting another core to
be plugged in would perturb the secondary core's delay calibration to
a noticable amount, and trapping the requesting core in a spinlock
would prevent the delay calibration going awry.

So, really _both_ these things are really really specific to ARM
development platforms, and have nothing to do with modern production
hardware.

No one should _ever_ copy the ARM reference platform SMP hotplug
code.  Needing that code is quite simply a sign that the platform is
quite simply not production hardware.

I really don't get how we've ended up with so many copies of this.
Maybe the code isn't being properly reviewed?  Maybe the process for
merging new platforms is way too lenient?  Whatever, the fact that
we're ending up with new copies of the pen release and boot lock
stuff demonstrably illustrates that the review process for new
platforms is very broken.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
