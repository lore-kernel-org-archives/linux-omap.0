From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [RFT/PATCH 2/6] driver: serial: mpc52xx_uart: Remove	"uart_console"
 defintion
Date: Thu, 18 Apr 2013 16:21:46 +0530
Message-ID: <516FD042.5090303@ti.com>
References: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com> <1366198467-6757-3-git-send-email-sourav.poddar@ti.com> <20130418105003.GB14500@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130418105003.GB14500@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, khilman@linaro.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sylvain Munaut <tnt@246tNt.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Russell,
On Thursday 18 April 2013 04:20 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 17, 2013 at 05:04:23PM +0530, Sourav Poddar wrote:
>> Since "uart_console" definition is now moved to serial core
>> haeder file . Serial drivers need not define them.
> This needs to be part of patch 1.  Having it separate may provoke compiler
> warnings.
Ok. I will fold it in the first patch in my next version.

Thanks,
Sourav
