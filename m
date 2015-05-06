From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
Date: Wed, 6 May 2015 07:42:39 -0700
Message-ID: <20150506144239.GH21061@atomide.com>
References: <1430769717-4088-1-git-send-email-tony@atomide.com>
 <20150505145407.GK18002@pali>
 <20150505150638.GC21061@atomide.com>
 <201505051839.36882@pali>
 <20150505170020.GF21061@atomide.com>
 <20150506085204.GE30910@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49496 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbbEFOmm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 10:42:42 -0400
Content-Disposition: inline
In-Reply-To: <20150506085204.GE30910@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150506 01:53]:
> On Tuesday 05 May 2015 10:00:21 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150505 09:41]:
> > > On Tuesday 05 May 2015 17:06:38 Tony Lindgren wrote:
> > > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150505 07:55]:
> > > > > On Tuesday 05 May 2015 07:43:08 Tony Lindgren wrote:
> > > > > > * Arnd Bergmann <arnd@arndb.de> [150505 03:56]:
> > > > > > > On Monday 04 May 2015 13:01:54 Tony Lindgren wrote:
> > > > > > > > For dropping the remaining omap3 legacy boot support,
> > > > > > > > we still have the following board-*.c files:
> > > > > > > >=20
> > > > > > > > BOARD                   REASON NEEDED
> > > > > > > > board-ldp.c             Still used in RMKs boot test
> > > > > > > > system board-omap3logic.c      Getting a .dts file
> > > > > > > > for v4.2 board-omap3pandora.c    Got a .dts file for
> > > > > > > > v4.1 board-rx51-*.c          Needs /proc/atags
> > > > > > > > support for user space
> > > > > > > >=20
> > > > > > > > I'm hoping we can drop those for v4.3 merge window,
> > > > > > > > then keep the platform data around for one more merge
> > > > > > > > window in case of reverting needed, then drop the
> > > > > > > > platform data too for v4.4 if no issues needing
> > > > > > > > reverting are found.
> > > > > > >=20
> > > > > > > Sounds great. Has there been a conclusion about what to
> > > > > > > do for the rx51 /proc/atags support?
> > > > > >=20
> > > > > > I believe we just need to enable /proc/atags also for
> > > > > > device tree based booting if CONFIG_ARM_ATAG_DTB_COMPAT.
> > > > > > Pali may have more info on that.
> > > > > >=20
> > > > > > Then looks like Pali's two patches for showing the
> > > > > > revision are still pending in thread "[PATCH v2 0/2] ARM:
> > > > > > /proc/cpuinfo: DT: Add support for Revision":
> > > > > >=20
> > > > > > http://www.spinics.net/lists/arm-kernel/msg401535.html
> > > > >=20
> > > > > I think I already sent all need patches to ML. But I did not
> > > > > check if you merged them or not. I did not get any new
> > > > > comments for them for a while and right now I do not have
> > > > > time for looking at it again.
> > > >=20
> > > > Oh OK, do you have link to the /proc/atags patch somewhere?
> > > >=20
> > > > Maybe Arnd and Nico can pick them up and sort out how we
> > > > should queue them with Russell?
> > > >=20
> > >=20
> > > https://lkml.org/lkml/2015/1/26/648
> >=20
> > Hmm looks like you should resend all your pending four patches
> > properly with the people mentioned above in Cc to the LAKML
> > and linux-omap.. Assuming something will happen to them when
> > the patches are buried into a middle of some old threads does
> > not work well.. Best to just follow das protokoll und whine and
> > follow up until the patches get merged :)
> >=20
> > Regards,
> >=20
> > Tony
>=20
> Now I resent "ARM: /proc/cpuinfo: DT: Add support for Revision" patch=
es
> to MLs again without in-reply-to header.

OK thanks.
=20
> Patches for /proc/atags I do not have currently in git format-patch m=
box
> format, so cannot resent it right now...

Well presumably you'll resend those once you find them then :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
