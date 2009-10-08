From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: X-loader / U-Boot query
Date: Thu, 08 Oct 2009 09:17:05 -0600
Message-ID: <4ACE0271.2060402@mlbassoc.com>
References: <4ACDE1DF.1010303@mlbassoc.com> <4ACDFB52.2080100@astc-design.com> <7A436F7769CA33409C6B44B358BFFF0C012A6FC720@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:58856 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598AbZJHPRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 11:17:42 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012A6FC720@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Adam Machalek <adam.machalek@astc-design.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/08/2009 09:14 AM, Menon, Nishanth wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Adam Machalek
>> Sent: Thursday, October 08, 2009 9:47 AM
>> To: Gary Thomas
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: X-loader / U-Boot query
>>
>> The problem is located in u-boot/cpu/arm_cortexa8/omap3/mem.c
>>
>> Function do_sdrc_init()
>>
>> There is an assumption that the RAM size on each CS is maximum of 128M.
>> See this line:
>>
>> writel(RASWIDTH_13BITS | CASWIDTH_10BITS | ADDRMUXLEGACY |
>>        RAMSIZE_128 | BANKALLOCATION | B32NOT16 | B32NOT16 |
>>        DEEPPD | DDR_SDRAM,&sdrc_base->cs[cs].mcfg);
>>
> This discussion should really be taken to u-boot mailing list. Yes, any additional patches would be good to have..

Where is that list??  I did ask this question in the original
email...

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
