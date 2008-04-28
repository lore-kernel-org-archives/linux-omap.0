From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [RFC/PATCH] BQ27000/BQ27200 battery monitoring driver for OMAP34xx
Date: Mon, 28 Apr 2008 06:47:09 -0500
Message-ID: <c8e665543c8e8ca9a6717408897e69ac@felipebalbi.com>
References: <004201c8a6b7$283188a0$018918ac@ent.ti.com> <8ce339cf29cd530453f35b8fe91240a8@felipebalbi.com> <003501c8a924$db298fb0$018918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56370 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763049AbYD1LrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 07:47:11 -0400
In-Reply-To: <003501c8a924$db298fb0$018918ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org



On Mon, 28 Apr 2008 17:11:51 +0530, "Madhusudhan Chikkature Rajashekar"
<madhu.cr@ti.com> wrote:
> Hi Felipe,
> 
> Thanks for the comments. I will fix them and resend the patch.
> 
> Please note my view on the below point.
> 
>> > -	pdev = platform_device_alloc("omap-bq2700-battery", id);
>> > +	pdev = platform_device_alloc("bq27000-bat", id);
>>
>> do you really need to change the name here?
>> It seems that this change doesn't belong to this patch.
> 
> I will make this as a separate patch.As BQ27000 chip is not omap
specific,
> I guess the above name is not correct. Hence I intend to make that
change.

Ok, works for me :-)

I guess bq2700-battery is ok, just remove omap- from the previous name??


-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

