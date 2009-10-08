From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.32-rc3
Date: Thu, 8 Oct 2009 16:26:03 -0700
Message-ID: <20091008232603.GB25892@atomide.com>
References: <20091007185112.GJ7899@atomide.com>
	<94a0d4530910081429m7ad88b43q38245109f3252078@mail.gmail.com>
	<20091008214140.GJ7417@atomide.com>
	<94a0d4530910081513w1a919dc2s50eca41966a2261d@mail.gmail.com>
	<94a0d4530910081520t66ce7567xe142979a35b1245@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <94a0d4530910081520t66ce7567xe142979a35b1245@mail.gmail.com>
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
Cc: linux-kernel@vger.kernel.org, Denis Karpov <ext-denis.2.karpov@nokia.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [091008 15:20]:
> On Fri, Oct 9, 2009 at 1:13 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Fri, Oct 9, 2009 at 12:41 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> * Felipe Contreras <felipe.contreras@gmail.com> [091008 14:29]:
> >>> On Wed, Oct 7, 2009 at 9:51 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> >>>

<snip snip>

> >>> The beagleboard is still not booting for me with this branch, I need
> >>> to add these two patches:
> >>>
> >>> * http://patchwork.kernel.org/patch/50721/
> >>>
> >>
> >> This should go to the mainline kernel via Samuel as it's
> >> drivers/mfd related.
> >>
> >>> This one is needed because the defconfig has:
> >>> CONFIG_TWL4030_USB=3Dy
> >>>
> >>> * http://patchwork.kernel.org/patch/50970/
> >>>
> >>> This is needed because most people boot from an MMC.
> >>
> >> And this should go in via the mmc list.
> >
> > Should it?
> >
> > Here you can see Uwe Kleine-K=F6nig sending the original patch without
> > even CC'ing the mmc list:
> > http://marc.info/?l=3Dlinux-kernel&m=3D124820861213849&w=3D2
> >
> > And it was unintentionally broken by this one:
> > http://marc.info/?l=3Dlinux-mmc&m=3D125249763422227&w=3D2
> =

> Er, actually that one was ok, the problem was introduced only in the
> final version:
> http://marc.info/?l=3Dlinux-mmc&m=3D125366315417006&w=3D2

Right, looks like Roger forgot to Cc linux-mmc.
 =

> > I don't see what we are waiting for, the code is clearly broken, even
> > the compiler warns that nobody is using omap_hsmmc_probe().

I've sent Roger's patch to Andrew & linux-mmc so hopefully it will get
merged soon:

http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00539.html

Regards,

Tony
