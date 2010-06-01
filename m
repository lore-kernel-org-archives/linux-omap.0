From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2] misc : ROHM BH1780GLI Ambient light sensor Driver
Date: Tue, 1 Jun 2010 13:12:44 -0700
Message-ID: <20100601131244.7164b43c.akpm@linux-foundation.org>
References: <39216.10.24.255.17.1274699065.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39216.10.24.255.17.1274699065.squirrel@dbdmail.itg.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Jonathan Cameron <jic23@cam.ac.uk>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-omap@vger.kernel.org


I re-added your reviewers to the cc...

On Mon, 24 May 2010 16:34:25 +0530 (IST)
"Hemanth V" <hemanthv@ti.com> wrote:

> This patch adds support for ROHM BH1780GLI Ambient light sensor.
> 
> BH1780 supports I2C interface. Driver supports read/update of power state and
> read of lux value (through SYSFS). Writing value 3 to power_state enables the
> sensor and current lux value could be read.

There are at least two other ambient light sensor drivers:
drivers/misc/isl29003.c and drivers/misc/tsl2550.c.

Is there any standardisation of the ABIs whcih these drivers offer?  If
so, does this new driver comply with that?

It would be most useful if the changelog were to fully describe the
proposed kernel<->userspace interface.  That's the most important part
of the driver, because it's the only part we can never change.

There is a desultory effort to maintain sysfs API descriptions under
Documentation/ABI/.  I'd have thought that it would be appropriate to
document this driver's ABI in there.
