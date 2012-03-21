From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] mfd: Add TWL4030 PWM driver
Date: Wed, 21 Mar 2012 18:55:18 +0200
Message-ID: <CANOLnOOJst6-3n5fOaKRST=MYEqVxsyX0TKX0qH=4HJ15DtywA@mail.gmail.com>
References: <1332262083-9375-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332262083-9375-1-git-send-email-walle@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bernhard Walle <walle@corscience.de>
Cc: sameo@linux.intel.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 20, 2012 at 6:48 PM, Bernhard Walle <walle@corscience.de> w=
rote:
> This PWM driver uses the PWM of the TWL4030. The driver for the TWL60=
30
> PWM has been used as mode, but the PWM registers are different.
>
> The driver can be used and has been tested in conjunction with
> pwm-backlight to control a backlight LED of a LCD touch screen.

Nice, could we also have LEDA and LEDB pwm control as pwm_id 2 and 3
in next version? No worries if you don't want it, I could try to take
a stab at that later.



--=20
Gra=C5=BEvydas
