From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Thu, 30 Oct 2008 21:05:02 -0700
Message-ID: <5e088bd90810302105n1132c280ga39179c057e55c3f@mail.gmail.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
	 <1225418657-31775-3-git-send-email-tony@atomide.com>
	 <1225418657-31775-4-git-send-email-tony@atomide.com>
	 <200810302012.35317.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:21439 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbYJaEFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 00:05:03 -0400
Received: by wf-out-1314.google.com with SMTP id 27so973540wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 30 Oct 2008 21:05:02 -0700 (PDT)
In-Reply-To: <200810302012.35317.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

On Thu, Oct 30, 2008 at 8:12 PM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 30 October 2008, Tony Lindgren wrote:
>> @@ -212,7 +212,7 @@ static void __init overo_init(void)
>>         omap_board_config = overo_config;
>>         omap_board_config_size = ARRAY_SIZE(overo_config);
>>         omap_serial_init();
>> -       hsmmc_init();
>> +       hsmmc_init(HSMMC1);
>
> Overo has its SDIO WLAN chip (libertas) hard wired to the second controller,
> as I understand things ... or maybe it's the third one.  :)

Correct!  The wi2wi chip is connected to mmc2 with a 4 bit data path.

Steve
