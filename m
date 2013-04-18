From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [RFT/PATCH 2/6] driver: serial: mpc52xx_uart: Remove "uart_console"
 defintion
Date: Thu, 18 Apr 2013 10:47:20 +0530
Message-ID: <516F81E0.9030803@ti.com>
References: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com> <1366198467-6757-3-git-send-email-sourav.poddar@ti.com> <20130418035610.GA18349@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130418035610.GA18349@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sylvain Munaut <tnt@246tNt.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 18 April 2013 09:26 AM, Felipe Balbi wrote:
> On Wed, Apr 17, 2013 at 05:04:23PM +0530, Sourav Poddar wrote:
>> Since "uart_console" definition is now moved to serial core
>> haeder file . Serial drivers need not define them.
>>
>> Cc: Sylvain Munaut<tnt@246tNt.com>
>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Felipe Balbi<balbi@ti.com>
>> Cc: Rajendra nayak<rnayak@ti.com>
>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
> looks like it should be merged with previous patch to avoid redefinition
> errors.
>
true..i can squash it with the previous patch.
