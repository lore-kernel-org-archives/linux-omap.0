From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap24xx is broken in current head
Date: Mon, 11 Aug 2008 18:29:44 +0300
Message-ID: <20080811152944.GP25784@atomide.com>
References: <20080810115818.GG7574@frodo> <20080810121655.GH7574@frodo> <C558C578-1F45-433E-B82F-F5667CEBAFAF@student.utwente.nl> <1218388936.24010.138.camel@localhost> <20080811145053.GL25784@atomide.com> <28085EBF-3BA7-4093-A18F-4035D5DD8040@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62747 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbYHKPaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 11:30:02 -0400
Content-Disposition: inline
In-Reply-To: <28085EBF-3BA7-4093-A18F-4035D5DD8040@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Igor Stoppa <igor.stoppa@nokia.com>, me@felipebalbi.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [080811 18:00]:
>
> Op 11 aug 2008, om 16:50 heeft Tony Lindgren het volgende geschreven:
>
>> * Igor Stoppa <igor.stoppa@nokia.com> [080810 20:39]:
>>> On Sun, 2008-08-10 at 14:37 +0200, ext Koen Kooi wrote:
>>>
>>>> "Broken as hell" if you want to do anything NEON related with it.
>>>
>>> yup
>>> Very unlucky but very true.
>>>> I
>>>> use 2007q3 with the -Os fix for compiling omap3 kernels
>>>
>>> Felipe: that's also what we should use internally, since it's the  
>>> only
>>> one approved by our system performance team.
>>
>> I'll revert this patch for now to avoid adding a compiler dependency
>> as we already have a pile of other issues to solve.
>
> Speaking of compiler dependencies, how about applying my patch that  
> enable vanilla gcc to compile the kernel? Russel (or Erik) seems to be  
> fond of rejecting my mails to the LAKML list, so I can't post it there. A 
> copy of it can be found here:
>
> http://ewi546.ewi.utwente.nl/git/?p=openembedded.git;a=blob;f=packages/linux/linux-omap2-git/beagleboard/no-harry-potter.diff;h=2bb20ab9c025312fcf0434de5bcb88aeceb4f87f;hb=HEAD

That seems like a good patch, you should see what the issue is with
posting to LAKML. Maybe add it to Russell's patch system meanwhile? :)

Meanwhile, yeah I'd say if that works on more compilers, let's add it
to l-o tree.

Tony


> regards,
>
> Koen
>
>>
>>
>> Let's plan on re-applying this patch once the other issues are out of
>> the way.
>>
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


