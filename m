From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 3/7] AM3517: rename the i2c boardinfo to make it more
 readable
Date: Tue, 20 Apr 2010 12:40:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E13781E@dbde02.ent.ti.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
 <1271745212-4474-4-git-send-email-stanley.miao@windriver.com>
 <20100420063036.GB5427@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43069 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab0DTHK6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 03:10:58 -0400
In-Reply-To: <20100420063036.GB5427@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "ext Stanley.Miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>


> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Tuesday, April 20, 2010 12:01 PM
> To: ext Stanley.Miao
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Hiremath, Vaibhav;
> Govindarajan, Sriramakrishnan; Aggarwal, Anuj
> Subject: Re: [PATCH 3/7] AM3517: rename the i2c boardinfo to make it more
> readable
> 
> Hi,
> 
> On Tue, Apr 20, 2010 at 08:33:28AM +0200, ext Stanley.Miao wrote:
> >@@ -311,8 +311,8 @@ static void __init am3517_evm_init(void)
> > 	/* RTC - S35390A */
> > 	am3517_evm_rtc_init();
> >
> >-	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
> >-				ARRAY_SIZE(am3517evm_i2c_boardinfo));
> >+	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
> >+				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
> 
> I'm curious why isn't this together with the other busses ??
> 
[Hiremath, Vaibhav] Filipe,

This is because we need to assign IRQ number of GPIO 55 for RTC.

Thanks,
Vaibhav

> --
> balbi
