From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys: Support for one-directional interrupts
Date: Sat, 9 Jan 2010 09:56:28 -0800
Message-ID: <6cb013311001090956s21849453x57e629ab75bd6919@mail.gmail.com>
References: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com>
	<87fx7kgz7f.fsf@tac.ki.iif.hu> <6cb013310912090815u396fd84chfab3c7bf4d5f4bc9@mail.gmail.com>
	<20091209175831.GD4456@core.coreip.homeip.net> <6cb013310912091403i3cb527caqa687487966bb232d@mail.gmail.com>
	<6cb013310912102003le5d960dy9f2c6fc2f3e3dcd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <6cb013310912102003le5d960dy9f2c6fc2f3e3dcd1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 10, 2009 at 8:03 PM, Cory Maccarrone <darkstar6262@gmail.co=
m> wrote:
> I've just submitted a patch to linux-omap for this against the
> gpio/irq handling code. It implements the ICR flip in there
> automatically whenever both RISING and FALLING edge are requested of
> one of these gpios. =C2=A0With it, the patch I've submitted here is m=
oot.
> We'll see if it gets accepted.
>

OK, looks like the patch will get approved, so I'm dropping this patch.=
  Thanks!

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
