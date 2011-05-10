From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] omap2/omapfb: make DBG() more resistant in if-else constructions
Date: Tue, 10 May 2011 14:14:20 +0200
Message-ID: <BANLkTi=dCF-EskTECWpfmFmf-UL0ZjLCqw@mail.gmail.com>
References: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
	<BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
	<1305029285.2045.38.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305029285.2045.38.camel@deskari>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Niels de Vos <ndevos@redhat.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 10, 2011 at 14:08, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> On Tue, 2011-05-10 at 11:42 +0200, Geert Uytterhoeven wrote:
>> What about using the standard pr_debug()/dev_dbg() instead?
>> With dynamic debug, it can be enabled at run time.
>> As a bonus, you get printf()-style format checking if debugging is d=
isabled.
>
> Yes, dev_dbg & co. would be better.
>
> However, one thing I dislike about them is the extra stuff they print=
=2E
> For example, for omapfb and omapdss dev_dbg will print:
>
> omapfb omapfb: foo
> omapdss_dss omapdss_dss: foo
>
> I originally added the debug macros to omapdss to be able to
> automatically print the DSS module name, as at that point there was o=
nly
> one big omapdss device. And I guess I just followed with similar macr=
o
> in omapfb also. But I believe both omapdss and omapfb should be chang=
ed
> to dev_* prints sometime soon.

If you don't want the extra baggage, do

        #define pr_fmt(fmt)     KBUILD_MODNAME ": " fmt

and use pr_debug().

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
