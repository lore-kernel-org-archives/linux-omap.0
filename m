From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/11] staging: tidspbridge: header cleanup series
Date: Wed, 14 Jul 2010 12:27:01 +0300
Message-ID: <AANLkTikL3FyfN-PqA9f3fIFwqPJtbra5i1T-ETvJXDUa@mail.gmail.com>
References: <1278975369-7687-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278975369-7687-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 13, 2010 at 1:55 AM, Nishanth Menon <nm@ti.com> wrote:
> Series targetted to remove std.h, GlobalTypes.h and dbdefs.h. These
> introduce custom types and macros which dont make sense for linux ker=
nel
>
> Nishanth Menon (11):
> =C2=A0staging: tidspbridge: remove custom TRUE FALSE
> =C2=A0staging: tidspbridge: no need for custom NULL
> =C2=A0staging: tidspbridge: remove std.h
> =C2=A0staging: tidspbridge: remove custom typedef reg_uword32
> =C2=A0staging: tidspbridge: remove RET_OK RET_FAIL
> =C2=A0staging: tidspbridge: remove GlobalTypes.h
> =C2=A0staging: tidspbridge: replace CONST with c standard const
> =C2=A0staging: tidspbridge: remove IN modifier
> =C2=A0staging: tidspbridge: remove OPTIONAL
> =C2=A0staging: tidspbridge: remove OUT define
> =C2=A0staging: tidspbridge: remove dbdefs.h

=46WIW: Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

--=20
=46elipe Contreras
