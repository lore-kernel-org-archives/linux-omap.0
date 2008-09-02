From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2: Add support for the Gumstix Overo board
Date: Tue, 2 Sep 2008 09:04:42 -0700
Message-ID: <5e088bd90809020904w55ef1222g7acd452591c499c3@mail.gmail.com>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	 <1220306279-27977-2-git-send-email-sakoman@gmail.com>
	 <200809020815.58792.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:5362 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYIBQEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 12:04:44 -0400
Received: by gv-out-0910.google.com with SMTP id e6so61943gvc.37
        for <linux-omap@vger.kernel.org>; Tue, 02 Sep 2008 09:04:42 -0700 (PDT)
In-Reply-To: <200809020815.58792.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 2, 2008 at 8:15 AM, David Brownell <david-b@pacbell.net> wrote:
> On Monday 01 September 2008, sakoman@gmail.com wrote:
>> +               .name           = "jffs2",
>
> Suggest "rootfs" instead ... have you looked at UBI/UBIFS instead?
> I plan to use it on my Beagle...
>
>
>> +               gpio_direction_output(W2W_NRESET, 0);
>> +               udelay(10);
>> +               gpio_direction_output(W2W_NRESET, 1);
>
> These should be gpio_set_value(...) ... you already set the direction.
> Ditto for BT_NRESET.  And a suggestion:  prefix those symbols with
> something like OVERO_GPIO_ ... OVERO_ in case these move to public
> headers (board-overo.h), GPIO_ since that's what they are.
>
>
>> +++ b/drivers/video/omap/lcd_overo.c
>
> Strictly speaking this should be in a separate patch.

Excellent suggestions!  I will include in my resubmission.

Steve
