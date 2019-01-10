From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
Date: Thu, 10 Jan 2019 13:50:56 +0100
Message-ID: <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, linux-oxnas@groups.io, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 13, 2018 at 7:00 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:

> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Andy have you had a chance to test/apply this patch?

I think the majority of Qcom systems use CLKSRC_QCOM
which registers an arch delay timer and swiftly bypasses the
calibration anyways so this code is pretty much pointless.

There is a question about MSM8974 though. This appears
to not use CLKSRC_QCOM but rather HAVE_ARM_ARCH_TIMER.
drivers/clocksource/arm_arch_timer.c seems to
not register a delay timer, which is probably something that
should be fixed?

Mark/Marc: is there any specific reason to why the ARM arch
timer does not register an arch delay timer?

Yours,
Linus Walleij
