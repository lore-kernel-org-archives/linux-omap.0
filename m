From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: Re: Missing mmc debounce clock (??)
Date: Fri, 18 Apr 2008 00:06:44 +0300
Message-ID: <4807BBE4.8030100@indt.org.br>
References: <20080325114302.GA4652@gandalf.research.nokia.com> <4804B2D5.8000708@indt.org.br> <alpine.DEB.1.00.0804151013130.21271@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37106 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbYDQVHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 17:07:38 -0400
In-Reply-To: <alpine.DEB.1.00.0804151013130.21271@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@booyaka.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

ext Paul Walmsley wrote:
> On Tue, 15 Apr 2008, Francisco Alecrim wrote:
>
>   
>> Hi Balbi,
>>
>>    I was with the patch below in my queue when you told about your email at
>> linux-omap.
>>
>> I guess that is the correct solution.
>>
>> What do you think?
>>     
>
> Eh, those clocks are identical to the existing MMC clocks.  
>
> Seems better for the time being  to modify omap_hsmmc.c:777 to test 
> against !cpu_is_omap34xx() before emitting a warning?
>   
You're right! Good catch!
>
> - Paul
>
>   


-- 
Francisco Keppler Silva Alecrim - INdT
Phone: +55 92 2126-1017

