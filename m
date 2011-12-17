From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 3/6] clk: introduce the common clock framework
Date: Sat, 17 Dec 2011 11:04:33 +0000
Message-ID: <20111217110433.GC14547@n2100.arm.linux.org.uk>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-4-git-send-email-mturquette@linaro.org>
 <alpine.LFD.2.02.1112141007550.3020@ionos>
 <CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: andrew@lunn.ch, linaro-dev@lists.linaro.org, eric.miao@linaro.org, grant.likely@secretlab.ca, Colin Cross <ccross@google.com>, jeremy.kerr@canonical.com, sboyd@quicinc.com, magnus.damm@gmail.com, dsaxena@linaro.org, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, richard.zhao@linaro.org, shawn.guo@freescale.com, paul@pwsan.com, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, skannan@quicinc.com
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 16, 2011 at 04:45:48PM -0800, Turquette, Mike wrote:
> On Wed, Dec 14, 2011 at 5:18 AM, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> > On Tue, 13 Dec 2011, Mike Turquette wrote:
> >> +void __clk_unprepare(struct clk *clk)
> >> +{
> >> + =A0 =A0 if (!clk)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 if (WARN_ON(clk->prepare_count =3D=3D 0))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 if (--clk->prepare_count > 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 WARN_ON(clk->enable_count > 0);
> >
> > So this leaves the clock enable count set. I'm a bit wary about
> > that. Shouldn't it either return (including bumping the prepare_count
> > again) or call clk_disable() ?

No it should not.

> I've hit this in my port of OMAP.  It comes from this simple situation:
> =

> driver 1 (adapted for clk_prepare/clk_unprepare):
> clk_prepare(clk);
> clk_enable(clk);
> =

> ...
> =

> driver2 (not adapted for clk_prepare/clk_unprepare):
> clk_enable(clk);

So this is basically buggy.  Look, it's quite simple.  Convert _all_
your drivers to clk_prepare/clk_unprepare _before_ you start switching
your platform to use these new functions.  You can do that _today_
without exception.

We must refuse to merge _any_ user which does this the old way - and
we should have been doing this since my commit was merged into mainline
to allow drivers to be converted.

And stop trying to think of ways around this inside clk_prepare/
clk_unprepare/clk_enable/clk_disable.  You can't do it.  Just fix _all_
the drivers.  Now.  Before you start implementing clk_prepare/clk_unprepare.
