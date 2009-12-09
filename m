From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys: Support for one-directional interrupts
Date: Wed, 9 Dec 2009 14:03:42 -0800
Message-ID: <6cb013310912091403i3cb527caqa687487966bb232d@mail.gmail.com>
References: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com>
	<87fx7kgz7f.fsf@tac.ki.iif.hu> <6cb013310912090815u396fd84chfab3c7bf4d5f4bc9@mail.gmail.com>
	<20091209175831.GD4456@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20091209175831.GD4456@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 9, 2009 at 9:58 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Dec 09, 2009 at 08:15:26AM -0800, Cory Maccarrone wrote:
>> On Wed, Dec 9, 2009 at 3:32 AM, Ferenc Wagner <wferi@niif.hu> wrote:
>>
>> I'm fairly certain it wouldn't. =C2=A0Each of the interrupts on my h=
ardware
>> has a corresponding bit in a control register that determines if it'=
s
>> rising or falling-edge triggered -- thus the need for my patch. =C2=A0=
To
>> capture both directions, it's necessary to modify the control regist=
er
>> when a falling edge is detected, so that the corresponding rising ed=
ge
>> can be collected afterward.
>
> This kind of ugliness should be hidden in irqchip driver. See
> mfd/asic3.c for an example.
>

I would agree with that -- it should be possible to hide that away as
part of the functionality of the interrupt driver.  Perhaps a fix to
the OMAP1 IRQ handling is warranted.  I know there are some interrupts
that can do both directions out of the box, but that shouldn't be the
responsibility of each driver to know.

>> May I ask why you're thinking of
>> converting to level-triggering?
>>
>> Perhaps it would be better to provide an option in the platform_devi=
ce
>> structure to set edge- or level-triggering, similar to the change I'=
m
>> proposing for interrupts that can only signal one way at a time.
>>
>
> Yes, we need a way fro platform code to specify desired interrupt fla=
gs
> but I don't believe we should be reconfiguring them on the fly.
>

If the ability to handle this type of interrupt transparently was
added to our board IRQ chip driver, this whole thing would be a
non-issue, as gpio-keys could request edge triggered falling and
rising at the same time, and the driver would Just Work.

I'll take a look and see how possible that would be to do.  Looking
through the code for OMAP1's GPIO IRQ handlers, there's a note that
OMAP1 only supports edge triggering, so if gpio-keys were to move
exclusively to that, itwould stop working with those boards.  But, it
may be possible to do the trigger flip in the chip driver, which would
make this patch unnecessary.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
