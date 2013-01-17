From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Thu, 17 Jan 2013 15:27:28 -0700
Message-ID: <20130117222728.GA32446@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
 <20130108203853.GB1876@animalcreek.com>
 <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 17, 2013 at 07:13:36PM +0000, Paul Walmsley wrote:
> Hi Mark,

Hi Paul.

> I regret the delay,
> =

> On Tue, 8 Jan 2013, Mark A. Greer wrote:
> =

> > On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:
> >
> > > - The patch series causes AM3517/3505 to crash.  I'd guess this is du=
e to =

> > > the SHAM/AES modules being initialized on those chips, but they proba=
bly =

> > > don't exist there.  Can you change the initialization for those on OM=
AP3 =

> > > to only take place on OMAP34xx/36xx GP?  I guess you'd need to create=
 new =

> > > lists for those in the hwmod init.
> > =

> > All am35xx GPs have the SHAM and AES modules except some very old ones.
> > I've been told that there should be very few of the "old" ones around
> > (I don't know how to differentiate them).  We're likely safe since the
> > SHAM & AES modules are not enabled in omap2plus_defconfig so nobody
> > should be enabling them on an am35xx unless they know that they have
> > the modules.  Do you agree?
> =

> Those will presumably only enable or disable the device drivers.  The =

> hwmod code will probably still try to write to those IP blocks if they ar=
e =

> listed as present in the hwmod data, during the initial reset-and-idle =

> phase.

Um, yeah, good point. :)

> What do you think about adding an am35xx_es11plus_hwmod_ocp_ifs[] array t=
o =

> omap_hwmod_3xxx_data.c for these secure hwmods?  That carries the implici=
t =

> and possibly wrong assumption that it's likely to be ES1.0 devices that =

> are missing the SHAM/AES, but it seems unlikely that TI would have =

> multiple silicon revs running around claiming to be ES1.1?  Or maybe I'm =

> just being na=EFve.

Something like that makes sense to me.  I'll re-read my email, etc. and
see if I can find something to help us figure it out.

> > The issue that you're likely running into is that 'CK_AM35XX' needs to =
be
> > added for aes2_ick & sha12_ick in cclock3xxx_data.c.   The following
> > patch should fix it (applies to my submitted/crypto/hwmod branch):
> > =

> > diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap=
2/cclock3xxx_data.c
> > index 582b055..aa5bdf6 100644
> > --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> > +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> > @@ -3332,10 +3332,10 @@ static struct omap_clk omap3xxx_clks[] =3D {
> >  	CLK("omap_hsmmc.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | =
CK_36XX),
> >  	CLK(NULL,	"mmchs3_ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_=
36XX),
> >  	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
> > -	CLK("omap-aes",	"ick",		&aes2_ick,	CK_34XX | CK_36XX),
> > -	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_34XX | CK_36XX),
> > -	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_36XX),
> > -	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_34XX | CK_36XX),
> > +	CLK("omap-aes",	"ick",		&aes2_ick,	CK_34XX | CK_AM35XX | CK_36XX),
> > +	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_34XX | CK_AM35XX | CK_36XX),
> > +	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_AM35XX | CK_36XX),
> > +	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_34XX | CK_AM35XX | CK_36XX),
> >  	CLK(NULL,	"des2_ick",	&des2_ick,	CK_34XX | CK_36XX),
> >  	CLK("omap_hsmmc.1",	"ick",	&mmchs2_ick,	CK_3XXX),
> >  	CLK("omap_hsmmc.0",	"ick",	&mmchs1_ick,	CK_3XXX),
> > =

> > =

> > Please let me know if this patch works for you and, if it does, I'll re=
spin
> > my patches to add those changes.
> =

> If those clocks are referenced by the hwmods, that that patch makes sense =

> to me.  Haven't had the chance to test it yet but maybe tomorrow.  On the =

> other hand it looks 'obviously correct' so maybe just add that change to =

> your patches and repost that one?

Will do.

Mark
--
