From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH RESEND v6 2/4] TI816X: Update common OMAP machine
 specific sources
Date: Tue, 15 Feb 2011 06:39:27 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036AD56F51@dbde02.ent.ti.com>
References: <1297695819-27027-1-git-send-email-hemantp@ti.com>
 <87tyg6xkm0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34149 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab1BOBJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 20:09:42 -0500
In-Reply-To: <87tyg6xkm0.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hilman, Kevin wrote on Tuesday, February 15, 2011 4:58 AM:

> Hemant Pedanekar <hemantp@ti.com> writes:
> 
> [...]
> 
>> @@ -402,7 +422,7 @@ void __init
> omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
>> 
>>  	omap_hwmod_late_init();
>> 
>> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>> +	if (omap3_has_sdrc()) {
>>  		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>>  		_omap2_init_reprogram_sdrc();
>>  	}
> 
> At first glance, this one doesn't look quite right.  Will
> omap3_has_sdrc()  be true on 24xx?   Please confirm.
> 
> Kevin

You are right, this is incorrect as there is no 'features' set for
omap24xx. I will send new version with cpu_is_omap24xx() check retained.

Thanks.
   Hemant