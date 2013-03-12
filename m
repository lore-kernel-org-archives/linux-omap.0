From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] usb: phy: nop: Add some parameters to platform data
Date: Tue, 12 Mar 2013 16:12:45 +0200
Message-ID: <513F37DD.9030301@ti.com>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com>
 <1363087466-32444-2-git-send-email-rogerq@ti.com>
 <513F177D.40500@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <513F177D.40500-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/12/2013 01:54 PM, Marc Kleine-Budde wrote:
> On 03/12/2013 12:24 PM, Roger Quadros wrote:
>> Add clk_rate parameter to platform data. If supplied, the
>> NOP phy driver will program the clock to that rate during probe.
>>
>> Also add 2 flags, needs_vcc and needs_reset.
>> If the flag is set and the regulator couldn't be found
>> then the driver will bail out with -EPROBE_DEFER.
> 
> Is there a platform which fills out pdata.needs_vcc and
> pdata.needs_reset? IMHO it makes no sense to add features for the non DT
> case, if there isn't any user for it.
>

There can be a user in the non DT case as well. Consider the following example:
The power regulator that supplies VCC to the PHY device sits over the I2C bus.
The NOP transceiver driver is built into the kernel but the regulator driver
is built as a module.

During boot, the NOP transceiver driver's probe is called before the regulator can
be probed. So regulator_get() will fail and if the platform doesn't set the
needs_vcc flag, the driver will continue as normal and the PHY device won't work.

I know that beagleboard can benefit from this. The current workaround is to
register the regulator before we register the PHY in the board file. With the
needs_vcc flag, we don't need to have that limitation.

cheers,
-roger
