From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/8] ARM: OMAP2+: hwmod: Remove remaining DMA channel
 definitions
Date: Sun, 16 Jun 2013 18:35:13 +0300
Message-ID: <51BDDB31.2000200@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com> <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com> <20130615150650.GB27629@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33813 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab3FPPfb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jun 2013 11:35:31 -0400
In-Reply-To: <20130615150650.GB27629@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi Felipe

On 06/15/2013 06:06 PM, Felipe Balbi wrote:
> On Sat, Jun 15, 2013 at 11:31:04AM +0300, Jarkko Nikula wrote:
>> Last remaining DMA channel definitions in arch/arm/mach-omap2/dma.h
>> are used only by omap_hwmod_2xxx_3xxx_ipblock_data.c and
>> omap_hwmod_3xxx_data.c. Remove them by using directly DMA channel number in
>> hwmod data and drop definitions with a following script:
>>
>> egrep '#define [OMAP|AM35XX].*DMA' arch/arm/mach-omap2/dma.h | cut -f 1,3 \
>> 	| while read i; do \
>> 		DEF=`echo $i |cut -d ' ' -f 2`; \
>> 		CH=`echo $i |cut -d ' ' -f 3`; \
>> 		echo "removing" $DEF; \
>> 		sed -i "s/${DEF}/${CH}/" arch/arm/mach-omap2/omap_hwmod_*.c; \
>> 		sed -i "/${DEF}/d" arch/arm/mach-omap2/dma.h; \
>> 	done
>>
>>  /* DMA channels for 24xx */
> 
> could remove the comments too.
> 
You are right. Actually I was thinking that myself too with this and
omap1 patches but decided to keep manual work and scripts bare minimum
and let final git rm in 4/8 and 8/8 to handle these :-)

-- 
Jarkko
