From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: problems compiling latest git update
Date: Tue, 18 Sep 2007 13:12:44 -0300
Message-ID: <ae36f8040709180912w4a624578xb6cf22a46cc0135e@mail.gmail.com>
References: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
	<31e679430709180729m7ac96736g10b45d71802b86fd@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430709180729m7ac96736g10b45d71802b86fd@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

I'm using the same HEAD, yes I'm  with 100% sure that I'm using the latest
tree

On 9/18/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
>
> Hi,
>
> On 9/18/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> > Hi I uopgraded the source tree to latest creating a new kernel version
> for
> > my device (latest), but i found two things, one is the following error:
> > arch/arm/plat-omap/devices.c: In function 'omap_init_mmc':
> > arch/arm/plat-omap/devices.c:348: error: 'OMAP2_CTRL_BASE' undeclared
> (first
> > use in this function)
> > arch/arm/plat-omap/devices.c:348: error: (Each undeclared identifier is
> > reported only once
> > arch/arm/plat-omap/devices.c:348: error: for each function it appears
> in.)
>
> Are you really using most recent linux-omap tree??
>
> I'm building with omap_h4_2420_defconfig and it's fine.
>
> My current HEAD is:
> 41283eed64c3279f62fede457ed56aced5ac2f89
>
> >
> > other is, where are the DSP config options ?
> >
> >
> > --
> >
> -------------------------------------------------------------------------=
-----
> > Thanks && Regards
> > Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> > IEEE Member
> > Electrical Engineer Faculty @ PUCRS
> > Ipiranga Avenue, 6681 =96 Building 30
> > P.O. Box: 90619-900 =96 Porto Alegre/RS
> > Phone: +55 51 3320 3500  extension: 7696
> >
> -------------------------------------------------------------------------=
--------
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
>
> --
> Best Regards,
>
> Felipe Balbi
> felipebalbi@users.sourceforge.net
>



--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
