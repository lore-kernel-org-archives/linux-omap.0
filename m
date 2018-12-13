From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Thu, 13 Dec 2018 13:42:34 +0100
Message-ID: <20181213124234.gwzl3zft332svaxo@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
 <20181210143718.plwd36vdxxd7q2el@linutronix.de>
 <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
 <20181211212930.kcap5kx6bff6bpuu@linutronix.de>
 <20181213114842.GJ9507@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181213114842.GJ9507@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, viresh kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, David Brown <david.brown@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Xu Wei <xuwei5@hisilicon.com>, ext Tony Lindgren <tony@atomide.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>, Patrice CHOTARD <patrice.chotard@st.com>, shiraz hashim <shiraz.linux.kernel@gmail.com>, Andreas
List-Id: linux-omap@vger.kernel.org

On 2018-12-13 11:48:42 [+0000], Russell King - ARM Linux wrote:
> On Tue, Dec 11, 2018 at 10:29:30PM +0100, Sebastian Andrzej Siewior wrote:
> > I just resent the versatile hunk. Should I really split up and resend
> > the other platforms? Russell was not very amused about it.
> 
> Just the Versatile bit, and no I don't see any point in fixing the
> other SoCs - it's an incentive for them to fix up their code.

Okay. I already resent that.

> The rest aren't something that could just be ripped out without
> the involvement of the SoC maintainer to test the changes - so
> I'm of the opinion that we should just send SoC maintainers
> patches that remove the pen_release and boot_lock crap.  If they
> blindly accept the patches, so be it.
> 
> I'm preparing a series to attack some of this.

Thank you.

Sebastian
