From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] omap2/omapfb: make DBG() more resistant in if-else constructions
Date: Tue, 10 May 2011 11:42:01 +0200
Message-ID: <BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
References: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Niels de Vos <ndevos@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 10, 2011 at 11:20, Niels de Vos <ndevos@redhat.com> wrote:
> When DBG() is used in a simple if-else, the resulting code path
> currently depends on the definition of DBG(). Inserting the statement=
 in
> a "do { ... } while (0)" prevents this possible misuse.
>
> Signed-off-by: Niels de Vos <ndevos@redhat.com>

> --- a/drivers/video/omap2/omapfb/omapfb.h
> +++ b/drivers/video/omap2/omapfb/omapfb.h
> @@ -34,8 +34,10 @@
> =C2=A0#ifdef DEBUG
> =C2=A0extern unsigned int omapfb_debug;
> =C2=A0#define DBG(format, ...) \
> - =C2=A0 =C2=A0 =C2=A0 if (omapfb_debug) \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG =
"OMAPFB: " format, ## __VA_ARGS__)
> + =C2=A0 =C2=A0 =C2=A0 do { \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omapfb_debug) =
\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_DEBUG "OMAPFB: " format, ## __VA_ARGS__); \
> + =C2=A0 =C2=A0 =C2=A0 while (0)

Where's the closing '}'?

> =C2=A0#else
> =C2=A0#define DBG(format, ...)

BTW, no printf()-style format checking here.

> =C2=A0#endif

What about using the standard pr_debug()/dev_dbg() instead?
With dynamic debug, it can be enabled at run time.
As a bonus, you get printf()-style format checking if debugging is disa=
bled.


Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
