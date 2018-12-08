From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Sun, 9 Dec 2018 00:15:35 +0100
Message-ID: <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181207130012.GX6920@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>
Cc: ext Tony Lindgren <tony@atomide.com>, viresh kumar <viresh.kumar@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, David Brown <david.brown@linaro.org>, Xu Wei <xuwei5@hisilicon.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>, Patrice CHOTARD <patrice.chotard@st.com>, shiraz hashim <shiraz.linux.kernel@gmail.com>, =?U
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 7, 2018 at 2:00 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> I think the bigger question is why are all these platforms using this.
> For the ARM development platforms, it's fair as they have no way to
> power down the CPUs or reset the other CPUs, and the "boot lock" was
> there originally to prevent the delay calibration going awry.  (I've
> been saying this for years but obviously people like to stuff their
> fingers in their ears.)
>
> It annoys me when people cargo-cult copy code and don't bother trying
> to understand it, which is shown clearly in your diffstat.

It's a very good point.

I did away with "my" culprit at one point in
commit c00def71efd9
"ARM: ux500: simplify secondary CPU boot"
so people could look at that for an example to see how pointless
this "pen holding" (what does it even mean, I never figured it
out?) and boot_lock is.

I thought it was just a few platforms around the time the first
SMP systems were arriving that were doing this but as you point
out, recent newcomers are doing this, such as sti, actions,
qcom, hisi, sunxi.

I would encourage other platforms that have this "write some
magic stuff in some register to boot cpu n" to look at
arch/arm/mach-ux500/platsmp.c, something like that should be
all you need, no special assembly, no "pen", no "boot lock".

Look up resources etc in .smp_prepare_cpus(), make sure to
call set_cpu_possible() for each available CPU, then  just
kick in the CPU n in .smp_boot_secondary() by doing your platform
magic. Optionally cpu_die()
if you need special code or just put in a wfi() for that. That's all.

Yours,
Linus Walleij
