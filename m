From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 11/11] AM3517: Add mmc platform data for am3517evm
Date: Wed, 14 Apr 2010 10:36:03 +0800
Message-ID: <4BC52A13.1000802@windriver.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com> <1271151270-13038-3-git-send-email-stanley.miao@windriver.com> <19F8576C6E063C45BE387C64729E7394044E0541FE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51174 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab0DNC1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 22:27:32 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E0541FE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

Hiremath, Vaibhav wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Stanley.Miao
>> Sent: Tuesday, April 13, 2010 3:05 PM
>> To: linux-omap@vger.kernel.org
>> Cc: tony@atomide.com; Chikkature Rajashekar, Madhusudhan
>> Subject: [PATCH 11/11] AM3517: Add mmc platform data for am3517evm
>>
>> Add mmc platform data. Besides, the mmc slot on UI board has a pin conflict
>> with LCD, so add macros to resolve it.
>>
>>     
> [Hiremath, Vaibhav] I am not sure whether your statement is right here. As far I know he conflicts is between UI card USB and Base-board LCD panel.
>
> There is no conflict between MMC2 (which is on UI card) with LCD interface. I may be wrong here, can you please point me to the docs/schematics where you got this info.
>   

Both MMC2_WP and LCD_PANEL_PWR_MFP connected to the pin uP_SPI1_SCSn2.
You can found it in schematics.

Stanley.


