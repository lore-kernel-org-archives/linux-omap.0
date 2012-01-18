From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Wed, 18 Jan 2012 14:49:35 +0000
Message-ID: <201201181449.35904.arnd@arndb.de>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com> <201201181403.47806.arnd@arndb.de> <20120118154344.4187f461@endymion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120118154344.4187f461@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, greg@kroah.com, eric.piel@tremplin-utc.net, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "Nori, Sekhar" <nsekhar@ti.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 January 2012, Jean Delvare wrote:
> Hi Arnd and all,
> 
> The lis3lv02d driver was moved outside of drivers/hwmon to make it
> clear that we (hwmon/lm-sensors people) are not involved in maintaining
> this driver in any way. So please remove the lm-sensors list (and
> myself) from this discussion.

Ok, I see. What about the applesmc driver then? If we come up with
a solution that works for the other drivers, should the accelerometer
part of that be converted to use that interface?

	Arnd
