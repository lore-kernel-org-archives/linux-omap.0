From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Mon, 10 Dec 2018 15:37:18 +0100
Message-ID: <20181210143718.plwd36vdxxd7q2el@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181209004138.GC9507@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org, Barry Song <baohua@kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, Frank Rowand <frank.rowand@am.sony.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice CHOTARD <patrice.chotard@st.com>, Krzysztof Kozlowski <krzk@kernel.org>, David Brown <david.brown@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, viresh kumar <viresh.kumar@linaro.org>, Xu Wei <xuwei5@hisilicon.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Andy Gross <andy.gross@linaro.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Linux-OMAP <linux-omap@vger.kernel.org>, shiraz hashim <shiraz.linux.kernel@gmail.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 2018-12-09 00:41:39 [+0000], Russell King - ARM Linux wrote:
> So, really _both_ these things are really really specific to ARM
> development platforms, and have nothing to do with modern production
> hardware.
> 
> No one should _ever_ copy the ARM reference platform SMP hotplug
> code.  Needing that code is quite simply a sign that the platform is
> quite simply not production hardware.
> 
> I really don't get how we've ended up with so many copies of this.
> Maybe the code isn't being properly reviewed?  Maybe the process for
> merging new platforms is way too lenient?  Whatever, the fact that
> we're ending up with new copies of the pen release and boot lock
> stuff demonstrably illustrates that the review process for new
> platforms is very broken.

Okay. So the whole patch won't get applied, right? If so, may I please
get the
	arch/arm/plat-versatile/platsmp.c

hunk applied? The remaining platforms would have then either justify why
they have the same problems like the ARM devel board or rework their
code.

Sebastian
