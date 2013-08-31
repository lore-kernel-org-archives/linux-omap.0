From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] arm: dts: am33xx: correcting dt node unit address
 for usb
Date: Sat, 31 Aug 2013 13:09:04 +0530
Message-ID: <52219D98.1010602@ti.com>
References: <1377885140-3529-1-git-send-email-mugunthanvnm@ti.com> <50F5779C-87B6-43C2-81A8-C72A0614464F@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50F5779C-87B6-43C2-81A8-C72A0614464F-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday 31 August 2013 12:40 AM, Kumar Gala wrote:
> On Aug 30, 2013, at 12:52 PM, Mugunthan V N wrote:
>
>> > DT node's unit address should be its own register offset address to make it a
>> > unique across the system. This patch corrects the incorrect USB entries with
>> > correct register offset for unit address.
>> > 
>> > Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>> > Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> > Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
>> > ---
>> > arch/arm/boot/dts/am33xx.dtsi | 4 ++--
>> > 1 file changed, 2 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> > index f9c5da9..e9b6775 100644
>> > --- a/arch/arm/boot/dts/am33xx.dtsi
>> > +++ b/arch/arm/boot/dts/am33xx.dtsi
>> > @@ -346,7 +346,7 @@
>> > 			ti,hwmods = "usb_otg_hs";
>> > 			status = "disabled";
>> > 
>> > -			ctrl_mod: control@44e10000 {
>> > +			ctrl_mod: control@44e10620 {
>> > 				compatible = "ti,am335x-usb-ctrl-module";
>> > 				reg = <0x44e10620 0x10
>> > 					0x44e10648 0x4>;
>> > @@ -449,7 +449,7 @@
>> > 					"tx14", "tx15";
>> > 			};
>> > 
>> > -			cppi41dma: dma-controller@07402000 {
>> > +			cppi41dma: dma-controller@47402000 {
> Why isn't the unit address 47400000 ?
>
The above address is a shared address between CPPI dma and USB sub
system. It has to be shared because CPPI DMA has to access Glue layer of
the USB sub system for accessing IRQ registers.

So 47400000 is already used in USB SS so if it cannot be used for CPPI
DT node.

Regards
Mugunthan V N
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
