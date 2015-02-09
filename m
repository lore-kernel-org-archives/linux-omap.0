From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: fix compilation warnings when
 !CONFIG_PM_SLEEP
Date: Mon, 9 Feb 2015 15:53:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502091552560.3767@utopia.booyaka.com>
References: <alpine.DEB.2.02.1502062259190.3767@utopia.booyaka.com> <20150209150009.GA21362@kahuna>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-436478244-1423497201=:3767"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150209150009.GA21362@kahuna>
Sender: linux-pm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii.Strashko@linaro.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-436478244-1423497201=:3767
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Feb 2015, Nishanth Menon wrote:

> On 00:17-20150207, Paul Walmsley wrote:
> >=20
> > When CONFIG_PM_SLEEP=3Dn, the following compilation warnings appear:
> >=20
> > drivers/thermal/ti-soc-thermal/ti-bandgap.c:1478:12: warning: =E2=80=98=
ti_bandgap_suspend=E2=80=99 defined but not used [-Wunused-function]
> >  static int ti_bandgap_suspend(struct device *dev)
> >             ^
> > drivers/thermal/ti-soc-thermal/ti-bandgap.c:1492:12: warning: =E2=80=98=
ti_bandgap_resume=E2=80=99 defined but not used [-Wunused-function]
> >  static int ti_bandgap_resume(struct device *dev)
> >=20
> > A few years ago, suspend/resume-related code was protected by CONFIG_PM=
=2E =20
> > But that was changed and now it's protected by CONFIG_PM_SLEEP.  Fix th=
e=20
> > warnings by converting the preprocessor test in the TI bandgap thermal=
=20
> > sensor driver from testing CONFIG_PM to testing CONFIG_PM_SLEEP.
> >=20
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >=20
> > Non-critical.  Targeted for either v3.20-rc1 or v3.21-rc1.
> >=20
> > Basic test reports for a series that includes this patch (and a few oth=
er=20
> > unrelated warning cleanups) is available here:
> >=20
> > http://www.pwsan.com/omap/testlogs/fix-omap-warnings-v3.21/201502061546=
19/
> >=20
> > Compare to:
> >=20
> > http://www.pwsan.com/omap/testlogs/test_v3.19-rc7/20150204213018/
> >=20
> >  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/ther=
mal/ti-soc-thermal/ti-bandgap.c
> > index 634b6ce0e63a..62a5d449c388 100644
> > --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > @@ -1402,7 +1402,7 @@ int ti_bandgap_remove(struct platform_device *pde=
v)
> >  =09return 0;
> >  }
> > =20
> > -#ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP
> >  static int ti_bandgap_save_ctxt(struct ti_bandgap *bgp)
> >  {
> >  =09int i;
> > --=20
> > 2.1.4
>=20
>=20
> I am a little confused:
> https://patchwork.kernel.org/patch/5792411/ was already posted. would
> you suggest improvements?

Oh, nothing to be confused by, I just missed the earlier patch.  I=20
withdraw mine.


- Paul
--843723315-436478244-1423497201=:3767--
