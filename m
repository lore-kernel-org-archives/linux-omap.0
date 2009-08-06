From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCH 07/20] OMAP: McBSP: Add transmit/receive threshold
	handler
Date: Thu, 6 Aug 2009 14:20:24 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760047F6AED00@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>,<20090806121039.GL2358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31737 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbZHFMWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 08:22:49 -0400
In-Reply-To: <20090806121039.GL2358@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, eduardo.valentin@nokia.com
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, jhnikula@gmail.com, peter.ujfalusi@nokia.com


>>
>> +/********************** McBSP IRQSTATUS bit definitions ********************/
>> +#define IRQST_XRDY           (1<<10)
>> +#define IRQST_RRDY           (1<<3)
>> +
>>  /********************** McBSP WAKEUPEN bit definitions *********************/
>>  #define XEMPTYEOFEN          0x4000
>>  #define XRDYEN                       0x0400
>
> Please add spaces around << defines above.
> 
> Regards,
> 
> Tony

No spaces are used in this file at such declarations:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/plat-omap/include/mach/mcbsp.h;h=bb154ea76769509a7937c4ba472e8d04c5bf41d3;hb=HEAD

to follow the file format exactly, it'd need to be in form of 0x ?

- Eero