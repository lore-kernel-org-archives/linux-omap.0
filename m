From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/7] arm/dts: OMAP3: Add mpu and iva nodes
Date: Mon, 5 Sep 2011 19:23:50 +0200
Message-ID: <201109051923.51084.arnd@arndb.de>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com> <1377915.IaVE5xAurc@wuerfel> <4E64E527.4040409@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51842 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab1IERXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 13:23:54 -0400
In-Reply-To: <4E64E527.4040409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Monday 05 September 2011, Cousson, Benoit wrote:
> Yeah, I saw that in the "cpus" node documentation. My point here is that 
> I do need to represent the MPU subsystem that will contain the cpus. And 
> thus the Cortex is inside the MPU subsystem.
> 
> I can potentially keep the CPUs inside the cpus node, and just represent 
> the mpu node inside the soc, with potentially some phandle to the real 
> cpu nodes.
> 
> Something like that:
> 
> cpus {
>         cpu0: cpu@0 {
>                         compatible = "arm,cortex-a8";
>         };
> };
> 
> [...]
> 
> soc {
>         compatible = "ti,omap-infra";
>         mpu {
>                 compatible = "ti,omap3-mpu";
>                 hwmods = "mpu";
>                 cpu@0 {
>                         phandle = <&cpu0>;
>                         [...]
>                 };
>         };
> };

Yes, that looks good. I wouldn't name the attribute "phandle" if I could
think of anything better (which I can't at the moment).

	Arnd
