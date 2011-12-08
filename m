From: Enrico <ebutera@users.berlios.de>
Subject: Re: ASoC broken on 3.2-rc4?
Date: Thu, 8 Dec 2011 20:33:53 +0100
Message-ID: <CA+2YH7v+cAGHFGuL6yY80p8=Tob=J=MkMnt3UUNycPuJ8EWkeA@mail.gmail.com>
References: <CAGDS+nmW+fgo20znqdQch9Uvu7Q9=p1D0AwPqx4vjakXZ6PiAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53124 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1LHTdy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:33:54 -0500
Received: by ghbz2 with SMTP id z2so1840401ghb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 11:33:53 -0800 (PST)
In-Reply-To: <CAGDS+nmW+fgo20znqdQch9Uvu7Q9=p1D0AwPqx4vjakXZ6PiAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Dec 7, 2011 at 9:58 PM, Steve Sakoman <sakoman@gmail.com> wrote=
:
> I just began working with 3.2-rc4 on Overo and Beagleboard xM.
>
> On both machines I see the driver init, but no alsa device created.
> For example on Overo:
>
> Advanced Linux Sound Architecture Driver Version 1.0.24.
> <snip>
> overo SoC init
> ALSA device list:
> =A0No soundcards found.
>
> Has anyone else seen this? =A0Just want to make sure it isn't a known
> issue before digging in and debugging.

Maybe patch at [1] is still not in mainline?

Enrico

[1]: https://lkml.org/lkml/2011/9/5/37
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
