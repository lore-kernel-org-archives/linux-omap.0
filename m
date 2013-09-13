From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 15:47:34 +0530
Message-ID: <5232E63E.9020804@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com> <5232DCFE.5050700@ti.com> <5232DD53.3010706@ti.com> <5232DF61.6000109@ti.com> <5232E00E.9040400@ti.com> <5232E2A8.10409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43045 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab3IMKS2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Sep 2013 06:18:28 -0400
In-Reply-To: <5232E2A8.10409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, robdclark@gmail.com, devicetree@vger.kernel.org, Andy Gross <andygro@gmail.com>

On Friday 13 September 2013 03:32 PM, Tomi Valkeinen wrote:
> On 13/09/13 12:51, Archit Taneja wrote:
>
>> The calls in omap_generic_init() check the machine type via
>> of_machine_is_compatible(), even if it's a multiplatform image, the dtb
>> should be only of one platform. So it wouldn't be called at all.
>
> Hmm. BeagleBone is "ti,am33xx". The "Generic AM33XX (Flattened Device
> Tree)" machine definition uses omap_generic_init(). So if I'm not
> missing something here, omap_generic_init() is called for BeagleBone.

I was talking about the calls within omap_generic_init() :

omap_generic_init(void)
{
	...
	if (of_machine_is_compatible("ti,omap4-panda")) {
		omap4_panda_display_init_of();
		legacy_init_ehci_clk("auxclk3_ck");

	}
}

omap4_panda_display_init_of() would be called only if a panda board dtb 
was used. Are you talking about these display calls, or something else?

Archit

