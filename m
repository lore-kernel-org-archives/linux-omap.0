From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Tue, 21 Sep 2010 15:43:28 -0700
Message-ID: <87pqw6hg4v.fsf@deeprootsystems.com>
References: <1285079310-15888-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1009211400460.4677@utopia.booyaka.com>
	<878w2uj1tv.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1009211425530.4677@utopia.booyaka.com>
	<871v8mizb4.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1009211512570.4677@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:53573 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0IUWnb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 18:43:31 -0400
Received: by pxi10 with SMTP id 10so1580458pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Sep 2010 15:43:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009211512570.4677@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 21 Sep 2010 15:13:38 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 21 Sep 2010, Kevin Hilman wrote:
>
>> Paul Walmsley <paul@pwsan.com> writes:
>> 
>> > On Tue, 21 Sep 2010, Kevin Hilman wrote:
>> >
>> >> FWIW
>> >> 
>> >> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>> >> 
>> >> as I'm using this for testing the various hwmod conversions.
>> >
>> > Thanks Kevin, added that in.  I know you've been testing some of the other 
>> > patches here too, so please let me know if you would like Tested-by:'s or 
>> > Acked-by:'s there.
>> 
>> I guess you can put a Tested-by for me on everything in your
>> hwmod_2.6.37 branch as I've been staging and testing those for a bit
>> now.
>
> OK, sounds good.  How about the updated hardreset code - have you given 
> that a try?

I just rebased onto your hwmod_2.6.37 branch, so testing it today.

Kevin
