From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v7] board-omap3-beagle: add DSS2 support
Date: Wed, 21 Apr 2010 12:15:04 +0200
Message-ID: <922A7B30-72EF-4A6B-82BF-6BAA80AA3D47@dominion.thruhere.net>
References: <1271844135-15810-1-git-send-email-koen@dominion.thruhere.net> <r2g94a0d4531004210306t11fee422i858f4854dd65d653@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:42581 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab0DUKPI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 06:15:08 -0400
Received: by ey-out-2122.google.com with SMTP id d26so543272eyd.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 03:15:06 -0700 (PDT)
In-Reply-To: <r2g94a0d4531004210306t11fee422i858f4854dd65d653@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 21 apr 2010, om 12:06 heeft Felipe Contreras het volgende geschreven:

> On Wed, Apr 21, 2010 at 1:02 PM, Koen Kooi <koen.kooi@gmail.com> wrote:
>> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
>> 
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> ---
> 
>> @@ -456,8 +503,9 @@ static void __init omap3_beagle_init(void)
>>        /* Ensure SDRC pins are mux'd for self-refresh */
>>        omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>>        omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>> -}
>> 
>> +       beagle_display_init();
>> +}
> 
> Missing space here.

Thanks for the feedback! I've fixed that locally and will wait a few hours for potential feedback from others before sending v8.

regards,

Koen