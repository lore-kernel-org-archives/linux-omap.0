From: Christ van Willegen <cvwillegen@gmail.com>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 09:57:51 +0100
Message-ID: <CA+Ot1OwXSyncvVz-S__7buQMJ_2nHaapQ4rroqVgMKyWU7nZiA@mail.gmail.com>
References: <cover.1482936802.git.hns@goldelico.com> <20170220010714.GB8358@dtor-ws>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali>
 <A41872A2-F095-47F8-B122-FFAE430B0D7F@goldelico.com> <20170221084724.GB9795@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170221084724.GB9795@pali>
Sender: linux-input-owner@vger.kernel.org
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Michel Verlaan <michel.verl@gmail.com>, Nick Dyer <nick@shmanahar.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@nokia.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Hans Verkuil <hans.verkuil@cisco.com>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eric Engestrom <eric@engestrom.ch>Hans
List-Id: linux-omap@vger.kernel.org

Hi all,

On Tue, Feb 21, 2017 at 9:47 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> But it really make sense to set input_abs_set_res() from DT.

And _not_ add the 1 or two lines of code that checks some DT variable,
and then fixes _everybody's_ userland?

That means those lines of code need to go into _every_ userland, which
makes maintenance sooo much harder. And the kernel knows about this
and doesn't care??

Weird...

Christ van Willegen
