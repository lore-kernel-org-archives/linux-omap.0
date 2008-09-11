From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] Fixed CPU type check for OMAP3
Date: Thu, 11 Sep 2008 11:52:05 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394307A946D@vaebe110.NOE.Nokia.com>
References: <1220892685-3422-1-git-send-email-tero.kristo@nokia.com> <20080911002912.GG21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23246 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYIKIwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 04:52:15 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080911002912.GG21163@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

 

>From: ext Tony Lindgren [mailto:tony@atomide.com] 
>Sent: 11 September, 2008 03:29
>
>I've redone the id.c, the old one was getting messy for omap2. 
>Maybe try my patch I posted on Tuesday and see how it works for you?

Hmm did not notice this patch, just made a quick fix for this as I was
seeing some problems with CPU type detection. I need to check this out
when I have more time for this.

>
>Also one comment below.
>>  #define OMAP3430_REV_ES1_0	0x34300000
>>  #define OMAP3430_REV_ES2_0	0x34301000
>>  #define OMAP3430_REV_ES2_1	0x34302000
>> -#define OMAP3430_REV_ES2_2	0x34303000
>> +#define OMAP3430_REV_ES3_0	0x34303000
>>  
>>  /*
>>   * omap_chip bits
>
>Are you sure ES3.0 gives a three for revision? I believe 2.2 
>had 3, or is the revision register broken again?

I have tested this piece of code with ES2.1 and ES3.0 and it gives
correct results, so I am certain 3.0 gives a 3 for rev. Regarding 2.2 I
am not so sure, I think such chip revision does not exist at all. There
was also something weird with the earlier code as it increased revision
by 1, thus giving wrong results for any revision... and causing
is_sil_rev_* macros to give incorrect results.

-Tero
