From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dt-bindings: mfd: Improve readability for TPS65217
 interrupt sources
Date: Wed, 23 Nov 2016 12:51:27 +0100
Message-ID: <33562327.jVWx4tN2gP@wuerfel>
References: <20161121131515.8040-1-woogyom.kim@gmail.com>
 <20161122155759.GG10134@dell.home>
 <bd4944d8-3cef-b3f7-4fba-6de590493047@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <bd4944d8-3cef-b3f7-4fba-6de590493047@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>, linux-kernel@vger.kernel.org, bcousson@baylibre.com, Milo Kim <woogyom.kim@gmail.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday, November 23, 2016 8:38:00 PM CET Milo Kim wrote:
> On 11/23/2016 12:57 AM, Lee Jones wrote:
> >>      pwrbutton {
> >> > -          interrupts = <TPS65217_IRQ_PB>;
> >> > +          interrupts = <TPS65217_IRQ_PUSHBUTTON>;
> > Push button or power button?
> >
> 
> According to the datasheet, push button interrupt is correct.
> 
>         http://www.ti.com/lit/ds/symlink/tps65217.pdf
> 
> This is used for a power button input in Beaglebone boards. In other 
> words, the power button is one of push button usages.
> 
> So, I'd like to keep general name for the interrupt.

Ah, the numbers come from the data sheet. Please just remove the
header then, there is no need to keep them as an ABI, in particular
when the driver doesn't even include that header today.

I see you even have names for them in the node:

        charger {
-               interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
+               interrupts = <TPS65217_IRQ_AC_POWER>, <TPS65217_IRQ_USB_POWER>;
                interrupts-names = "AC", "USB";
                status = "okay";

What matters here is the binding documentation in
Documentation/devicetree/bindings/power/supply/tps65217_charger.txt

Please fix that instead to mandate that the two interrupts are
required, what their functions are, and what the interrupt-names
(not interrupts-names) property must list.

	Arnd
