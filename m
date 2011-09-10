From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Sat, 10 Sep 2011 11:21:24 +0530
Message-ID: <4E6AFADC.5080701@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com> <20110909080416.GF31581@S2100-06.ap.freescale.net> <4E69C9CF.6090709@ti.com> <20110909141321.GC32138@S2100-06.ap.freescale.net> <CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com> <20110909152729.GG32138@S2100-06.ap.freescale.net> <4E6A4605.3050305@ti.com> <20110909233448.GH32138@S2100-06.ap.freescale.net> <CAMQu2gwJQi55sY7aUnfcY-r8VGBPzWY2NnYUjJ-SEGiNC3Ty1Q@mail.gmail.com> <20110910045454.GA32640@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:60956 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751190Ab1IJFv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Sep 2011 01:51:56 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so4745932pzk.30
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 22:51:55 -0700 (PDT)
In-Reply-To: <20110910045454.GA32640@S2100-06.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: khilman@ti.com, Dave Martin <dave.martin@linaro.org>, linux@arm.linux.org.uk, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 10 September 2011 10:24 AM, Shawn Guo wrote:
> On Sat, Sep 10, 2011 at 09:08:16AM +0530, Shilimkar, Santosh wrote:
>> IOn Sat, Sep 10, 2011 at 5:04 AM, Shawn Guo<shawn.guo@freescale.com>  wrote:
> [...]
>>> Also, IMO, lable "l2x_clean_inv" should be put after the "bne do_WFI".
>>> Otherwise, my original statement (it seems l2x_clean_inv will be
>>> called for case "2") stands correct :)
>>>
>> It's just a label. All L2 related code and checks for the valid state is
>> kept under that by purpose.
>>
> So for some case, you enter l2x_clean_inv but do not actually clean
> and invalidate L2.  I do not see this label being used anywhere, so
> you may want to remove it to save the confusion to stupid people like
> me.  Just my opinion.
>
Will remove the label :)

Regards
Santosh
