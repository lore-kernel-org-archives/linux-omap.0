From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Tue, 1 Sep 2009 12:52:16 +0530
Message-ID: <ce9ab5790909010022h10757af5g80bae994f34c1002@mail.gmail.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
	<20090827140617.GA30917@mvista.com> <ce9ab5790909010004y67d3b29nf6ddc4532d390aef@mail.gmail.com>
	<20090901071212.GA4397@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f188.google.com ([209.85.211.188]:40411 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbZIAHWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 03:22:34 -0400
Received: by ywh26 with SMTP id 26so7101591ywh.5
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2009 00:22:36 -0700 (PDT)
In-Reply-To: <20090901071212.GA4397@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Petazzoni <mpetazzoni@mvista.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rix, Tom" <trix@ti.com>

On Tue, Sep 1, 2009 at 12:42 PM, Maxime Petazzoni<mpetazzoni@mvista.com> wrote:
> * vimal singh <vimal.newwork@gmail.com> [2009-09-01 12:34:26]:
>
>> > Yes, I am aware of the mtdparts command line arguments, which works
>> > great. I think a "default", sensible partition layout for the Zoom2
>> > would be nice though.
>>
>> I agree. Keeping it in the mind that mtdparts command line arguments
>> will be given higher precedence anyway...
>
> Exactly. I would recommend that your patch gets merged in. Although I'm
> a bit curious of the rationale behind a 30M kernel partition?
>
> Also, given a 512MB NAND, we could easily affect 256MB or more to the
> system partition (as well as a bit more space for the userdata
> partition).
>
> But that's just nitpicking. As we said, mtdparts can be used to take
> precedence over the default settings if they don't match the
> user/system's needs.

I'll re-submit this patch along with one that I mentioned earlier:
http://marc.info/?l=linux-omap&m=125065707704826&w=2

in a series of patches.

-- 
Regards,
Vimal Singh
