From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP3 PM: fix the error messages printed when the system
 	suspend
Date: Tue, 10 Aug 2010 09:30:18 +0800
Message-ID: <4C60ABAA.5010805@windriver.com>
References: <1277195484-5501-1-git-send-email-stanley.miao@windriver.com>	<87iq5bm7ac.fsf@deeprootsystems.com> <AANLkTi=Dud9H_1TUD6egOtAUaSYzqyqsMP3=3Sj9YWjZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54251 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0HJBQR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 21:16:17 -0400
In-Reply-To: <AANLkTi=Dud9H_1TUD6egOtAUaSYzqyqsMP3=3Sj9YWjZ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Cliff Brake wrote:
> On Tue, Jun 22, 2010 at 11:11 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>   
>> "Stanley.Miao" <stanley.miao@windriver.com> writes:
>>
>> First, the subject needs to be more descriptive:
>>
>> OMAP3: AM3505/3517 do not have IO wakeup capability
>>     
>
> Functionally, what does this statement mean?  The 3503 seems to have
> the EN_IO [8] bit, but I've yet to figure out what the EN_IO_CHAIN
> [16] means.
>   

Please reference to Chapter 4.11 PRCM Off-Mode Management in OMAP35x TRM.

Stanley.
> Thanks,
> Cliff
>
>   

