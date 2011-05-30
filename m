From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [RFC][PATCH 2/9] OMAP4: HWMOD: make current hwmods common for
 4460 and 4430
Date: Mon, 30 May 2011 06:50:07 -0500
Message-ID: <4DE3846F.6050904@gmail.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-3-git-send-email-nm@ti.com> <4DE35CDD.30709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43306 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711Ab1E3LuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 07:50:12 -0400
Received: by yxs7 with SMTP id 7so1377766yxs.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 04:50:11 -0700 (PDT)
In-Reply-To: <4DE35CDD.30709@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Pantelic <vladoman@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>

On 05/30/2011 04:01 AM, Vladimir Pantelic wrote:
[..]
>> - .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>> + .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
>
> I guess at the time that CHIP_IS_OMAP4430 was introduced it was totally
> unthinkable that another 44xx based chip would ever exist?

I think it was a script that generated the data from internal databases. 
yeah, it is possible that, at that point, not thought out far ahead :(

Regards,
Nishanth Menon
