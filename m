From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 08/17] soc: ti: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
Date: Mon, 26 Nov 2018 10:09:17 +0200
Message-ID: <5BFBAA2D.8020601@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-9-git-send-email-rogerq@ti.com>
 <20181123163742.GC53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123163742.GC53235@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 23/11/18 18:37, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [181122 11:39]:
>> The PRUSS INTC module is reference counted during the interrupt
>> setup phase through the irqchip's irq_request_resources() and
>> irq_release_resources() ops. This restricts the module from being
>> removed as long as there are active interrupt users.
> 
> So are there any reasons why this could not be just a regular
> drivers/irqchip driver nowadays?

This is a regular irqchip driver. Do you mean it should be moved
to drivers/irqchip directory?

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
