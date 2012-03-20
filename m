From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mfd: Add TWL4030 PWM driver
Date: Tue, 20 Mar 2012 22:02:11 +0000
Message-ID: <201203202202.12060.arnd@arndb.de>
References: <1332262083-9375-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332262083-9375-1-git-send-email-walle@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bernhard Walle <walle@corscience.de>
Cc: sameo@linux.intel.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 March 2012, Bernhard Walle wrote:
> 
> This PWM driver uses the PWM of the TWL4030. The driver for the TWL6030
> PWM has been used as mode, but the PWM registers are different.
> 
> The driver can be used and has been tested in conjunction with
> pwm-backlight to control a backlight LED of a LCD touch screen.
> 
> Signed-off-by: Bernhard Walle <walle@corscience.de>

Since it's too late for v3.4 now and we will get a new pwm
subsystem in v3.5, I suggest you change the driver to work
register with that subsystem instead of just using the old
header file. Note that drivers/mfd is not really the right
place anyway, because this is not a multifunction driver but
just one device driver that happens to be a slave of an mfd.

	Arnd
