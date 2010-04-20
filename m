From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 3/7] AM3517: rename the i2c boardinfo to make it more
 readable
Date: Tue, 20 Apr 2010 15:14:46 +0800
Message-ID: <4BCD5466.8000007@windriver.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com> <1271745212-4474-4-git-send-email-stanley.miao@windriver.com> <20100420063036.GB5427@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64528 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0DTHGB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 03:06:01 -0400
In-Reply-To: <20100420063036.GB5427@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "hvaibhav@ti.com" <hvaibhav@ti.com>, "srk@ti.com" <srk@ti.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>

Felipe Balbi wrote:
> Hi,
>
> On Tue, Apr 20, 2010 at 08:33:28AM +0200, ext Stanley.Miao wrote:
>> @@ -311,8 +311,8 @@ static void __init am3517_evm_init(void)
>> /* RTC - S35390A */
>> am3517_evm_rtc_init();
>>
>> - i2c_register_board_info(1, am3517evm_i2c_boardinfo,
>> - ARRAY_SIZE(am3517evm_i2c_boardinfo));
>> + i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
>> + ARRAY_SIZE(am3517evm_i2c1_boardinfo));
>
> I'm curious why isn't this together with the other busses ??
>
rtc s35390a is on i2c1 bus. am3517_evm_rtc_init() will initialize the 
IRQ(a gpio pin).
So i2c_register_board_info have to be put after am3517_evm_rtc_init.

Stanley.

