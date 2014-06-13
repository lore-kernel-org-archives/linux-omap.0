From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 15/36] ARM: OMAP2+: gpmc: Allow drivers to query GPMC_CLK
 period
Date: Fri, 13 Jun 2014 10:48:09 +0300
Message-ID: <539AACB9.5080105@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com> <1402477001-31132-16-git-send-email-rogerq@ti.com> <20140613072645.GN17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140613072645.GN17845@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, kyungmin.park@samsung.com, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/13/2014 10:26 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [140611 01:59]:
>> GPMC_CLK is the external clock output pin that is used for syncronous
>> accesses.
>>
>> Device drivers need to know the fastest possible GPMC_CLK period in order
>> to calculate the most optimal device timings. Add the function
>> omap_gpmc_get_clk_period() to allow drivers to get the nearset possible
>> (equal to or greater than) GPMC_CLK period given the minimum
>> clock period supported by the attached device.
>>
>> This is especially needed by the onenand driver as it calculates
>> device timings on the fly for various onenand speed grades.
> 
> Here too this should probably still be done by the gpmc to driver
> glue layer, not by the actual driver that shoud be Linux generic.

Well, this is only needed by the omap-onenand driver to perform the timing calculations at run-time.
Other option is to model the GPMC_CLK (external) as a clock and request the rate using the clock framework.
But since this and the retime() is only used by 2 OMAP specific drivers, I'm not sure if it is worth the effort.

cheers,
-roger
