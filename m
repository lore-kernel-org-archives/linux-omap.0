From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/3] ARM: omap: fix 4.7 gpmc networking regression
Date: Wed, 3 Aug 2016 10:46:24 +0300
Message-ID: <9cf04231-091c-4ac3-bfb8-8d8be3d591eb@ti.com>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
 <20160802103505.GD28140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160802103505.GD28140@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/08/16 13:35, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [160724 05:11]:
>> Networking is currently broken for Overo boards due to a regression in
>> 4.7. I bisected it down to
>>
>> 	d2d00862dfbb ("memory: omap-gpmc: Support general purpose input
>> 	for WAITPINs")
> ...
> 
>> Note that simply fixing the Overo NAND issue would fix the Overo
>> networking regression, but by restoring the 4.6 gpmc-probe behaviour
>> similar regressions on other OMAP systems are also avoided.
> 
> Roger, got a better fix in mind?
> 

Nope. I'll take patch 1 in my omap-gpmc queue for v4.8.
Thanks for the fixes Johan.

cheers,
-roger
