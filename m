From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
Date: Sun, 13 Jan 2019 23:46:50 +0100
Message-ID: <CACRpkdbM7M7dcbhbw4BQBsbhUzfwy390srv7QBaygpz8WKaCBQ@mail.gmail.com>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
 <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
 <20190111150935.GA4617@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190111150935.GA4617@n2100.armlinux.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-oxnas@groups.io, Marc Zyngier <Marc.Zyngier@arm.com>, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@kernel.org>, David Brown <david.brown@linaro.org>, Andy Gross <andy.gross@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 11, 2019 at 4:09 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jan 10, 2019 at 01:50:56PM +0100, Linus Walleij wrote:
> > On Thu, Dec 13, 2018 at 7:00 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > > The boot_lock is something that was required for ARM development
> > > platforms to ensure that the delay calibration worked properly.  This
> > > is not necessary for modern platforms that have better bus bandwidth
> > > and do not need to calibrate the delay loop for secondary cores.
> > > Remove the boot_lock entirely.
> > >
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > Andy have you had a chance to test/apply this patch?
>
> I would rather folk do not _apply_ these patches - the final patch
> is dependent on all the preceeding patches, and if they're applied
> to individual trees, it will mean that the final patch has to be
> delayed by a complete kernel development cycle to avoid bisect
> breakage.

Ah good point. It's way better that you queue it up indeed.

Yours,
Linus Walleij
