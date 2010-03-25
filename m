From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Thu, 25 Mar 2010 14:58:01 +0100
Message-ID: <201003251458.02980.jkrzyszt@tis.icnet.pl>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com> <201003242221.24551.jkrzyszt@tis.icnet.pl> <201003241429.21578.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49311 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab0CYN56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 09:57:58 -0400
In-Reply-To: <201003241429.21578.dmitry.torokhov@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Wednesday 24 March 2010 22:29:21 Dmitry Torokhov napisa=C5=82(a):
> On Wednesday 24 March 2010 02:21:22 pm Janusz Krzysztofik wrote:
> > Hi Dmitry,
> >
> > Wednesday 24 March 2010 17:16:04 Dmitry Torokhov wrote:
> > > On Mon, Mar 22, 2010 at 10:07:47PM +0100, Janusz Krzysztofik wrot=
e:
> > > > Meanwhile, I've connected the Amstrad Delta keyboard to a PC. I=
 can
> > > > confirm it speaks PS/2 protocol and is automatically detected b=
y
> > > > atkbd/i8042 drivers. The initial handshake sequence actually lo=
oks
> > > > exactly the same as that of a standard AT keyboard.
> > >
> > > OK, since the device really speaks PS/2 protocol I withdraw my
> > > objection of using serio + atkbd combo, however we should not be =
doing
> > > translation in serio.
> >
> > Sure, thank you.
> >
> > > > The problem persists about different scancodes, giving
> > > > wrong keystrokes.
> > >
> > > This can be dealt with from userspace by loading correct keymap.
> >
> > Sounds acceptable. I hope the machine's built-in matrix keypad won'=
t be
> > affected.
>
> The scan code to key code mapping is per-device so it should not.

Hi,

What utility could you advise for this purpose? input-utils' provided=20
input-kbd? keyfuzz? self compiled keymap.c example from=20
linux/Documentation/input/? Something else?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
