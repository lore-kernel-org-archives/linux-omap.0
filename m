From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
Date: Thu, 10 Jan 2019 22:47:53 +0100
Message-ID: <CACRpkdbKgVCQeTwgbBuwTBosNwOB-fNfv9bU+wZr0PJG3GxwjQ@mail.gmail.com>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
 <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
 <154715377593.19284.1463901972122807524@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <154715377593.19284.1463901972122807524@swboyd.mtv.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-oxnas@groups.io, Marc Zyngier <Marc.Zyngier@arm.com>, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Russell King <rmk+kernel@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 10, 2019 at 9:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Linus Walleij (2019-01-10 04:50:56)

> > Mark/Marc: is there any specific reason to why the ARM arch
> > timer does not register an arch delay timer?
>
> Doesn't the ARM arch timer get registered in
> arch/arm/kernel/arch_timer.c via arch_timer_delay_timer_register()?

Ah indeed it does, OK then, this patch should be fine from that
point of view.

Yours,
Linus Walleij
