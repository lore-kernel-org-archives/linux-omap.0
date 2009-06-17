From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [PATCH] TWL4030: Reset header file to mainline
Date: Wed, 17 Jun 2009 18:20:24 +0400
Message-ID: <4A38FBA8.8090406@gmail.com>
References: <1245238182-11697-1-git-send-email-amit.kucheria@verdurent.com> <4A38F387.1050502@gmail.com> <20090617140648.GT6605@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from postoffice.embeddedalley.com ([65.114.89.228]:33653 "HELO
	postoffice.embeddedalley.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933823AbZFQOUT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2009 10:20:19 -0400
In-Reply-To: <20090617140648.GT6605@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Eugeny S. Mints <eugeny.mints@gmail.com> [090617 06:46]:
>   
>> Amit Kucheria wrote:
>>     
>>> Reset twl4030.h to what is upstream. Patches to restore twl4030_power
>>> functionality will follow directly to lkml.
>>>
>>>   
>>>       
>> development against upstream is great. But what will be left for
>> this mail list if we send all patches directly to lkml?
>>     
>
> Anything touching arch/arm/*omap*.
>   

I'm not sure how many non-omap based boards out there are using twl4030 
chip and if a separate mfd mail list exists.
But until any of the above is true I personally feel that twl4030 
related discussions naturally fall into omap mail list.

> Also, while waiting things to get to mainline, we can merge in various
> topic branches, such as PM, DSS2. So basically linux-omap master branch
> will shortly be just a queue of things going to the mainline tree while
> waiting for the next merge window.
>
>   
ok
> Regards,
>
> Tony
>
>   

