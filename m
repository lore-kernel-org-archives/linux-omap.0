From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 2/4] TI816X: clock: Add clock data
Date: Mon, 8 Aug 2011 21:18:45 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABB09340@dbde02.ent.ti.com>
References: <1301070006-8363-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1107160201410.25013@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab1HHPtH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 11:49:07 -0400
In-Reply-To: <alpine.DEB.2.00.1107160201410.25013@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Hi Paul,

Paul Walmsley wrote on Saturday, July 16, 2011 1:36 PM:

> Spot-checking this...
> 
> On Fri, 25 Mar 2011, Hemant Pedanekar wrote:
> 
>> +static struct clk uart1_fck = {
>> +	.name		= "uart1_fck",
>> +	.parent		= &sysclk10_ck,
>> +	.ops		= &clkops_omap2_dflt,
>> +	.enable_reg	= TI816X_CM_ALWON_UART_0_CLKCTRL,
>> +	.enable_bit	= TI816X_MODULEMODE_SWCTRL,
>> +	.clkdm_name	= "alwon_l3_slow_clkdm",
>> +	.recalc		= &followparent_recalc,
>> +};
> 
> Is this really in the alwon_l3_slow_clkdm clockdomain?
> Looking at SPRS680
> section 5.2 "L4 Interconnect", these UARTs seem to be in some L4
> clockdomain? 
> 
> 
> - Paul

Yes UARTs are on L4 slow but the clock domain is labelled as 
ALWON_L3_SLOW. Please refer 18.3.2 of SPRUGX8 (TRM from http://focus.ti.com/docs/prod/folders/print/tms320dm8168.html).

Thanks.
   Hemant