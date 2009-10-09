From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [GIT PULL] omap fixes for v2.6.32-rc3
Date: Fri, 9 Oct 2009 10:30:28 +0200
Message-ID: <20091009083028.GB29907@pengutronix.de>
References: <20091007185112.GJ7899@atomide.com>
	<94a0d4530910081429m7ad88b43q38245109f3252078@mail.gmail.com>
	<20091008214140.GJ7417@atomide.com>
	<94a0d4530910081513w1a919dc2s50eca41966a2261d@mail.gmail.com>
	<20091009080201.GB28096@pengutronix.de>
	<94a0d4530910090125l751ff92buc3ebafe049b1a55c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <94a0d4530910090125l751ff92buc3ebafe049b1a55c@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Denis Karpov <ext-denis.2.karpov@nokia.com>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Fri, Oct 09, 2009 at 11:25:47AM +0300, Felipe Contreras wrote:
> 2009/10/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > On Fri, Oct 09, 2009 at 01:13:01AM +0300, Felipe Contreras wrote:
> >> On Fri, Oct 9, 2009 at 12:41 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> >> > * Felipe Contreras <felipe.contreras@gmail.com> [091008 14:29]:
> >> >> On Wed, Oct 7, 2009 at 9:51 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
> >> >> > Linus,
> >> >> >
> >> >> > Please pull omap fixes from:
> >> >> >
> >> >> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2=
.6.git omap-fixes-for-linus
> >> >> >
> >> >> > Regards,
> >> >> >
> >> >> > Tony
> >> >> >
> >> >> >
> >> >> > The following changes since commit 374576a8b6f865022c0fd1ca623968=
89b23d66dd:
> >> >> > =A0Linus Torvalds (1):
> >> >> > =A0 =A0 =A0 =A0Linux 2.6.32-rc3
> >> >> >
> >> >> > are available in the git repository at:
> >> >> >
> >> >> > =A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma=
p-2.6.git omap-fixes-for-linus
> >> >> >
> >> >> > Artem Bityutskiy (1):
> >> >> > =A0 =A0 =A0OMAP3: PM: introduce a new powerdomain walk helper
> >> >> >
> >> >> > Daniel Walker (1):
> >> >> > =A0 =A0 =A0omap: iovmm: Add missing mutex_unlock
> >> >> >
> >> >> > Hiroshi DOYU (1):
> >> >> > =A0 =A0 =A0omap: iovmm: Fix incorrect spelling
> >> >> >
> >> >> > Jon Hunter (1):
> >> >> > =A0 =A0 =A0OMAP3: PM: Prevent hang in prcm_interrupt_handler
> >> >> >
> >> >> > Kevin Hilman (1):
> >> >> > =A0 =A0 =A0OMAP3: PM: Enable GPIO module-level wakeups
> >> >> >
> >> >> > Paul Walmsley (2):
> >> >> > =A0 =A0 =A0OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
> >> >> > =A0 =A0 =A0OMAP3: PM: PRCM interrupt: only handle selected PRCM i=
nterrupts
> >> >> >
> >> >> > Rajendra Nayak (1):
> >> >> > =A0 =A0 =A0omap: Lock DPLL5 at boot
> >> >> >
> >> >> > Sergio Aguirre (1):
> >> >> > =A0 =A0 =A0omapfb: Condition mutex acquisition
> >> >> >
> >> >> > Tommi Rantala (2):
> >> >> > =A0 =A0 =A0omapfb: Blizzard: fix pointer to be const
> >> >> > =A0 =A0 =A0omapfb: Blizzard: constify register address tables
> >> >> >
> >> >> > Tony Lindgren (2):
> >> >> > =A0 =A0 =A0omap: Fix incorrect 730 vs 850 detection
> >> >> > =A0 =A0 =A0Merge branch 'pm-fixes-32' of git://git.kernel.org/...=
/khilman/linux-omap-pm into omap-fixes-for-linus
> >> >> >
> >> >> > Vikram Pandita (1):
> >> >> > =A0 =A0 =A0OMAP3: PM: USBHOST: clear wakeup events on both hosts
> >> >> >
> >> >> > ye janboe (1):
> >> >> > =A0 =A0 =A0omap: SRAM: flush the right address after memcpy in om=
ap_sram_push
> >> >>
> >> >> The beagleboard is still not booting for me with this branch, I need
> >> >> to add these two patches:
> >> >>
> >> >> * http://patchwork.kernel.org/patch/50721/
> >> >>
> >> >
> >> > This should go to the mainline kernel via Samuel as it's
> >> > drivers/mfd related.
> >> >
> >> >> This one is needed because the defconfig has:
> >> >> CONFIG_TWL4030_USB=3Dy
> >> >>
> >> >> * http://patchwork.kernel.org/patch/50970/
> >> >>
> >> >> This is needed because most people boot from an MMC.
> >> >
> >> > And this should go in via the mmc list.
> >>
> >> Should it?
> >>
> >> Here you can see Uwe Kleine-K=F6nig sending the original patch without
> >> even CC'ing the mmc list:
> >> http://marc.info/?l=3Dlinux-kernel&m=3D124820861213849&w=3D2
> > Note these are different patches. =A0Mine fixes a section problem as the
> > probe function used to live in .init.text but was still used with
> > platform_driver_register.
> =

> Maybe you looked at the wrong diff. This is the patch that is going to
> be pushed eventually:
> http://marc.info/?l=3Dlinux-mmc&m=3D125504287632070&w=3D2
> =

> As you can see it's restoring back what you intended in the original patc=
h.
Yes, but back then it was broken in a different way.  Now the driver's
probe function hasn't been called at all.  My fix addressed a possible
oops because it could be called when is was already discarded.

Best regards
Uwe

-- =

Pengutronix e.K.                              | Uwe Kleine-K=F6nig         =
   |
Industrial Linux Solutions                    | http://www.pengutronix.de/ =
 |
