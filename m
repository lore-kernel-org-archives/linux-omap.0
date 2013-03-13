From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] usb: phy: nop: Add some parameters to platform data
Date: Wed, 13 Mar 2013 17:46:55 +0200
Message-ID: <51409F6F.6000103@ti.com>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com>
 <1363087466-32444-2-git-send-email-rogerq@ti.com>
 <513F177D.40500@pengutronix.de> <513F37DD.9030301@ti.com>
 <513F38DF.5040404@pengutronix.de> <513F3B7E.8000002@ti.com>
 <513F3EF0.3030609@pengutronix.de> <513F47B4.2060004@ti.com>
 <514098A0.1030809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <514098A0.1030809-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/13/2013 05:17 PM, Peter Ujfalusi wrote:
> On 03/12/2013 04:20 PM, Roger Quadros wrote:
>> Adding Peter to the loop. I faintly remember him mentioning this issue before
>> for beagle. We really need the deferred probe mechanism or we need to resort
>> to device registering order.
> 
> Yes, BeagleBoard is a good example. Long story short: we have external
> dependency and the correct way to handle that is via deferred probe.
> 
> As of now we are not ready to kill the legacy support but over time we should
> move as much as we can to DT only mode.
> 
>> The first user for needs_vcc flag will be the beagleboard file. I just didn't
>> implement it in this patch [1].
>>
>> On second thoughts, since [1] does work on beagleboard without requiring the
>> needs_vcc flag, I think we can just live without it.
> 
> The BeagleBoard works because the bootloader happen to enable the PWM
> generator which is used as a GPIO for the external HUB enable port. As soon as
> the bootloader stops doing this we are going to be in trouble.
> 

Wasn't it the LED A out GPO from PMIC that is used to enable the HUB? Just cross
checking so I haven't missed anything.

I will resend the board support patch for beagle implementing
needs_vcc flag for the deferred probe mechanism. Thanks.

cheers,
-roger
