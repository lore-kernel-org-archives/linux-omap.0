From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] arm: Convert arm boot_lock to raw
Date: Mon, 7 May 2018 09:33:07 +0200
Message-ID: <20180507073307.uuumknm4fx3wbq3u@linutronix.de>
References: <20180504105600.20613-1-bigeasy@linutronix.de>
 <20180506182325.w7yvrpp3hcii54pj@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180506182325.w7yvrpp3hcii54pj@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Frank Rowand <frank.rowand@am.sony.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Wei Xu <xuwei5@hisilicon.com>, Patrice Chotard <patrice.chotard@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, David Brown <david.brown@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Andy Gross <andy.gross@linaro.org>, tglx@linutronix.de, linux-omap@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2018-05-06 20:23:25 [+0200], Krzysztof Kozlowski wrote:
> >  arch/arm/mach-actions/platsmp.c   |    6 +++---
> >  arch/arm/mach-exynos/platsmp.c    |   12 ++++++------
> 
> I assume this is needed for -rt patches?
correct.

> For Exynos:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested on Exynos5422 (Odroid HC1) with Linaro PM-QA:
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

thank you.

> Best regards,
> Krzysztof

Sebastian
