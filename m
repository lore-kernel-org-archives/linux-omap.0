From: Detlef Vollmann <dv@vollmann.ch>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 20:14:19 +0200
Message-ID: <4DA88AFB.7020806@vollmann.ch>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA85B49.60209@vollmann.ch> <4DA86CA8.7090104@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DA86CA8.7090104@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/15/11 18:04, Nicolas Ferre wrote:
> Le 15/04/2011 16:50, Detlef Vollmann :
>> On 04/15/11 15:06, Russell King - ARM Linux wrote:
>>> This is work in progress.
>> Thanks, very useful.
>
> [..]
>
>>> Another question is whether we should allow multiple SRAM pools or not -
>>> this code does allow multiple pools, but so far we only have one pool
>>> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
>>> it if they want to partition the SRAM, or have peripheral-local SRAMs.
>> Having the option to partition the SRAM is probably useful.
>> What I'm missing is sram_pool_add: on AT91SAM9G20 you have two banks
>> of SRAM, and you might want to combine them into a single pool.
>
> In fact on at91sam9g20 (and some other at91) you can use the mirroring
> of the SRAM until next bank... so you end up with a single pool.
>
> Base @ sram1 base - sram0 size
> size = sram 0 size + sram 1 size
Can you provide details?
I couldn't find anything in the documentation about this.

   Detlef
