From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] omap: beagle: add support for wl1271 on the board file
Date: Thu, 23 Sep 2010 08:42:46 -0500
Message-ID: <AANLkTi=1QqxE3P_+5goP43YNvcaQLjQUk5XWo-Oq51iW@mail.gmail.com>
References: <1285230003-5065-1-git-send-email-luciano.coelho@nokia.com>
	<AANLkTinLjQbvbTj3LTnw+54S-ojWzojqgyd=-3F783We@mail.gmail.com>
	<AANLkTimce-=MP2DDNTpRh_oRFW15_gSkKZJ6fQzwc4yJ@mail.gmail.com>
	<1285246353.3231.84.camel@chilepepper>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285246353.3231.84.camel@chilepepper>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 23, 2010 at 7:52 AM, Luciano Coelho
<luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, 2010-09-23 at 14:03 +0200, ext Robert Nelson wrote:
>> On Thu, Sep 23, 2010 at 5:30 AM, Grazvydas Ignotas <notasas-Re5JQEeQqe8@public.gmane.org=
m> wrote:
>> > On Thu, Sep 23, 2010 at 11:20 AM, Luciano Coelho
>> > <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>> >> Add board configuration for the wl1271 daughter board. =A0This pa=
tch is based
>> >> on Ohad Ben-Cohen's patches for Zoom boards.
>> >
>> > Hm can that daughter board be detected? With your patch all beagle
>> > users will get GPIO139 toggled, and if someone has that wired to
>> > chainsaw switch somebody might get hurt.
>>
>> Expansion boards really need to follow:
>>
>> http://elinux.org/BeagleBoardPinMux#Expansion_boards
>>
>> Is there any eeprom on i2c bus #2 for identification on this board?
>
> Hmmm... <checking the schematics>
>
> Yes, it does. :) This makes perfect sense.
>
> My bootloader (U-Boot 2010.03) doesn't seem to detect it, though:
>
> <clip>
> Probing for expansion boards, if none are connected you'll see a
> harmless I2C error.
>
> No EEPROM on expansion board
> <clip>

I'd first add the board to the list on the wiki to protect the
expansion board id.

Here's the current patch for u-boot for these expansion boards, it
only implements id's for the boards listed at the time.

http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Du-boot.git;a=3Dcommit;h=3D=
95993d1fee62ef64b2f58c1e186176ca9033c35e

> Do I need a special bootloader?
>
> Is there any standard way to recognize the expansion board and config=
ure
> it properly?

Yeap, you need a special bootloader, which is a downside to the
current implementation...  It relies on u-boot to do the i2c probing
and detect which expansion board is connected, it would be nice if the
kernel could do it on it's own..

So currently u-boot probes, then notifies the kernel thru a "buddy"
variable that gets passed with the bootargs..

board-omap3beagle.c then parse's the "buddy" variable to setup the
expansion device, like as shown for the zippy1/2 expansion boards:

http://cgit.openembedded.org/cgit.cgi/openembedded/tree/recipes/linux/l=
inux-omap-psp-2.6.32/0007-ARM-OMAP-beagleboard-Add-infrastructure-to-do=
-fixups.patch

(note there are patches applied before this and after, so it's won't
apply cleanly to mainline)

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
