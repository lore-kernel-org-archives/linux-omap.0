From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] media: i2c: lm3560: use conservative defaults
Date: Sat, 11 Aug 2018 12:44:02 +0300
Message-ID: <CAHp75Vf4PZW8A+uj8V5uL2LkTSzSogQDcR8JTqVh4jzVecgtRQ@mail.gmail.com>
References: <20180506080250.GA24114@amd> <20180716090814.GA4505@amd> <3a9ece34-baad-a19d-c3bd-96aa458ea70b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a9ece34-baad-a19d-c3bd-96aa458ea70b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Jeong <gshark.jeong@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, Sakari Ailus <sakari.ailus@iki.fi>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 11, 2018 at 9:10 AM, Daniel Jeong <gshark.jeong@gmail.com> wrote:
> Hi Pavel,
>
> I think if there is not exist pdata, it should be set to the value of power
> on reset (POR) to sync with the chip.
>
> According to the LM3560 datasheet, Flash Timeout is 512ms, Flash current is
> 875mA and Torch Current is 93.75mA.

Can't we simple read back?

-- 
With Best Regards,
Andy Shevchenko
