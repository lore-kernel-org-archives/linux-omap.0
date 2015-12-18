From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v5 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Fri, 18 Dec 2015 11:20:44 +0530
Message-ID: <56739EB4.6040804@ti.com>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-5-git-send-email-vigneshr@ti.com>
 <20151211150935.GA15654@rob-hp-laptop> <20151217184557.GC23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151217184557.GC23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, "hramrach@gmail.com" <hramrach@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 12/18/2015 12:15 AM, Tony Lindgren wrote:
> * Rob Herring <robh@kernel.org> [151211 07:10]:
>> On Fri, Dec 11, 2015 at 09:39:59AM +0530, Vignesh R wrote:
>>> Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
>>> update the binding documents for the controller to document this change.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Vignes, are patches 4 and 5 safe to apply separately already or
> do things break if we do that?

Yes, 4 and 5 can be applied separately w/o driver changes.

-- 
Regards
Vignesh
