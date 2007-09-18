From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: problems compiling latest git update
Date: Tue, 18 Sep 2007 10:29:14 -0400
Message-ID: <31e679430709180729m7ac96736g10b45d71802b86fd@mail.gmail.com>
References: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
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
To: lvcargnini@gmail.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 9/18/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> Hi I uopgraded the source tree to latest creating a new kernel version fo=
r
> my device (latest), but i found two things, one is the following error:
> arch/arm/plat-omap/devices.c: In function 'omap_init_mmc':
> arch/arm/plat-omap/devices.c:348: error: 'OMAP2_CTRL_BASE' undeclared (fi=
rst
> use in this function)
> arch/arm/plat-omap/devices.c:348: error: (Each undeclared identifier is
> reported only once
> arch/arm/plat-omap/devices.c:348: error: for each function it appears in.=
)

Are you really using most recent linux-omap tree??

I'm building with omap_h4_2420_defconfig and it's fine.

My current HEAD is:
41283eed64c3279f62fede457ed56aced5ac2f89

>
> other is, where are the DSP config options ?
>
>
> --
> -------------------------------------------------------------------------=
-----
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =96 Building 30
> P.O. Box: 90619-900 =96 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> -------------------------------------------------------------------------=
--------
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


--=20
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
