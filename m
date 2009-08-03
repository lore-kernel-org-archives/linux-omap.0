From: John Sarman <johnsarman@gmail.com>
Subject: Fwd: MMC3 Overo
Date: Mon, 3 Aug 2009 06:57:48 -0400
Message-ID: <bb2708720908030357n246555a2u8f0ef0ced1ed3716@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <bb2708720907301223h616eb215gb4aea1df8e1d578e@mail.gmail.com>
	 <alpine.DEB.2.00.0908021919320.19529@utopia.booyaka.com>
	 <bb2708720908030333x1c9521b6ua76122b0f80e1fdc@mail.gmail.com>
	 <52AC0DF6-BA95-421B-8C56-5F3DC62279DF@mac.com>
	 <bb2708720908030356p6d7b1cdegf0bd8c39a5c4ecd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f213.google.com ([209.85.217.213]:36026 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbZHCK5r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 06:57:47 -0400
Received: by gxk9 with SMTP id 9so5694129gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2009 03:57:48 -0700 (PDT)
In-Reply-To: <bb2708720908030356p6d7b1cdegf0bd8c39a5c4ecd9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On Mon, Aug 3, 2009 at 6:37 AM, Elvis Dowson<elvis.dowson@mac.com> wrot=
e:
> Hi John,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 What does MMC3 on the Overo connect t=
o?
MMC3 connects to one of the 70 pin bottom connectors. =A0The datasheet
states that MMC3 has no PBIAS circuit so you have to interface it with
1.8V logic. =A0I used a TXS0108 from TI as a level translator.
Datasheet states "The TXS0108E device is a semi-buffered
auto-direction-sensing voltage translator design is optimized for
translation applications (e.g. MMC Card Interfaces) that require the
system to start out in a low-speed open-drain mode and then switch to
a higher speed push-pull mode." So no need for transceiver control
with this IC.

>
> I am trying to get pm working on the overo, and I have a recipe for t=
he
> overo for v.2.6.29 (which still has some issues with mmc1) and I have
> v2.6.31 latest kernel update recipe for overo that has both DSS2 and =
PM
> integrated.

Have you tested the USB host with 2.6.31 recipe yet?
Definitely would like the recipe for the v2.6.31. I have tested DSS2
on 2.6.30-rc8 and either I have a user error(most likely) or it wasn't
working.
I attempted to backport PM but as my main concern was for MMC. I
stopped after realizing it wasn't absolutely necessary to get the new
mmc patches to compile.

>
> I can share it with you if you like.
>
> Best regards,
>
> Elvis
>
>

John Sarman
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
