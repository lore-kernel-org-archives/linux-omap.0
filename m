From: Nishanth Menon <nm@ti.com>
Subject: Re: AM335x board with disabled RTC crashes
Date: Wed, 20 Nov 2013 23:30:06 -0600
Message-ID: <20131121053006.GA19129@kahuna>
References: <528CC4CB.4000609@gmail.com>
 <528CC5C3.2010905@ti.com>
 <528CDAF6.7070905@ti.com>
 <528D8C08.1020201@gmail.com>
 <528D8CF0.1050406@roese.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38107 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab3KUFa3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 00:30:29 -0500
Content-Disposition: inline
In-Reply-To: <528D8CF0.1050406@roese.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <mail@roese.nl>
Cc: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>, Suman Anna <s-anna@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 05:32-20131121, Stefan Roese wrote:
> On 11/21/2013 05:28 AM, Stefan Roese wrote:
> >>>> Disabling the RTC in the DT doesn't help (of course). So what's the
> >>>> recommended way to disable this hwmod access to the RTC registers?
> >>>
> >>>
> >>> http://www.spinics.net/lists/linux-omap/msg98207.html
> >>> might help you - we had thought it might get queued for 3.12, but it
> >>> was queued for 3.13 instead..
> > 
> > Unfortunately this patch doesn't fix the crash for me (yet). With this
> > patch applied and the RTC DT node completely removed from am33xx.dtsi it
> > works. But only disabling it (via status = "disabled" in the board dts
> > file) doesn't work.
> > 
> > I'll dig a bit deeper today...
> 
> This (hacky) patch works, but I'm not sure if this is acceptable upstream:
> 
> am335x-board_foo.dts:
> 
> ...
> 
> &rtc {
> 	reg = <0x0 0x0>;
> };
> 
You should be able to achieve the same effect as following (example from
BBB) - though I dont see this defined in
Documentation/devicetree/bindings/arm/omap/omap.txt

I will allow the wisdom of others to comment better here :)
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 6b71ad9..a734ef4 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -66,6 +66,11 @@
 	status = "okay";
 };
 
+&am335xrtc {
+	status = "disabled";
+	ti,hwmods="disabled";
+};
+
 / {
 	hdmi {
 		compatible = "ti,tilcdc,slave";
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6d8ffe..71bf2ec 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -373,7 +373,7 @@
 			ti,timer-pwm;
 		};
 
-		rtc@44e3e000 {
+		am335xrtc: rtc@44e3e000 {
 			compatible = "ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <75
-- 
Regards,
Nishanth Menon
