From: Peter Teoh <htmldeveloper@gmail.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Tue, 18 Aug 2015 07:11:27 -0700
Message-ID: <CAHnt0GX6442mtZ=J6CS_60TyTeUu==oROcf4Y=upHGSr71X3EA@mail.gmail.com>
References: <201507241803.42891@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507241803.42891@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 24, 2015 at 9:03 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
>
> Hello,
>
> when on N900 (real HW or qemu) I run this command
>
> / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0=
 > /sys/class/graphics/fb0/size
>
> then kernel crash with this error message
>
> / # [   29.904113] Division by zero in kernel.
> ** 3375 printk messages dropped ** [   29.963836] [<c01e0008>] (__aea=
bi_uidivmod) from [<c022071c>]
> (cfb_imageblit+0xac/0x464)
> ** 8426 printk messages dropped ** [   30.111083] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8380 printk messages dropped ** [   30.258209] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7813 printk messages dropped ** [   30.400054] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7666 printk messages dropped ** [   30.538391] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7687 printk messages dropped ** [   30.676544] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7960 printk messages dropped ** [   30.819915] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8317 printk messages dropped ** [   30.966979] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8590 printk messages dropped ** [   31.122528] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8885 printk messages dropped ** [   31.287658] [<c0218ed0>] (fbcon=
_scroll) from [<c025af90>] (scrup+0x60/0x128)
> ** 9408 printk messages dropped ** [   31.461425] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 9787 printk messages dropped ** [   31.644287] [<c02187e8>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10081 printk messages dropped ** [   31.833984] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10501 printk messages dropped ** [   32.031066] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10816 printk messages dropped ** [   32.233001] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10900 printk messages dropped ** [   32.440490] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   32.645233] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   32.848999] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   33.053833] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10838 printk messages dropped ** [   33.258361] [<c0218ed0>] (fbco=
n_scroll) from [<c025af90>] (scrup+0x60/0x128)
>
> I suspect that problem is in omapdss.
>
> I do not know if size 0 make sense, but Maemo userspace is calling ab=
ove
> commands and on Nokia's 2.6.28 kernel there is no crash or error mess=
age.
>
> IMHO Division by zero in kernel should not be there even if userspace
> call "incorrect" command.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



Not sure if my analysis is correct.   According to the recent pull
(4.2.0-rc4+), the code is still vulnerable to this division by zero:

Inside drivers/video/fbdev/core/cfbimgblt.c:

void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
{
        u32 fgcolor, bgcolor, start_index, bitstart, pitch_index =3D 0;
        u32 bpl =3D sizeof(u32), bpp =3D p->var.bits_per_pixel;
        u32 width =3D image->width;
        u32 dx =3D image->dx, dy =3D image->dy;
        u8 __iomem *dst1;

        if (p->state !=3D FBINFO_STATE_RUNNING)
                return;

        bitstart =3D (dy * p->fix.line_length * 8) + (dx * bpp);
        start_index =3D bitstart & (32 - 1);
        pitch_index =3D (p->fix.line_length & (bpl - 1)) * 8;

        bitstart /=3D 8;
        bitstart &=3D ~(bpl - 1);
        dst1 =3D p->screen_base + bitstart;

        if (p->fbops->fb_sync)
                p->fbops->fb_sync(p);

        if (image->depth =3D=3D 1) {
                if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
                    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
                        fgcolor =3D ((u32*)(p->pseudo_palette))[image->=
fg_color];
                        bgcolor =3D ((u32*)(p->pseudo_palette))[image->=
bg_color];
                } else {
                        fgcolor =3D image->fg_color;
                        bgcolor =3D image->bg_color;
                }

                if (32 % bpp =3D=3D 0 && !start_index && !pitch_index &=
&
                    ((width & (32/bpp-1)) =3D=3D 0) &&
                    bpp >=3D 8 && bpp <=3D 32)
                        fast_imageblit(image, p, dst1, fgcolor, bgcolor=
);
                else
                        slow_imageblit(image, p, dst1, fgcolor, bgcolor=
,
                                        start_index, pitch_index);
        } else
                color_imageblit(image, p, dst1, start_index, pitch_i


Notice that bpp is not checked for zero, and thus bpp=3D=3D0 is totally
feasible?   resulting in 32/bpp crashing the kernel?

--=20
Regards,
Peter Teoh
