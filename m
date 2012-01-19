From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Thu, 19 Jan 2012 17:29:33 +0000
Message-ID: <20120119172933.GI3178@opensource.wolfsonmicro.com>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com>
 <201201181711.15751.arnd@arndb.de>
 <331ABD5ECB02734CA317220B2BBEABC13177DFF6@DBDE01.ent.ti.com>
 <201201191710.45862.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201201191710.45862.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, Jonathan Cameron <jic23@cam.ac.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 19, 2012 at 05:10:45PM +0000, Arnd Bergmann wrote:

> Having custom user interfaces inside an input driver however is very
> bad. I'm sure that other accelerometers will have the same requirements
> regarding polling frequency and enable/disable in android as well as
> anytwhere else and it should absolutely not be handled by a user space
> HAL but instead inside of the kernel, using a common method for all
> available drivers.

The polling frequency thing isn't even accelerometer specific, there's a
general need for this on a wide range of other things like touchscreens
(where controlling the sample rate is interesting for power, there are
widely varying requirements depending on what the screen is doing).
