From: Tony Lindgren <tony@atomide.com>
Subject: Re: Board mux entries ignored?
Date: Fri, 6 Aug 2010 12:06:32 +0300
Message-ID: <20100806090631.GD23778@atomide.com>
References: <AANLkTimYgkviKVfXNpQB9vsjSZyMdxuwkrXYQHSb02wY@mail.gmail.com>
 <20100805065423.GU9881@atomide.com>
 <AANLkTinqEesHdt5jzUbJawEp7U6NsFwxe2=hjTg6C53n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60028 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317Ab0HFJGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 05:06:03 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinqEesHdt5jzUbJawEp7U6NsFwxe2=hjTg6C53n@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Faith <jfaith7@gmail.com>
Cc: linux-omap@vger.kernel.org

* John Faith <jfaith7@gmail.com> [100805 19:09]:
> On Wed, Aug 4, 2010 at 11:54 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * John Faith <jfaith7@gmail.com> [100804 22:22]:
> >> Hi,
> >> I'm trying to set mux modes for a 3530, package CBC in my board.c
> >> (2.6.32 kernel) using an omap_board_mux entry:
> >> =C2=A0OMAP3_MUX(GPMC_WAIT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> >>
> >> , but sysfs reports mode4:
> >> # grep WAIT1 /sys/kernel/debug/omap_mux/board
> >> OMAP3_MUX(GPMC_WAIT1, OMAP_PIN_INPUT | OMAP_MUX_MODE4),
> >>
> >> I tried adding to bootargs "omap_mux=3Dgpmc_wait1.gpmc_wait1=3D0x1=
00", but
> >> still got MODE4. =C2=A0Doing "echo 0x100 >
> >> /sys/kernel/debug/omap_mux/gpmc_wait1" gave me MODE0, but I'd pref=
er
> >> to init pins in board.c. =C2=A0I've also noticed for pin SDMMC2_DA=
T3 that
> >> my OMAP3_MUX() entry specifies MODE1, but sysfs shows MODE4; it
> >> changed to MODE1 after adding:
> >> =C2=A0omap_mux_init_signal("mcspi3_cs0", OMAP_PIN_OUTPUT);
> >>
> >> Is just having the mode in omap_board_mux entries sufficient?
> >
> > Hmm that should be enough. Does dmesg | grep -i mux show any errors=
?
> >
> > You do have CONFIG_OMAP_MUX set, right? Otherwise omap_mux_init_sig=
nals
> > does not do anything, and the mux code just builds a list of GPIO
> > pins for PM runtime muxing (not implemented yet).
>=20
> Hi,
> Yes, CONFIG_OMAP_MUX is set.  The only non-wait1 error I saw was:
> mux: Multiple signal paths (3) for mcspi3_cs0
>=20
> With CONFIG_OMAP_MUX_DEBUG I now see that after mode0 is set, later
> it's set to mode4:
> # dmesg | grep -i wait1
> mux: Setting signal gpmc_wait1.gpmc_wait1 0x0100 -> 0x0100
> mux: Setting signal gpmc_wait1.gpio63 0x0100 -> 0x0104
>=20
> The same pin was enabled for a different config, fixed with an ifdef.

OK, good to hear.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
