From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (gpio-fan) Add a shutdown handler to poweroff the
 fans
Date: Thu, 4 Dec 2014 11:05:50 -0800
Message-ID: <20141204190550.GB16925@roeck-us.net>
References: <1417712336-31070-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417712336-31070-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 04, 2014 at 10:58:56AM -0600, Nishanth Menon wrote:
> Poweroff the fans when shutting down the system. Else,
> echo '1' > /sys/class/hwmon/hwmon0/fan1_target; poweroff leaves the
> fan running if the System power off does not drive the gpio expander
> which might control the fan power supply.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Applied to hwmon-next.

Thanks,
Guenter
