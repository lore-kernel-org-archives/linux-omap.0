From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Wed, 18 Jan 2012 17:11:15 +0000
Message-ID: <201201181711.15751.arnd@arndb.de>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com> <201201181403.47806.arnd@arndb.de> <b659db7b-2ef1-49b8-9752-a0601226cc6e@email.android.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <b659db7b-2ef1-49b8-9752-a0601226cc6e@email.android.com>
Sender: linux-input-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>, linux-input@vger.kernel.org
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "greg@kroah.com" <greg@kroah.com>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 January 2012, Jonathan Cameron wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> >Any opinions where they should live? input, iio or a new subsystem?
> >
> Personal thought is that straight 3d devices very directed at input
> should go there. Iio has a few wrinkles left for the in kernel
> interfaces needed for a bridge to input. For starters the pull 
> and push data interfaces have not merged yet (in staging) and we
> have not started on in kernel acess to non data events yet(thresholds).
> Still happy to take them when we can support usecases fully. 

Ok, thanks for the information, sounds all reasonable. I think we
can definitely say no to new accelerometer drivers in drivers/misc
then and refer them to iio and input.

In case of lis33ldlh, I would like to see it move out at some point
once the necessary parts of iio have graduated out of staging.
Hopefully it won't be a large amount of work to convert it to
a different internal API.

AnilKumar, what are the existing users of the driver? Is it still
possible to convert them to use iio without causing problems for
people that rely on this driver, or do we have to keep supporting the
current interface?

	Arnd
