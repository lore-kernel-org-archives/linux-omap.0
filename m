From: "Manoj Kotnala" <kotnala@TechMahindra.com>
Subject: Re: NFS Bootargs
Date: Thu, 10 Aug 2006 10:36:41 +0530
Message-ID: <FD17D65012AEA049AF96FD6A415F470E031A2C20@SINPUNEX001.TechMahindra.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Andy,

Are you using BusyBox?
If yes, you need to enable one option in Busybox config (related to NFS=
 support)..

Regards,

Manoj Kotnala




-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com=
 [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of=
 linux-omap-open-source-request@linux.omap.com
Sent: Thursday, August 10, 2006 10:26 AM
To: linux-omap-open-source@linux.omap.com
Subject: Linux-omap-open-source Digest, Vol 28, Issue 14

Send Linux-omap-open-source mailing list submissions to
	linux-omap-open-source@linux.omap.com

To subscribe or unsubscribe via the World Wide Web, visit
	http://linux.omap.com/mailman/listinfo/linux-omap-open-source
or, via email, send a message with subject or body 'help' to
	linux-omap-open-source-request@linux.omap.com

You can reach the person managing the list at
	linux-omap-open-source-owner@linux.omap.com

When replying, please edit your Subject line so it is more specific than=
 "Re: Contents of Linux-omap-open-source digest..."


Today's Topics:

   1. Re: NFS Bootargs (Mark Howell)
   2. Re: ARM: OMAP: Fix OMAP1 compilation after MPUIO check
      change. (Mark Howell)
   3. Re: [PATCH 1/3] aic23: Kconfig fixes for alsa and oss
      drivers. (lamikr)
   4. Re: status of OMAP ALSA support (lamikr)
   5. MCSI & MCBSP howto configure as gpio (Arnold)
   6. Re: Pending July patches (andrzej zaborowski)
   7. RE: MCSI & MCBSP howto configure as gpio (Khasim, Syed)
   8. Re: Suspending with keypad bug (RFC) (andrzej zaborowski)


----------------------------------------------------------------------

Message: 1
Date: Wed, 09 Aug 2006 16:45:47 -0700
From: Mark Howell <mhowell@northlink.com>
Subject: Re: NFS Bootargs
To: Abot Botbot <dejanigma@hotmail.com>
Cc: linux-omap-open-source@linux.omap.com
Message-ID: <44DA73AB.4050104@northlink.com>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Abot Botbot wrote:
> Hello all,
>=0D
>=0D
>    I'm trying to boot off an NFS share as laid out in the OSK Users=0D
> guide so I can begin my software development process. My buidling of=0D
> the system with the approrpiate makefiles has all gone seamlessly. I=0D
> am attempting to boot from the NFS share on my linux machine, which=0D
> I've demonstrated is possible from a neighboring machine. The error is=0D
> as
> follows:
>=0D
> Kernel panic: No init found.  Try passing init=3D option to kernel.
>=0D
> I have tried putting an "init=3D/bin/sh" argument into the bootargs=0D
> string, but that hasn't solved the problem. Does anyone else have a=0D
> bootargs string for an NFS share that they have used succesfully? Here=0D
> is the string I am currently using for refference:
>=0D
> console=3DttyS0,115200n8 noinitrd rw ip=3Ddhcp root=3D/dev/nfs=0D
> nfsroot=3D192.168.1.101:/home/usr/projects/filesys,nolock mem=3D30M=0D
> init=3D/bin/sh
>=0D
> Thanks for your help,
> Andy
>=0D
[snip]

Andy, this is a working NFS boot string for my 1611 H2 with today's git
kernel:

mem=3D32M console=3DttyS0,115200n8 noinitrd root=3D/dev/nfs rw nfsroot=
=3D172.30.2.32:/home/markh/omap/nfsroot ip=3Ddhcp

Cheers,

Mark.



------------------------------

Message: 2
Date: Wed, 09 Aug 2006 16:46:39 -0700
From: Mark Howell <mhowell@northlink.com>
Subject: Re: ARM: OMAP: Fix OMAP1 compilation after MPUIO check
	change.
To: linux-omap-open-source@linux.omap.com, Imre Deak
	<imre.deak@solidboot.com>
Message-ID: <44DA73DF.7080308@northlink.com>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Jonathan McDowell wrote:
> The recent MPUIO range change fix breaks compilation if=0D
> CONFIG_ARCH_OMAP24XX isn't defined; it should be OMAP_MAX_GPIO_LINES=0D
> not MAX_GPIO_LINES I believe. This one liner fixes it.
>=0D

Thanks, this works for me on my 1611 H2 with today's 2.6.18-rc4 from git.=
 Mark.



------------------------------

Message: 3
Date: Thu, 10 Aug 2006 03:29:20 +0300
From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 1/3] aic23: Kconfig fixes for alsa and oss
	drivers.
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
Message-ID: <44DA7DE0.6000200@cc.jyu.fi>
Content-Type: text/plain; charset=3DISO-8859-1

Tony Lindgren wrote:
> * lamikr <lamikr@cc.jyu.fi> [060525 13:54]:
>  =0D
>> Kconfig fixes to prevent unselecting I2C and I2C-omap drivers is=0D
>> aic23 sound driver is selected.
>>    =0D
>
> Pushing all 3 patches today.
>
> Tony
>
>  =0D
Tony

I noticed that patches 2 and 3 are not applied. James Selvam tested that=
 they were needed in order to get sounds working with innovator.
Can you you still apply the old patches or should I resend them? (Send=
 originally in 25.5.2006)

In addition to these, audio_process_dma from omap-alsa.c will also need one=
 more fix that I can send separately.
(2 #ifdef CONFIG_MACH_OMAP_H6300 definitions must be changed to #ifdef
CONFIG_ARCH_OMAP15XX)

Mika


------------------------------

Message: 4
Date: Thu, 10 Aug 2006 03:42:03 +0300
From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: status of OMAP ALSA support
To: "Zhang, Jian" <jzhang@ti.com>
Cc: linux-omap-open-source@linux.omap.com
Message-ID: <44DA80DB.7010700@cc.jyu.fi>
Content-Type: text/plain; charset=3Dus-ascii

Zhang, Jian wrote:
> Hi,
>
> Does OMAP ALSA driver work? Neither H4 nor H3 has it in default=0D
> configuration.
>  =0D
Yes, the aic23 has been tested with board-osk and tsc2101 has been tested=
 with the board-osk and board-h6300. (h6300 specific code is not yet send=
 to omap-kernel list, but you can check the h6300 port of omap 2.6.16=
 kernel it by using command:
svn export svn://fuzzyneural.net/h6300/omap-linux/branches/h6300_dev

> I see the following in tsc2101 codec driver:
>
> codec_cfg =3D pdev->dev.platform_data;
> if (codec_cfg !=3D NULL) {
>  ...
> }
> else
> ret =3D -ENODEV;
>
> I don't see any code to set up dev.platform_data. As a result,=0D
> codec_cfg is always NULL and OMAP ALSA should not work at all.
>  =0D
It should be pretty easy to add the support also for other omap boards if=
 you just know the correct MCBSP settings. I have not access to h3 or h4=
 boards so I have not been able to test them. Do you have access to that=
 data?

I have however send once the patches adding a similar kind of support for=
 the Innovator and 770 boards that are using aic23 chipset.
Innovator patches has been tested to work by James Selvam.

According to one message in maemo developer list, somebody build & tested=
 also the 770 patch and was able to hear some kind of noice but not correct=
 sound.
(mcbsp settings were probably incorrect for that board). It seems that n770=
 uses anyway some other driver for the sounds by default, so I have not=
 investigated this further.

> I might miss something here. Please comment.
>
> Other than that, it seems to have the following limitations by looking=0D
> at the code statically.
> - omap-alsa.c knows the codec connectivity detail (hard-coded to=0D
> MCBSP1). This file should be independent of board specifics.
>  =0D
Maybe that info could also be set-up either during the kernel configuration=
 phase or in board-file.
> - Dead lock as s->dma_lock is double locked in multiple locations.
>  =0D
Hmm, I have not noticed any dead locks. With my h6300 I need however stop=
 sound dma in every round in audio_process_dma() function.
(and according to innovator tests by James Selvam, other omap1510 devices=
 needs to do also the same)

> - Don't support duplex as codec lock is shut off when either input=0D
> stream or output stream is closed.
>  =0D
Do you have any patches for these? If you want I could also try to work=
 with you to fix these issues.
> - Memory strategy is very rudimental: Hard-coded to allocate 128KB=0D
> consistent memory in init time.
>  =0D
Would you like to specify this also in the board file?

Mika


------------------------------

Message: 5
Date: Wed, 9 Aug 2006 18:13:30 -0700 (PDT)
From: Arnold <abo_gwapo@yahoo.com>
Subject: MCSI & MCBSP howto configure as gpio
To: linux-omap-open-source@linux.omap.com
Message-ID: <20060810011330.17839.qmail@web55804.mail.re3.yahoo.com>
Content-Type: text/plain; charset=3Diso-8859-1

Hi All,

Is there anyone who can help me configure MCSI1 or
MCBSP1 to a gpio pin? Is there a spec/howto on how to configure it to a=
 gpio pin? I hope to hear from you guys.

Regards,
OJ

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=
 http://mail.yahoo.com=0D


------------------------------

Message: 6
Date: Thu, 10 Aug 2006 06:41:05 +0200
From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: Pending July patches
To: lamikr@cc.jyu.fi
Cc: linux-omap-open-source@linux.omap.com
Message-ID:
	<fb249edb0608092141g71e176e6qe6cabfc245970f36@mail.gmail.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed

On 08/08/06, andrzej zaborowski <balrog@zabor.org> wrote:
> On 08/08/06, lamikr <lamikr@cc.jyu.fi> wrote:
> > Tony Lindgren wrote:
> > > * lamikr <lamikr@cc.jyu.fi> [060804 17:40]:
> > >> It would be nice if somebody could test the functionality of usbnet=
 and
> > >> mmc/sd with omap1 devices (omap1510)
> > >> before tagging. I got the lcd working by using the fixes now already
> > >> applied to OMAP kernel but both the MMC/SD
> > >> and usbnet failed to work at least for me & h6300.
> > >> (2.6.16 kernel worked ok.)
> > >>
> > >> I can also try to test again these but for me it will go over the
> > weekend...
> > >
> > > No patches so I tagged it already :)
> > Well, I suppose2.6.17-omap2 tag means that it works with omap2 devices=
 :-)
> >
> > I tried that with my h6340 that but unfortunately I could not find fix
> > for the usbnet and MMC/SD card problems.
> > So it probably means that they are failing also for other OMAP1=
 devices?
> >
> > I tested usbnet both with the DMA enabled and disabled in omap_udc.c
> > (#define USE_DMA / #undef USE_DMA) and with both of the options
> > the usb link was not created to my desktop.
> > I also tried to mount both the "Kingston Elite Pro 512 MB" SD card and
> > San Disk 256 MB RC-MMC MMC cards without success.
> >
> > With 2.6.16 kernel, both the SD, MMC cards were working as well as the
> > usbnet.
> > Any idea, which would be the best place to add debug in in the MMC/SD
> > card subsystem to get more info?
>
> Try enabling CONFIG_MMC_DEBUG in the config, it should give at least
> some basic info, e.g. what commands are sent to the card and what
> error they give (timeouts, crc..).
>
> Personally I didn't have problems with MMC/SD support on OMAP1 with
> current git, except the 2GB and 4GB cards (but we have a workaround
> for those). Instead I see strange things happen with the LCD -- It
> takes about 1 second to initialise (in 2.6.16 you couldn't notice

Oops, actually it was in the MMC/SD driver. Because the lines
        if (!irqs_disabled())
                return -EAGAIN;
in mmc_omap_suspend were removed, LCD & backlight are now suspended
before MMC and resumed first which results in a weird visual effect
while cards are detected but no slowdown as far as I can tell.

A more serious issue I found in this version on my board (OMAP311) is
that Linux gets really confused if a card is inserted or ejected while
suspended. For example the sequence: suspend the system, eject the
card, resume, suspend again -- results in a lockup in 100% cases while
it worked in 2.6.16. I *think* it's not only me and I *think* it's not
even OMAP specific but can't test it. The lock-up is in
mmc_deselect_cards(), the MMC layer thinks a card is selected (even
though no card is inserted).

> this) and for some reason I had to change the .pixclock field from
> 12500 to 29000. The weird part is that it's not anything in the LCD

I haven't figured out why I had to change the pixclock (debugging is
difficult because 1 in 5 tries it works with the old value so you're
never sure).

> driver because I reverted this driver alone to 2.6.16 and nothing
> changed. I will be investigating this.
>
> >
> > Mika
> >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
> Greetings,
> Andrew
> --
> balrog 2oo6
>

It seems a number of things were fixed which weren't broken :P
--=0D
balrog 2oo6


------------------------------

Message: 7
Date: Wed, 9 Aug 2006 23:51:47 -0500
From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: MCSI & MCBSP howto configure as gpio
To: "Arnold" <abo_gwapo@yahoo.com>,
	<linux-omap-open-source@linux.omap.com>
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBEEC6821@DLEE09.ent.ti.com>
Content-Type: text/plain;	charset=3D"us-ascii"

If you have access to TRM of OMAP you are working on, then see the
relevant chapter for pin mux, it should tell you the mode to configure
(inorder to configure a McBSP1 pin as GPIO).

As a hack you can directly write this value to the mux register, but the
correct way would be to add an entry in arch/arm/mach-omap2/mux.c and
use the "omap_cfg_reg" API to configure the same.

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Arnold
Sent: Wednesday, August 09, 2006 8:14 PM
To: linux-omap-open-source@linux.omap.com
Subject: MCSI & MCBSP howto configure as gpio

Hi All,

Is there anyone who can help me configure MCSI1 or
MCBSP1 to a gpio pin? Is there a spec/howto on how to
configure it to a gpio pin? I hope to hear from you
guys.

Regards,
OJ

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=0D
http://mail.yahoo.com=0D
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


------------------------------

Message: 8
Date: Thu, 10 Aug 2006 06:55:26 +0200
From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: Suspending with keypad bug (RFC)
To: " Juha Yrj?l? " <juha.yrjola@solidboot.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
Message-ID:
	<fb249edb0608092155r20c17f5dl6397c3d9d191105b@mail.gmail.com>
Content-Type: text/plain; charset=3D"utf-8"

On 06/08/06, Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@solidboot.com> wrote:
> andrzej zaborowski wrote:
>
> > I came up with a different fix, in the keypad driver but it's a bit
> > more intrusive. With this the device sleeps peacefully until another
> > key-press is detected. What should be the correct behavior?
> > I'm attaching both changes.
>
> This approach is better; the generic PM code should not have to care
> that much about different wakeup sources.
>
> I'm not exactly sure in which state the system is when the suspend
> function is called.  Can there still be timer activity, for example?

I think yes, some suspend functions may rely on timers because they
are not obliged to return immdiately.

> Nevertheless, you're safer doing a spin_lock_irqsave() in the suspend
> function first, and releasing the lock only after setting the suspended
> variable and re-enabling the interrupt.
>
> You should also check whether you're actually running on OMAP1 before
> you write to the register.
>
> In the IRQ handler, you should also do a spin_lock_irqsave() before
> accessing the suspended variable.

Thanks for help! I'm attaching the corrected version, it works nicely.

In the irq handler I release the lock just after accessing the
"suspended" variable because as I understand an irq handler will never
be interrupted by something that calls the suspend function.

>
> Cheers,
> Juha
>


--=0D
balrog 2oo6
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-keypad-suspend2.patch
Type: application/octet-stream
Size: 2111 bytes
Desc: not available
Url :=
 http://linux.omap.com/pipermail/linux-omap-open-source/attachments/2006081=
0/57bac840/linux-keypad-suspend2.obj

------------------------------

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


End of Linux-omap-open-source Digest, Vol 28, Issue 14
******************************************************

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Tech Mahindra, formerly Mahindra-British Telecom.
=0D
Disclaimer:

This message and the information contained herein is proprietary and=
 confidential and subject to the Tech Mahindra policy statement, you may=
 review at <a href=
=3D"http://www.techmahindra.com/Disclaimer.html">http://www.techmahindra.co=
m/Disclaimer.html</a> externally and <a href=
=3D"http://tim.techmahindra.com/Disclaimer.html">http://tim.techmahindra.co=
m/Disclaimer.html</a> internally within Tech Mahindra.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
