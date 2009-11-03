From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 2/5] omap: mux: Add new style pin multiplexing code for
	omap3
Date: Tue, 3 Nov 2009 08:56:54 +0200
Message-ID: <f870da180911022256g7ea80a43s6022c050b08ed9b1@mail.gmail.com>
References: <20091029203124.11843.89983.stgit@localhost>
	 <20091029203619.11843.76412.stgit@localhost>
	 <4AED6329.6030302@compulab.co.il> <20091102185453.GB6692@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:36557 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbZKCG4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 01:56:50 -0500
Received: by iwn10 with SMTP id 10so3937101iwn.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 22:56:55 -0800 (PST)
In-Reply-To: <20091102185453.GB6692@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

On Mon, Nov 2, 2009 at 8:54 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Mike Rapoport <mike@compulab.co.il> [091101 02:29]:
>>
>>
>> Tony Lindgren wrote:
>> > Initially only for 34xx. Keep the old code working
>> > until the data has been converted to the new style
>> > format.
>> >
>> > REVISIT: Add support for cmdline parsing
>> > REVISIT: Add a function to get mux register by GPIO pin
>> > REVISIT: Add a function to set an array of mux entries
>> >
>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>> > ---
>> > =A0arch/arm/mach-omap2/mux.c | =A0237 ++++++++++++++++++++++++++++=
+++++++++++++++++
>> > =A0arch/arm/mach-omap2/mux.h | =A0125 ++++++++++++++++++++++++
>> > =A02 files changed, 362 insertions(+), 0 deletions(-)
>> > =A0create mode 100644 arch/arm/mach-omap2/mux.h
>> >
>> > diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> > index 9841423..45e6d4d 100644
>> > --- a/arch/arm/mach-omap2/mux.c
>> > +++ b/arch/arm/mach-omap2/mux.c
>> > @@ -27,12 +27,15 @@
>> > =A0#include <linux/init.h>
>> > =A0#include <linux/io.h>
>> > =A0#include <linux/spinlock.h>
>> > +#include <linux/list.h>
>> >
>> > =A0#include <asm/system.h>
>> >
>> > =A0#include <plat/control.h>
>> > =A0#include <plat/mux.h>
>> >
>> > +#include "mux.h"
>>
>> Wouldn't <mach/mux.h> be better?
>
> Well I've been thinking that we should limit pin muxing to the board-=
*.c
> and platform_data init files under mach-omap2. Keeping the mux.h head=
er
> file under mach-omap2/mux.h would certainly flag any attempts to use =
it
> under drivers/* for example.
>
> The reasons being that if we limit muxing to the files under mach-oma=
p2,
> we can safely assume that the mux data and code is mostly __initdata
> and __init.
>
> And then we can safely do things like multiplex the pins with the rea=
l
> signal names without having to keep all the mux data wasting memory
> later on.
>
> Comments? I'm OK doing keeping it under mach/mux.h, but I'd like to
> establish a policy of doing the muxing only in platform init code
> under mach-omap2.

I have no strong prefernce for <mach/mux.h>. Keeping it under
mach-omap2 will make the policy definition easier. I'm ok with
"arch/arm/mach-omap2/mux.h".

>>
>> > =A0#ifdef CONFIG_OMAP_MUX
>> >
>> > =A0#define OMAP_MUX_BASE_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x30 =A0=
 =A0/* Offset from CTRL_BASE */
>> > @@ -626,6 +629,11 @@ static int __init_or_module omap24xx_cfg_reg(=
const struct pin_config *cfg)
>> > =A0#endif
>> >
>> > =A0#ifdef CONFIG_ARCH_OMAP34XX
>> > +
>> > +/*
>> > + * NOTE: This function will disappear soon, please use the new
>> > + * omap_mux_set() instead
>> > + */
>>
>> I think it's worth adding more visible notice, e.g. marking the func=
tion
>> deprecated or adding a WARN statement to its body.
>
> Agreed. I was thinking about writing a little script to convert the
> old mux entries to the new ones, and drop all the old code and data
> for omap3 hopefully this week..
>
>> > =A0static int __init_or_module omap34xx_cfg_reg(const struct pin_c=
onfig *cfg)
>> > =A0{
>> > =A0 =A0 static DEFINE_SPINLOCK(mux_spin_lock);
>> > @@ -644,6 +652,235 @@ static int __init_or_module omap34xx_cfg_reg=
(const struct pin_config *cfg)
>> > =A0#define omap34xx_cfg_reg =A0 NULL
>> > =A0#endif
>> >
>> > +/*---------------------------------------------------------------=
-------------*/
>> > +
>> > +#ifdef CONFIG_ARCH_OMAP34XX
>> > +
>> > +static LIST_HEAD(muxmodes);
>> > +static DEFINE_MUTEX(muxmode_mutex);
>> > +
>> > +/*
>> > + * REVISIT: See if pin is set dynamic, and add it to the list
>> > + */
>> > +int omap_mux_set(u16 val, u16 mux_offset, int flags)
>> > +{
>> > + =A0 omap_mux_write(val, mux_offset);
>> > +
>> > + =A0 return 0;
>> > +}
>> > +
>> > +struct omap_mux_entry {
>> > + =A0 struct omap_mux =A0 =A0 =A0 =A0 mux;
>> > + =A0 struct list_head =A0 =A0 =A0 =A0node;
>> > +};
>> > +
>> > +static struct omap_mux *omap_mux_list_add(struct omap_mux *src)
>> > +{
>> > + =A0 struct omap_mux_entry *entry;
>> > + =A0 struct omap_mux *m;
>> > +
>> > + =A0 int i;
>> > +
>> > + =A0 entry =3D kzalloc(sizeof(struct omap_mux_entry), GFP_KERNEL)=
;
>> > + =A0 if (!entry)
>> > + =A0 =A0 =A0 =A0 =A0 return NULL;
>> > +
>> > + =A0 m =3D &entry->mux;
>> > + =A0 memcpy(m, src, sizeof(struct omap_mux_entry));
>> > +
>> > +#ifdef CONFIG_DEBUG_FS
>> > + =A0 for (i =3D 0; i < OMAP_MUX_NR_MODES; i++) {
>> > + =A0 =A0 =A0 =A0 =A0 if (src->muxnames[i]) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->muxnames[i] =3D
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(strl=
en(src->muxnames[i]) + 1,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 GFP_KERNEL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!m->muxnames[i])
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_na=
mes;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(m->muxnames[i], src->=
muxnames[i]);
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 }
>> > + =A0 for (i =3D 0; i < OMAP_MUX_NR_SIDES; i++) {
>> > + =A0 =A0 =A0 =A0 =A0 if (src->balls[i]) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->balls[i] =3D
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(strl=
en(src->balls[i]) + 1,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 GFP_KERNEL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!m->balls[i])
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_ba=
lls;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(m->balls[i], src->bal=
ls[i]);
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 }
>> > +#endif
>> > +
>> > + =A0 mutex_lock(&muxmode_mutex);
>> > + =A0 list_add(&entry->node, &muxmodes);
>> > + =A0 mutex_unlock(&muxmode_mutex);
>> > +
>> > + =A0 return m;
>> > +
>> > +#ifdef CONFIG_DEBUG_FS
>> > +free_balls:
>> > + =A0 for (i =3D 0; i < OMAP_MUX_NR_SIDES; i++)
>> > + =A0 =A0 =A0 =A0 =A0 if (m->balls[i])
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(m->balls[i]);
>> > +free_names:
>> > + =A0 for (i =3D 0; i < OMAP_MUX_NR_MODES; i++)
>> > + =A0 =A0 =A0 =A0 =A0 if (m->muxnames[i])
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(m->muxnames[i]);
>> > +#endif
>> > +
>> > + =A0 kfree(entry);
>> > +
>> > + =A0 return NULL;
>> > +}
>> > +
>> > +static void __init omap_mux_apply_subset(struct omap_mux *p,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct omap_mux *superset)
>> > +{
>>
>> I'm not sure it is required.
>>
>> Is it for sure that CBC package will remain superset of all possible=
 mux modes
>> for all OMAP3 variants through entire OMAP3 lifespan? What about OMA=
P3630 and
>> OMAP3517? Are their packages also subset of the CBC one?
>
> Basically the mux registers are the same for all omap3, then the
> packaging determines which signal options are available for the
> package.
>
> Looks like 3630 changes the mux name for few entries, and adds some
> new registers, so that should be easily covered too.
>
> The superset may not always be named CBC, but we should have one
> omap3 superset still.

Agreed.

>> I'd rather keep the entire tables for different packages/CPU variant=
s. They are
>> anyway __initdata, so they would be discarded later during boot. And=
, keeping
>> the full tables rather than differences makes omap_mux_apply_subset =
and
>> unnecessary and omap_mux_apply_pins much simpler.
>
> I agree it would make it a bit simpler. But then we need to patch
> multiple data tables if we found errors in the data.
>
> And the signal data is mostly the same for all omap3.
>
>> If we keep the full tables instead of diffs we could do something li=
ke:
>>
>> static struct omap_mux *muxmodes;
>> static void __init omap_mux_apply_subset(struct omap_mux *p)
>> {
>> =A0 =A0 =A0 muxmodes =3D p;
>> }
>
> Right, that's the way I had it originally, but the amount of data
> duplicated three times so far looked ugly to me :)
>
>> > + =A0 while (p->reg_offset !=3D =A0OMAP_MUX_TERMINATOR) {
>> > + =A0 =A0 =A0 =A0 =A0 struct omap_mux *s =3D superset;
>> > + =A0 =A0 =A0 =A0 =A0 int found =3D 0;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 while (s->reg_offset !=3D OMAP_MUX_TERMINATO=
R) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->reg_offset =3D=3D p->=
reg_offset) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *s =3D *p;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found++;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s++;
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 if (!found)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mux: Unknow=
n entry offset 0x%x\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 p->reg_offset);
>> > + =A0 =A0 =A0 =A0 =A0 p++;
>> > + =A0 }
>> > +}
>> > +
>> > +#ifdef CONFIG_DEBUG_FS
>> > +
>> > +static void __init omap_mux_apply_pins(struct omap_ball *b,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
mux *superset)
>> > +{
>> > + =A0 while (b->reg_offset !=3D OMAP_MUX_TERMINATOR) {
>> > + =A0 =A0 =A0 =A0 =A0 struct omap_mux *s =3D superset;
>> > + =A0 =A0 =A0 =A0 =A0 int found =3D 0;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 while (s->reg_offset !=3D OMAP_MUX_TERMINATO=
R) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->reg_offset =3D=3D b->=
reg_offset) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->balls[0] =
=3D b->balls[0];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->balls[1] =
=3D b->balls[1];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found++;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> Again, if we keep the full tables instead of diffs we don't need the=
 nested
>> loop. Provided that balls table has pins in the same order as the mu=
x table we
>> could have only the assignments here.
>
> The difference with the balls compared to signals is that they are di=
fferent
> for each package. (Just to recap, the naming is a matrix of the pins
> where the coordinates are alphabets in one direction, and number
> in the other direction).
>
> So the pin data is really separate data from the mux register and
> signal data.
>
> Mux registers and signal names are mostly the same for each omap3,
> while the ball names are renamed for each package option.
>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s++;
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 if (!found)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mux: Unknow=
n ball offset 0x%x\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 b->reg_offset);
>> > + =A0 =A0 =A0 =A0 =A0 b++;
>> > + =A0 }
>> > +}
>> > +
>> > +#else =A0 =A0 =A0/* CONFIG_DEBUG_FS */
>> > +
>> > +static inline void omap_mux_apply_pins(struct omap_ball *b,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct omap_mux *superset)
>> > +{
>> > +}
>> > +
>> > +#endif =A0 =A0 /* CONFIG_DEBUG_FS */
>> > +
>> > +static void __init omap_mux_set_board(struct omap_board_mux *boar=
d)
>> > +{
>> > + =A0 while (board->reg_offset !=3D =A0OMAP_MUX_TERMINATOR) {
>> > + =A0 =A0 =A0 =A0 =A0 omap_mux_write(board->value, board->reg_offs=
et);
>> > + =A0 =A0 =A0 =A0 =A0 board++;
>> > + =A0 }
>> > +}
>> > +
>> > +static void __init omap_mux_init_dynamic(struct omap_board_mux *b=
oard_subset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct omap_mux *superset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int flags)
>> > +{
>> > + =A0 struct omap_mux *s =3D superset;
>> > + =A0 int always_dynamic =3D flags & OMAP_MUX_ALL_DYNAMIC;
>> > +
>> > + =A0 while (s->reg_offset !=3D =A0OMAP_MUX_TERMINATOR) {
>> > + =A0 =A0 =A0 =A0 =A0 struct omap_mux *entry;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 if (!always_dynamic) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 mode;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* GPIO pins must be always =
dynamic for PM */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D omap_mux_read(s->re=
g_offset) & 0x7;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mode !=3D OMAP_MUX_MODE4=
)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 entry =3D omap_mux_list_add(s);
>> > + =A0 =A0 =A0 =A0 =A0 if (!entry) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mux: Could =
not add entry\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 s++;
>> > + =A0 }
>> > +
>> > + =A0 if (always_dynamic)
>> > + =A0 =A0 =A0 =A0 =A0 return;
>> > +
>> > + =A0 /* Search for pins set as dynamic in the board-*.c file */
>> > + =A0 while (board_subset->reg_offset !=3D =A0OMAP_MUX_TERMINATOR)=
 {
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 /* GPIO pins are always dynamic, and already=
 handled */
>> > + =A0 =A0 =A0 =A0 =A0 if ((board_subset->value & 0x7) =3D=3D OMAP_=
MUX_MODE4)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 if (!(board_subset->flags & OMAP_MUX_DYNAMIC=
))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 s =3D superset;
>> > + =A0 =A0 =A0 =A0 =A0 while (s->reg_offset !=3D =A0OMAP_MUX_TERMIN=
ATOR) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->reg_offset =3D=3D boa=
rd_subset->reg_offset) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
mux *entry =3D omap_mux_list_add(s);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!entry) =
{
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 printk(KERN_ERR "mux: Could not add "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 "board entry\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 return;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s++;
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 board_subset++;
>> > + =A0 }
>> > +}
>> > +
>> > +/*
>> > + * Do not call this from board-*.c files, use omap3_mux_init() in=
stead
>> > + */
>> > +int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
mux *superset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
mux *package_subset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
board_mux *board_subset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
ball *package_balls,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int flags)
>> > +{
>> > + =A0 /*
>> > + =A0 =A0* REVISIT: Do the ioremap with mux_pbase here once after =
the old
>> > + =A0 =A0* code is gone
>> > + =A0 =A0* REVISIT: Do not initialize again if already called
>> > + =A0 =A0*/
>> > +
>> > + =A0 omap_mux_apply_subset(package_subset, superset);
>> > + =A0 omap_mux_apply_pins(package_balls, superset);
>> > + =A0 omap_mux_set_board(board_subset);
>> > + =A0 omap_mux_init_dynamic(board_subset, superset, flags);
>>
>> With full tables for each package we won't need superset here.
>
> Right, but the maintenance will be more of a pain because of
> the duplicate data. And we still need to copy the __initdata to
> the list for the configured entries.
>
>> > +
>> > + =A0 return 0;
>> > +}
>> > +
>> > +#endif
>> > +
>> > +/*---------------------------------------------------------------=
-------------*/
>> > +
>> > =A0int __init omap2_mux_init(void)
>> > =A0{
>> > =A0 =A0 u32 mux_pbase;
>> > diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>> > new file mode 100644
>> > index 0000000..a8453f5
>> > --- /dev/null
>> > +++ b/arch/arm/mach-omap2/mux.h
>>
>> Wouldn't arch/arm/mach-omap2/include/mach/mux.h be better?
>
> Unless we want to limit the usage of the code to board-*.c files,
> and not allow using it elsewhere. But I'm OK either way.

I think restricting mux usage to files under mach-omap2 is the right
thing to do, so let's keep it "arch/arm/mach-omap2/mux.h"

>> > @@ -0,0 +1,125 @@
>> > +/*
>> > + * Copyright (C) 2009 Nokia
>> > + * Copyright (C) 2009 Texas Instruments
>> > + *
>> > + * This program is free software; you can redistribute it and/or =
modify
>> > + * it under the terms of the GNU General Public License version 2=
 as
>> > + * published by the Free Software Foundation.
>> > + */
>> > +
>> > +#define OMAP_MUX_TERMINATOR =A0 =A0 =A0 =A00xffff
>> > +
>> > +/* 34xx mux mode options for each pin. See TRM for options */
>> > +#define OMAP_MUX_MODE0 =A0 =A0 =A00
>> > +#define OMAP_MUX_MODE1 =A0 =A0 =A01
>> > +#define OMAP_MUX_MODE2 =A0 =A0 =A02
>> > +#define OMAP_MUX_MODE3 =A0 =A0 =A03
>> > +#define OMAP_MUX_MODE4 =A0 =A0 =A04
>> > +#define OMAP_MUX_MODE5 =A0 =A0 =A05
>> > +#define OMAP_MUX_MODE6 =A0 =A0 =A06
>> > +#define OMAP_MUX_MODE7 =A0 =A0 =A07
>> > +
>> > +/* 24xx/34xx mux bit defines */
>> > +#define OMAP_PULL_ENA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 3)
>> > +#define OMAP_PULL_UP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
(1 << 4)
>> > +#define OMAP_ALTELECTRICALSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 5)
>> > +
>> > +/* 34xx specific mux bit defines */
>> > +#define OMAP_INPUT_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 8)
>> > +#define OMAP_OFF_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 9)
>> > +#define OMAP_OFFOUT_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 10)
>> > +#define OMAP_OFFOUT_VAL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1=
 << 11)
>> > +#define OMAP_OFF_PULL_EN =A0 =A0 =A0 =A0 =A0 (1 << 12)
>> > +#define OMAP_OFF_PULL_UP =A0 =A0 =A0 =A0 =A0 (1 << 13)
>> > +#define OMAP_WAKEUP_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 14)
>> > +
>> > +/* Active pin states */
>> > +#define OMAP_PIN_OUTPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> > +#define OMAP_PIN_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OM=
AP_INPUT_EN
>> > +#define OMAP_PIN_INPUT_PULLUP =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP_PU=
LL_ENA | OMAP_INPUT_EN \
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | OMAP_PULL_UP)
>> > +#define OMAP_PIN_INPUT_PULLDOWN =A0 =A0 =A0 =A0 =A0 =A0(OMAP_PULL=
_ENA | OMAP_INPUT_EN)
>> > +
>> > +/* Off mode states */
>> > +#define OMAP_PIN_OFF_NONE =A0 =A0 =A0 =A0 =A00
>> > +#define OMAP_PIN_OFF_OUTPUT_HIGH =A0 (OMAP_OFF_EN | OMAP_OFFOUT_E=
N \
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | OMAP_OFFOUT_VAL)
>> > +#define OMAP_PIN_OFF_OUTPUT_LOW =A0 =A0 =A0 =A0 =A0 =A0(OMAP_OFF_=
EN | OMAP_OFFOUT_EN)
>> > +#define OMAP_PIN_OFF_INPUT_PULLUP =A0(OMAP_OFF_EN | OMAP_OFF_PULL=
_EN \
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | OMAP_OFF_PULL_UP)
>> > +#define OMAP_PIN_OFF_INPUT_PULLDOWN =A0 =A0 =A0 =A0(OMAP_OFF_EN |=
 OMAP_OFF_PULL_EN)
>> > +#define OMAP_PIN_OFF_WAKEUPENABLE =A0OMAP_WAKEUP_EN
>> > +
>> > +/* Flags for struct omap_board_mux */
>> > +#define OMAP_MUX_DYNAMIC =A0 =A0 =A0 =A0 =A0 (1 << 0) =A0 =A0 =A0=
 =A0/* Keep mux in memory */
>> > +
>> > +/* Flags for omap_mux_init */
>> > +#define OMAP_MUX_ALL_DYNAMIC =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 16=
) =A0 =A0 =A0 /* Always in memory */
>> > +#define OMAP_PACKAGE_MASK =A0 =A0 =A0 =A0 =A00xffff
>> > +#define OMAP_PACKAGE_CUS =A0 =A0 =A0 =A0 =A0 3 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* 423-pin 0.65 */
>> > +#define OMAP_PACKAGE_CBB =A0 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* 515-pin 0.40 0.50 */
>> > +#define OMAP_PACKAGE_CBC =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* 515-pin 0.50 0.65 */
>> > +
>> > +
>> > +#define OMAP_MUX_NR_MODES =A08 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* Available modes */
>> > +#define OMAP_MUX_NR_SIDES =A02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* Bottom & top */
>> > +
>> > +/**
>> > + * struct omap_mux - data for omap mux register offset and it's v=
alue
>> > + * @reg_offset: =A0 =A0mux register offset from the mux base
>> > + * @gpio: =A0GPIO number
>> > + * @muxnames: =A0 =A0 =A0available signal modes for a ball
>> > + */
>> > +struct omap_mux {
>> > + =A0 u16 =A0 =A0 reg_offset;
>> > + =A0 u16 =A0 =A0 gpio;
>> > +#ifdef CONFIG_DEBUG_FS
>> > + =A0 char =A0 =A0*muxnames[OMAP_MUX_NR_MODES];
>> > + =A0 char =A0 =A0*balls[OMAP_MUX_NR_SIDES];
>> > +#endif
>> > +};
>> > +
>> > +/**
>> > + * struct omap_ball - data for balls on omap package
>> > + * @reg_offset: =A0 =A0mux register offset from the mux base
>> > + * @balls: available balls on the package
>> > + */
>> > +struct omap_ball {
>> > + =A0 u16 =A0 =A0 reg_offset;
>> > + =A0 char =A0 =A0*balls[OMAP_MUX_NR_SIDES];
>> > +};
>> > +
>> > +/**
>> > + * struct omap_board_mux - data for initializing mux registers
>> > + * @reg_offset: =A0 =A0mux register offset from the mux base
>> > + * @mux_value: =A0 =A0 desired mux value to set
>> > + * @flags: extra flags
>> > + */
>> > +struct omap_board_mux {
>> > + =A0 u16 =A0 =A0 reg_offset;
>> > + =A0 u16 =A0 =A0 value;
>> > + =A0 u32 =A0 =A0 flags;
>> > +};
>> > +
>> > +#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP34XX)
>> > +
>> > +int omap3_mux_init(struct omap_board_mux *board_mux_config, int f=
lags);
>> > +int omap_mux_init(u32 mux_pbase, u32 mux_size,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
mux *superset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
mux *package_subset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
board_mux *board_subset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_=
ball *package_balls,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int flags);
>> > +int omap_mux_set(u16 val, u16 mux_offset, int flags);
>> > +
>> > +#else
>> > +
>> > +static inline int omap3_mux_init(struct omap_board_mux *board_mux=
_config,
>> > + =A0 int flags)
>> > +{
>> > +}
>> > +static inline int omap_mux_set(u16 val, u16 mux_offset, int flags=
)
>> > +{
>> > +}
>> > +
>> > +#endif
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>>
>> --
>> Sincerely yours,
>> Mike.
>>
>>
>>
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
