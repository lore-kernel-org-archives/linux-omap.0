From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Wed, 19 Aug 2015 10:11:39 +0200
Message-ID: <20150819081139.GB15712@pali>
References: <201507241803.42891@pali>
 <CAHnt0GX6442mtZ=J6CS_60TyTeUu==oROcf4Y=upHGSr71X3EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHnt0GX6442mtZ=J6CS_60TyTeUu==oROcf4Y=upHGSr71X3EA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 18 August 2015 07:11:27 Peter Teoh wrote:
> On Fri, Jul 24, 2015 at 9:03 AM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> >
> > Hello,
> >
> > when on N900 (real HW or qemu) I run this command
> >
> > / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo=
 0 > /sys/class/graphics/fb0/size
> >
> > then kernel crash with this error message
> >
> > / # [   29.904113] Division by zero in kernel.
> > ** 3375 printk messages dropped ** [   29.963836] [<c01e0008>] (__a=
eabi_uidivmod) from [<c022071c>]
> > (cfb_imageblit+0xac/0x464)
> > ** 8426 printk messages dropped ** [   30.111083] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8380 printk messages dropped ** [   30.258209] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7813 printk messages dropped ** [   30.400054] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7666 printk messages dropped ** [   30.538391] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7687 printk messages dropped ** [   30.676544] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7960 printk messages dropped ** [   30.819915] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8317 printk messages dropped ** [   30.966979] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8590 printk messages dropped ** [   31.122528] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8885 printk messages dropped ** [   31.287658] [<c0218ed0>] (fbc=
on_scroll) from [<c025af90>] (scrup+0x60/0x128)
> > ** 9408 printk messages dropped ** [   31.461425] [<c02187a4>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 9787 printk messages dropped ** [   31.644287] [<c02187e8>] (fbc=
on_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10081 printk messages dropped ** [   31.833984] [<c02187a4>] (fb=
con_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10501 printk messages dropped ** [   32.031066] [<c02187a4>] (fb=
con_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10816 printk messages dropped ** [   32.233001] [<c02187a4>] (fb=
con_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10900 printk messages dropped ** [   32.440490] [<c02187a4>] (fb=
con_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10837 printk messages dropped ** [   32.645233] [<c02187a4>] (fb=
con_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10837 printk messages dropped ** [   32.848999] [<c02187a4>] (fb=
con_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10837 printk messages dropped ** [   33.053833] [<c02187a4>] (fb=
con_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10838 printk messages dropped ** [   33.258361] [<c0218ed0>] (fb=
con_scroll) from [<c025af90>] (scrup+0x60/0x128)
> >
> > I suspect that problem is in omapdss.
> >
> > I do not know if size 0 make sense, but Maemo userspace is calling =
above
> > commands and on Nokia's 2.6.28 kernel there is no crash or error me=
ssage.
> >
> > IMHO Division by zero in kernel should not be there even if userspa=
ce
> > call "incorrect" command.
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
>=20
>=20
> Not sure if my analysis is correct.   According to the recent pull
> (4.2.0-rc4+), the code is still vulnerable to this division by zero:
>=20
> Inside drivers/video/fbdev/core/cfbimgblt.c:
>=20
> void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
> {
>         u32 fgcolor, bgcolor, start_index, bitstart, pitch_index =3D =
0;
>         u32 bpl =3D sizeof(u32), bpp =3D p->var.bits_per_pixel;
>         u32 width =3D image->width;
>         u32 dx =3D image->dx, dy =3D image->dy;
>         u8 __iomem *dst1;
>=20
>         if (p->state !=3D FBINFO_STATE_RUNNING)
>                 return;
>=20
>         bitstart =3D (dy * p->fix.line_length * 8) + (dx * bpp);
>         start_index =3D bitstart & (32 - 1);
>         pitch_index =3D (p->fix.line_length & (bpl - 1)) * 8;
>=20
>         bitstart /=3D 8;
>         bitstart &=3D ~(bpl - 1);
>         dst1 =3D p->screen_base + bitstart;
>=20
>         if (p->fbops->fb_sync)
>                 p->fbops->fb_sync(p);
>=20
>         if (image->depth =3D=3D 1) {
>                 if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
>                     p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
>                         fgcolor =3D ((u32*)(p->pseudo_palette))[image=
->fg_color];
>                         bgcolor =3D ((u32*)(p->pseudo_palette))[image=
->bg_color];
>                 } else {
>                         fgcolor =3D image->fg_color;
>                         bgcolor =3D image->bg_color;
>                 }
>=20
>                 if (32 % bpp =3D=3D 0 && !start_index && !pitch_index=
 &&
>                     ((width & (32/bpp-1)) =3D=3D 0) &&
>                     bpp >=3D 8 && bpp <=3D 32)
>                         fast_imageblit(image, p, dst1, fgcolor, bgcol=
or);
>                 else
>                         slow_imageblit(image, p, dst1, fgcolor, bgcol=
or,
>                                         start_index, pitch_index);
>         } else
>                 color_imageblit(image, p, dst1, start_index, pitch_i
>=20
>=20
> Notice that bpp is not checked for zero, and thus bpp=3D=3D0 is total=
ly
> feasible?   resulting in 32/bpp crashing the kernel?
>=20

Hm... this could really be a problem! But how to patch it? Which branch
should be called (fast_ or slow_ function) if bpp is zero?

And is there some way to force kernel to dump backtrace into dmesg when
division by zero occur?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
