From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: isp1301 build breakage
Date: Wed, 12 Mar 2008 08:51:27 -0500
Message-ID: <c26351182b4c193bc22c498485b5550f@felipebalbi.com>
References: <20080312120023.GR7524@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42555 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYCLNv2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 09:51:28 -0400
In-Reply-To: <20080312120023.GR7524@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org



On Wed, 12 Mar 2008 14:00:24 +0200, Tony Lindgren <tony@atomide.com> wrote:
> * David Brownell <david-b@pacbell.net> [080312 13:28]:
>>   CC      drivers/i2c/chips/isp1301_omap.o
>> drivers/i2c/chips/isp1301_omap.c: In function 'isp1301_set_peripheral':
>> drivers/i2c/chips/isp1301_omap.c:1360: error: implicit declaration of
> function 'machine_is_omap_h2'
>> drivers/i2c/chips/isp1301_omap.c:1360: error: implicit declaration of
> function 'machine_is_omap_h3'
>> make[3]: *** [drivers/i2c/chips/isp1301_omap.o] Error 1
>> make[2]: *** [drivers/i2c/chips] Error 2
>> make[1]: *** [drivers/i2c] Error 2
>>
>> This is on an H4 config, if that matters at all.
> 
> I've pushed a quick fix to include mach-types.h.. In the long run that
> should use platform_data for passing any special options..

I've being working on that, sorry the delay but I'm quite busy with omap3
and twl. :-s

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

