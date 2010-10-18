From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 9/9] arch: arm: fixed typos
Date: Mon, 18 Oct 2010 15:19:47 +0200
Message-ID: <20101018131946.GD12421@jasper.tkos.co.il>
References: <1287219606-20759-1-git-send-email-andrea.gelmini@gelma.net>
	<20101018080644.GD12363@pengutronix.de>
	<AANLkTim8e-PuLa7aG+gPf4R-gPUPgdf5rbBN10YfaoAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim8e-PuLa7aG+gPf4R-gPUPgdf5rbBN10YfaoAA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: Nishanth Menon <nm@ti.com>, Leo Chen <leochen@broadcom.com>, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Grazvydas Ignotas <notasas@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Rajendra Nayak <rnayak@ti.com>, Maciej Sosnowski <maciej.sosnowski@intel.com>, trivial@kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>, Paul Walmsley <paul@pwsan.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Scott Branden <sbranden@broadcom.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tero Kristo <tero.kristo@nokia.com>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-omap@vger.kernel.org

Hi Andrea,

On Mon, Oct 18, 2010 at 02:54:39PM +0200, Andrea Gelmini wrote:
> 2010/10/18 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> =

> Hi Uwe,
>    thanks a lot for your answer.
> =

> > [Adding trivial@kernel.org to Cc:]
> =

> Wow! I didn't know trivial@kernel.org. Very interesting. Which is the pol=
icy to
> post? I can send simple fix without bothering anyone?

Quoting Documentation/SubmittingPatches:

For small patches you may want to CC the Trivial Patch Monkey
trivial@kernel.org which collects "trivial" patches. Have a look
into the MAINTAINERS file for its current manager.
Trivial patches must qualify for one of the following rules:
 Spelling fixes in documentation
 Spelling fixes which could break grep(1)
 Warning fixes (cluttering with useless warnings is bad)
 Compilation fixes (only if they are actually correct)
 Runtime fixes (only if they actually fix things)
 Removing use of deprecated functions/macros (eg. check_region)
 Contact detail and documentation fixes
 Non-portable code replaced by portable code (even in arch-specific,
 since people copy, as long as it's trivial)
 Any fix by the author/maintainer of the file (ie. patch monkey
 in re-transmission mode)

baruch

> > On Sat, Oct 16, 2010 at 11:00:05AM +0200, Andrea Gelmini wrote:
> > =A0 =A0 =A0 =A0http://thread.gmane.org/gmane.linux.kernel/1030436/
> =

> Interesting.
> =

> > Don't know why they didn't appear in the trivial tree yet.
> =

> I guess because the patches are not group by subsystem, maybe.
> Or is allowed to make single traversal-tree commit?

-- =

                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
