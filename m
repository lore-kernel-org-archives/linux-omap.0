From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH 1/7] ARM: OMAP: Add basic board support for OMAP LDP.
Date: Fri, 02 May 2008 07:13:27 -0500
Message-ID: <2c282eb76e9a019f5e7d849aedba0ec4@felipebalbi.com>
References: <6E3DC4E6E09EF440B55B7AD683608D6D03A4495D@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36836 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760854AbYEBMNa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 08:13:30 -0400
In-Reply-To: <6E3DC4E6E09EF440B55B7AD683608D6D03A4495D@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: linux-omap@vger.kernel.org



On Fri, 2 May 2008 06:44:16 -0500, "Kamat, Nishant" <nskamat@ti.com> wrote:
> Filipe,
> 
>> -----Original Message-----
>> From: Felipe Balbi [mailto:me@felipebalbi.com]
>>
> [. . .]
> 
>> > +	ads7846_dev_init();
>> > +	omap_serial_init();
>> > +	hsmmc_init();
>>
>> no usb?
>> How about usb_musb() here?
>>
>> Could you try that ?
>>
>> you'll need to include <asm/arch/usb-musb.h>
>>
>> if it works, just append to this patch ;-)
> 
> Last time I tried, it didn't work straight off the bat. I'll send it in
> another patch once it works..

Ok then,

Send me the erroenous output if you wish. I could try to help
you digging the problem.


-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

