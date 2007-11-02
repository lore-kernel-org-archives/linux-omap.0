From: Kevin Hilman <khilman@mvista.com>
Subject: Re: warning on compilation of kernel & another question device
	driver related
Date: Thu, 01 Nov 2007 17:13:31 -0700
Message-ID: <1193962411.6144.92.camel@vence.hilman.org>
References: <ae36f8040711011338m48e86deeo18219805af5e4fae@mail.gmail.com>
	<1193949992.6144.35.camel@vence.hilman.org>
	<ae36f8040711011439q2d7c633bp4507bc51dd2d122f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040711011439q2d7c633bp4507bc51dd2d122f@mail.gmail.com>
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

On Thu, 2007-11-01 at 19:39 -0200, Lu=C3=ADs Cargnini wrote:
> I added but it still occuring:
>=20
> WARNING: vmlinux.o(.data+0x2994): Section mismatch: reference
> to .init.text: (between 'omap1_clk_functions' and 'rate_table')

Ah, I missed the __init in clock.h.  Will resend the patch.

Kevin

> On 11/1/07, Kevin Hilman <khilman@mvista.com> wrote:
>         On Thu, 2007-11-01 at 18:38 -0200, Lu=C3=ADs Cargnini wrote:
>         > Dear fellows,
>         > Please while compiling my kernel I'm founding the following
>         warning message:
>         >  AS      .tmp_kallsyms2.o
>         >   LD      vmlinux.o=20
>         >   MODPOST vmlinux.o
>         > WARNING: vmlinux.o(.data+0x2994): Section mismatch:
>         reference to .init.text:
>         > (between 'omap1_clk_functions' and 'rate_table')
>         >   LD      vmlinux
>         >  someone else have the same problem ? If so how to fix
>         this ?=20
>        =20
>         I'm guessing you have OMAP_RESET_CLOCKS enabled.
>        =20
>         Try the patch I sent earlier today:
>         http://linux.omap.com/pipermail/linux-omap-open-source/2007-Nov=
ember/011844.html
>        =20
>         Kevin
>        =20
>        =20
>=20
>=20
>=20
> --=20
> -----------------------------------------------------------------------=
-------
> Thanks && Regards
> Msc. Bsc. Lu=C3=ADs Vit=C3=B3rio Cargnini=20
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =E2=80=93 Building 30 =20
> P.O. Box: 90619-900 =E2=80=93 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> -----------------------------------------------------------------------=
----------
