From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: [Linux-fbdev-devel] Getting DSS2 to mainline
Date: Mon, 17 Aug 2009 15:54:46 +0200
Message-ID: <10f740e80908170654l78b01136v209287ac9b4d12f7@mail.gmail.com>
References: <4A893DF4.3050705@nokia.com> <4A894A4D.4000501@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:35575 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbZHQNyo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 09:54:44 -0400
Received: by pzk34 with SMTP id 34so1931005pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 06:54:46 -0700 (PDT)
In-Reply-To: <4A894A4D.4000501@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Aug 17, 2009 at 14:17, Florian Tobias
Schandinat<FlorianSchandinat@gmx.de> wrote:
> Tomi Valkeinen schrieb:
>> As I'm new to sending patches upstream, I'm not sure how to go forward
>> with DSS2 now. Should I send it to linux-arm-kernel mailing list, or
>> directly to main linux kernel mailing list? Or is there a route through
>> fbdev-devel list for DSS2 to go forward?
>
> I am also new to this process but from what I've heard I decided to
> always cc Andrew Morton <akpm@linux-foundation.org> when I think that
> something is mature enough for inclusion. That works very well, thanks
> Andrew.
> Sending them only to linux-fbdev-devel looks rather like a dead end at
> least if I look on the fate of some patches in the archive.
> I always cc the LKML but until now I didn't hear anything from there
> either so I doubt that would be the right way.
>
> I'm sorry if anything of the above is incorrect, it's just my experience.

Yes, CCing Andrew Morton is The Right Thing To Do.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
