From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 09:07:48 -0600
Message-ID: <4F674BC4.2070802@wwwdotorg.org>
References: <4F22DEF2.5000807@ti.com> <20120317104751.4F00E3E0910@localhost> <20120319130222.GC5705@sirena.org.uk> <201203191501.10232.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51953 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab2CSPHx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 11:07:53 -0400
In-Reply-To: <201203191501.10232.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, rob.herring@calxeda.com, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org

On 03/19/2012 09:01 AM, Arnd Bergmann wrote:
> On Monday 19 March 2012, Mark Brown wrote:
>> On Sat, Mar 17, 2012 at 10:47:51AM +0000, Grant Likely wrote:
>>
>>> After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
>>> I definitely prefer the fixed property name plus a separate names property.
>>> It is easier to use common code with that scheme, and easier to statically
>>> check for correctness.
>>
>> It's not a fantastic experience when using the bindings as the arrays
>> grow large, though - keeping things matched up isn't much fun especially
>> if any of the elements in the array are optional.
> 
> Maybe one can use named properties in a new device node in that case,
> like this:
> 
> 	bus {
> 		dma: dma-controller {
> 			#dma-cells = <1>;
> 		};
> 
> 		device {
> 			compatible = "device";
> 			channel: dma-channel {
> 				type = <0x1>;
> 				name = "foo";
> 				number = <23>;
> 				direction = <3>;
> 			};
> 			dma-requests = <&dma &channel>;
> 		};
> 	};

For reference, this is very similar to how the pinctrl bindings work,
except that they require the "channel" node to be a child of the DMA
controller, and hence "dma-requests" doesn't contain <&dma &channel>,
just <&channel>, since "dma" is the parent (or grand-parent) of "channel".
