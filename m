From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap dss tft display connection
Date: Thu, 24 Feb 2011 13:33:28 +0200
Message-ID: <1298547208.16119.73.camel@deskari>
References: <AANLkTinPiAg8zVkW6Z0UsvDO57UwFSyVEbbjkwj4=EXh@mail.gmail.com>
	 <1298543951.16119.63.camel@deskari>
	 <AANLkTikn6YiQoJir_=1qWPv62wSZCic=9aCQyLeV=k0k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab1BXLdc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 06:33:32 -0500
In-Reply-To: <AANLkTikn6YiQoJir_=1qWPv62wSZCic=9aCQyLeV=k0k@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-02-24 at 04:56 -0600, Belisko Marek wrote:
> Hi Toomi,
> 
> On Thu, Feb 24, 2011 at 11:39 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Thu, 2011-02-24 at 04:05 -0600, Belisko Marek wrote:
> >> Hello,
> >>
> >> would be possible to configure dss on omap3530 which is connected to
> >> 18bit TFT display in such way:
> >>        8           8            8
> >> | | | | | | | |-| | | | | | | |-| | | | | | | |
> >>     6         6         6
> >> | | | | | |-| | | | | |-| | | | | |
> >>
> >> So no standard connection (2 bits in every color are skipped) but it's
> >> shifted so last 6 bits remain unused.
> >> When use generic panel it seems I have no red color (just combination
> >> of blue and green).
> >>
> >> It is anyway possible to drive such a connection? Or HW needs to ne changed?
> >
> > Can you explain a bit more what you are trying to do? At least I didn't
> > quite understand =).
> Sorry maybe my question wasn't clear ;). I have mini8100 board
> connected to 18bit
> hitachi TX18D35 connected in way I described in first email (LCD
> datalines connected to
> lower 18 bits dss data lines).
> 
> So my question was what to change (only .phy.dpi.data_lines = 18 is enought?)
> to keep driving my display correctly ;)
> 
> I try that option but no visible change.

Yes, changing the data_lines should be enough. Are you sure you changed
the correct board file? =)

The highest bits are used for the red color, so if you get no red, it
sounds to me like OMAP is trying to use 24bit output.

Another thing that comes to my mind is pin-muxing. The DSS  pins have to
be muxed in mode0. But most likely they already are, if you get an image
on the LCD.

 Tomi


