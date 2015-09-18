From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Fri, 18 Sep 2015 17:40:30 +0530
Message-ID: <55FBFF36.8050905@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <20150914183744.GF12027@sirena.org.uk> <55F93F89.7060708@ti.com>
 <20150916105647.GK11268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150916105647.GK11268@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 09/16/2015 04:26 PM, Mark Brown wrote:
> On Wed, Sep 16, 2015 at 03:38:09PM +0530, Vignesh R wrote:
> 
>> But, I didn't get how to integrate with existing message queue. Memory
>> mapped read by-passes message queue of SPI core. Could you please
>> explain a bit more on integrating with message queue? Did you mean
>> locking the existing message queue when memory mapped read is being
>> requested?
> 
> Yes, and also making sure that we don't everything gets processed in
> order so memory mapped requests come after any commands needed to set
> them up and don't starve other work.
> 

Ok, thanks for the clarification!

-- 
Regards
Vignesh
