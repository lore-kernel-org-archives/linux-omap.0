From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys: Support for one-directional interrupts
Date: Thu, 10 Dec 2009 20:03:42 -0800
Message-ID: <6cb013310912102003le5d960dy9f2c6fc2f3e3dcd1@mail.gmail.com>
References: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com>
	<87fx7kgz7f.fsf@tac.ki.iif.hu> <6cb013310912090815u396fd84chfab3c7bf4d5f4bc9@mail.gmail.com>
	<20091209175831.GD4456@core.coreip.homeip.net> <6cb013310912091403i3cb527caqa687487966bb232d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <6cb013310912091403i3cb527caqa687487966bb232d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 9, 2009 at 2:03 PM, Cory Maccarrone <darkstar6262@gmail.com=
> wrote:
> I'll take a look and see how possible that would be to do. =C2=A0Look=
ing
> through the code for OMAP1's GPIO IRQ handlers, there's a note that
> OMAP1 only supports edge triggering, so if gpio-keys were to move
> exclusively to that, itwould stop working with those boards. =C2=A0Bu=
t, it
> may be possible to do the trigger flip in the chip driver, which woul=
d
> make this patch unnecessary.

I've just submitted a patch to linux-omap for this against the
gpio/irq handling code. It implements the ICR flip in there
automatically whenever both RISING and FALLING edge are requested of
one of these gpios.  With it, the patch I've submitted here is moot.
We'll see if it gets accepted.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
