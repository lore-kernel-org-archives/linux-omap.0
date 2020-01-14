From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: spi-ti-qspi: support large flash devices
Date: Tue, 14 Jan 2020 13:44:42 +0100
Message-ID: <CAORVsuUdLgZWfKdk+VBhYBbxaQbmkgvmqdsR_YcK9WtiERsesA@mail.gmail.com>
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
 <20191211193954.747745-3-jean.pihet@newoldbits.com> <20191220130830.GH4790@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191220130830.GH4790-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryan Barnett <ryan.barnett-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, Conrad Ratschan <conrad.ratschan-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, Arnout Vandecappelle <arnout.vandecappelle-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Fri, Dec 20, 2019 at 2:08 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Wed, Dec 11, 2019 at 08:39:53PM +0100, Jean Pihet wrote:
>
> > +                     if (op->addr.val + op->data.nbytes > qspi->mmap_s=
ize) {
> > +                             max_len =3D qspi->mmap_size - op->addr.va=
l;
> > +                             op->data.nbytes =3D min(op->data.nbytes, =
max_len);
> > +                     }
>
> This introduces a massive warning splat for me (just one warning but
> it's very verbose):
>
>   CC      drivers/spi/spi-ti-qspi.o
> In file included from drivers/spi/spi-ti-qspi.c:9:
> drivers/spi/spi-ti-qspi.c: In function =E2=80=98ti_qspi_adjust_op_size=E2=
=80=99:
> ./include/linux/kernel.h:844:29: warning: comparison of distinct pointer =
types lacks a cast
>    (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>                              ^~
> ./include/linux/kernel.h:858:4: note: in expansion of macro =E2=80=98__ty=
pecheck=E2=80=99
>    (__typecheck(x, y) && __no_side_effects(x, y))
>     ^~~~~~~~~~~
> ./include/linux/kernel.h:868:24: note: in expansion of macro =E2=80=98__s=
afe_cmp=E2=80=99
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> ./include/linux/kernel.h:877:19: note: in expansion of macro =E2=80=98__c=
areful_cmp=E2=80=99
>  #define min(x, y) __careful_cmp(x, y, <)
>                    ^~~~~~~~~~~~~
> drivers/spi/spi-ti-qspi.c:535:23: note: in expansion of macro =E2=80=98mi=
n=E2=80=99
>      op->data.nbytes =3D min(op->data.nbytes, max_len);
>                        ^~~
> ./include/linux/kernel.h:844:29: warning: comparison of distinct pointer =
types lacks a cast
>    (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>                              ^~
> ./include/linux/kernel.h:858:4: note: in expansion of macro =E2=80=98__ty=
pecheck=E2=80=99
>    (__typecheck(x, y) && __no_side_effects(x, y))
>     ^~~~~~~~~~~
> ./include/linux/kernel.h:868:24: note: in expansion of macro =E2=80=98__s=
afe_cmp=E2=80=99
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> ./include/linux/kernel.h:877:19: note: in expansion of macro =E2=80=98__c=
areful_cmp=E2=80=99
>  #define min(x, y) __careful_cmp(x, y, <)
>                    ^~~~~~~~~~~~~
> drivers/spi/spi-ti-qspi.c:545:22: note: in expansion of macro =E2=80=98mi=
n=E2=80=99
>     op->data.nbytes =3D min(op->data.nbytes, max_len);
>                       ^~~
>
> Using compilers from Debian stable.

A new v3 release has been submitted, with the warnings fixed with
CONFIG_COMPILE_TEST enabled.

Thanks,
Jean
