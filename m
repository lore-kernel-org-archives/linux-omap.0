From: Niels de Vos <ndevos@redhat.com>
Subject: Re: [PATCH] omap2/omapfb: make DBG() more resistant in if-else constructions
Date: Tue, 10 May 2011 11:57:18 +0100
Message-ID: <BANLkTim0Wao+dX-+GpKxdsHtg96DF1bHyw@mail.gmail.com>
References: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
	<BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
Reply-To: devos@fedoraproject.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Premi, Sanjeev" <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, May 10, 2011 at 10:42 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, May 10, 2011 at 11:20, Niels de Vos <ndevos@redhat.com> wrote=
:
>> When DBG() is used in a simple if-else, the resulting code path
>> currently depends on the definition of DBG(). Inserting the statemen=
t in
>> a "do { ... } while (0)" prevents this possible misuse.
>>
>> Signed-off-by: Niels de Vos <ndevos@redhat.com>
>
>> --- a/drivers/video/omap2/omapfb/omapfb.h
>> +++ b/drivers/video/omap2/omapfb/omapfb.h
>> @@ -34,8 +34,10 @@
>> =C2=A0#ifdef DEBUG
>> =C2=A0extern unsigned int omapfb_debug;
>> =C2=A0#define DBG(format, ...) \
>> - =C2=A0 =C2=A0 =C2=A0 if (omapfb_debug) \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG=
 "OMAPFB: " format, ## __VA_ARGS__)
>> + =C2=A0 =C2=A0 =C2=A0 do { \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omapfb_debug)=
 \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 printk(KERN_DEBUG "OMAPFB: " format, ## __VA_ARGS__); \
>> + =C2=A0 =C2=A0 =C2=A0 while (0)
>
> Where's the closing '}'?

Good catch! That's in a "fixup!" that I forgot to squash :-/
I'll post an update version in a bit.


>> =C2=A0#else
>> =C2=A0#define DBG(format, ...)
>
> BTW, no printf()-style format checking here.
>
>> =C2=A0#endif
>
> What about using the standard pr_debug()/dev_dbg() instead?
> With dynamic debug, it can be enabled at run time.
> As a bonus, you get printf()-style format checking if debugging is di=
sabled.

I think removing DBG() and the omapfb_debug module-parameter is surely
a good thing. Unfortunately DBG() is used quite a bit in the code and
replacing them 'll take some more time. I don't know yet when I find
some time to do and test that.

Thanks for the pointers,
Niels


> Gr{oetje,eeting}s,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
>
>
