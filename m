From: Detlef Vollmann <dv@vollmann.ch>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Sat, 16 Apr 2011 13:27:51 +0200
Message-ID: <4DA97D37.30607@vollmann.ch>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA85B49.60209@vollmann.ch> <4DA86CA8.7090104@atmel.com>
	<4DA88AFB.7020806@vollmann.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DA88AFB.7020806@vollmann.ch>
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

On 04/15/11 20:14, Detlef Vollmann wrote:
> On 04/15/11 18:04, Nicolas Ferre wrote:

>> In fact on at91sam9g20 (and some other at91) you can use the mirroring
>> of the SRAM until next bank... so you end up with a single pool.
>>
>> Base @ sram1 base - sram0 size
>> size = sram 0 size + sram 1 size
> Can you provide details?
> I couldn't find anything in the documentation about this.
Ok, I checked this.  It seems to be an undocumented feature and
its always mirrored.

   Detlef
