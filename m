From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: Droid 4: suspend to RAM?
Date: Wed, 25 Jul 2018 22:33:55 +0200
Message-ID: <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
References: <20180725200205.GA29594@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725200205.GA29594@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org

Hi Pavel

On Wed, Jul 25, 2018 at 10:02 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I have two big problems with droid 4. #1 is that it lost 2 SMS.. and I
> have no idea why. Second is power consumption -- it seems to be rather

Depend how do you set the SMS buffering using CNMI if I remember. Modem
has 1024bytes of memory most of the time that can buffer more then 1 sms.
Modem rise a irq when they receive a call or sms, or you an use the serial but
omap family can loose the first char coming from the serial so you can lost the
sms because parsing fail

> high even before modem (and thus USB) is enabled.
>
> Interestingly, CyanogenMod and Jolla seem to have higher power
> consumption than stock operating system.
>
> (My Linux can survive for 10 hours, stock system could survive for 4
> days if I'm not mistaken).
>
> I thought I would experiment with suspend to RAM.. and it indeed
> seemed to suspend ok, but I could not wake it up. Do I need to set up
> wakeup with button somehow? Is suspend to RAM required for good power
> consumption?

Sorry but pm subsystem has debug mode that you can test in a easy way.
You can even wakeup by any rtc alarm easily.

Michael

>
> Best regards,                                                           Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
