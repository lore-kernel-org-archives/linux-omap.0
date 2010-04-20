From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/7] AM3517: rename the i2c boardinfo to make it more
 readable
Date: Tue, 20 Apr 2010 09:30:36 +0300
Message-ID: <20100420063036.GB5427@nokia.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
 <1271745212-4474-4-git-send-email-stanley.miao@windriver.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42667 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab0DTGbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 02:31:17 -0400
Content-Disposition: inline
In-Reply-To: <1271745212-4474-4-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Stanley.Miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "hvaibhav@ti.com" <hvaibhav@ti.com>, "srk@ti.com" <srk@ti.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>

Hi,

On Tue, Apr 20, 2010 at 08:33:28AM +0200, ext Stanley.Miao wrote:
>@@ -311,8 +311,8 @@ static void __init am3517_evm_init(void)
> 	/* RTC - S35390A */
> 	am3517_evm_rtc_init();
>
>-	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
>-				ARRAY_SIZE(am3517evm_i2c_boardinfo));
>+	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
>+				ARRAY_SIZE(am3517evm_i2c1_boardinfo));

I'm curious why isn't this together with the other busses ??

-- 
balbi
