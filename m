From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Tue, 11 Dec 2018 19:19:32 +0100
Message-ID: <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
 <20181210143718.plwd36vdxxd7q2el@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181210143718.plwd36vdxxd7q2el@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: ext Tony Lindgren <tony@atomide.com>, viresh kumar <viresh.kumar@linaro.org>, David Brown <david.brown@linaro.org>, Xu Wei <xuwei5@hisilicon.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>, Patrice CHOTARD <patrice.chotard@st.com>, shiraz hashim <shiraz.linux.kernel@gmail.com>, =?UTF-8?Q?Andrea
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 10, 2018 at 3:37 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> Okay. So the whole patch won't get applied, right? If so, may I please
> get the
>         arch/arm/plat-versatile/platsmp.c
>
> hunk applied?

Can you please send one patch per mach-* plat-*?

I can apply the plat-versatile patch and send upstream.

> The remaining platforms would have then either justify why
> they have the same problems like the ARM devel board or rework their
> code.

I sent a patch for Actions semiconductor today:
https://marc.info/?l=linux-arm-kernel&m=154451577304234&w=2

I guess I will keep on patching when I have time.
It would be even nicer if platform maintainers saw the
problem and did it themselves, but that doesn't always
work so I usually poke them with a patch when I want
something to improve.

Yours,
Linus Walleij
