From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
Date: Mon, 24 Aug 2009 11:39:57 +0530
Message-ID: <002c01ca2481$82c30340$LocalHost@wipultra793>
References: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com> <FCCFB4CDC6E5564B9182F639FC35608702F996E313@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C290@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37059 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbZHXGKI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Aug 2009 02:10:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
>> ---
>> #define L3_IO_OFFSET 0x90000000
>> #define __L3_IO_ADDRESS(pa) ((pa) + L3_IO_OFFSET)/* Works for L3 */
>> #define __OMAP2_L3_IO_ADDRESS(pa) ((pa) + L3_IO_OFFSET)/* Works for L3
>> */
>> #define l3_io_v2p(va) ((va) - L3_IO_OFFSET)/* Works for L3 */
>>
>> #define IO_OFFSET 0xb2000000
>> #define __IO_ADDRESS(pa) ((pa) + IO_OFFSET)/* Works for L4  */
>> #define __OMAP2_IO_ADDRESS(pa) ((pa) + IO_OFFSET)/* Works for L4 */
>> #define io_v2p(va) ((va) - IO_OFFSET)/* Works for L4*/
>> ---
>>
>> This way you don't have to introduce new L4 macro at all => much lesser
>> code impact.
> Initially I thought about this but later preferred to split it. The only 
> change what you are suggesting is instead of calling 
> "OMAP2_L4_IO_ADDRESS", we keep >that as "OMAP2_IO_ADDRESS". But the idea 
> was to differentiate between various IO accesses because at some point of 
> time all these has to be removed in
> favor of ioremap() + read*()/write*() one by one and that time this would 
> be beneficial.

Does that mean all drivers, including the ones in other trees like camera, 
dss etc need to be modified if they are using IO_ADDRESS macros. The idea of 
having a macro as below was to reduce this impact.

#define __IO_ADDRESS(pa) ((pa) >= L3_34XX_PHYS ?   ((pa) + L3_IO_OFFSET) : 
((pa) + IO_OFFSET))

