From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Sun, 14 Jul 2013 23:55:42 -0700
Message-ID: <20130715065542.GK7656@atomide.com>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
 <20130706131057.GU21614@n2100.arm.linux.org.uk>
 <20130706133627.GV21614@n2100.arm.linux.org.uk>
 <CAOesGMjv=GxWSxaUebY6pP4sJHfQNeuUk2BcAFBT3QxX3jGZLw@mail.gmail.com>
 <CAOesGMgO74FU0P4DC6_yws8ZaQ6F923-LWwGAxbCQkQbr69L5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14450 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 02:55:48 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMgO74FU0P4DC6_yws8ZaQ6F923-LWwGAxbCQkQbr69L5w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

* Olof Johansson <olof@lixom.net> [130712 20:16]:
> On Fri, Jul 12, 2013 at 7:31 PM, Olof Johansson <olof@lixom.net> wrote:
> 
> > This is pretty painful, and I don't know if we want to rethink Arnd's
> > patch since it will break existing defconfigs out there that rely on
> > OMAP2PLUS enabling the socs instead of the other way around. Opinions?
> 
> (replying to myself, I know, I know...)
> 
> I think it's probably easiest to just select the OMAP{2,3,4} and
> AM33XX options in multi_v7_defconfig just like Arnd did in the commit
> that changed the dependencies for now. I've added a patch on top of
> our current fixes branch to do so.

Well should select only omap 3 and later for multi_v7_defconfig as
omap2 is v6 :)
 
> Note that you need to make corresponding changes to your seeds for
> your build tests, Russell.

Eventually we could have them all selected based on the core type,
but I'd rather not do that until clocks and hwmod data come from DT.

Regards,

Tony
