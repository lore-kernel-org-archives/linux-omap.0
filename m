From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 05:01:53 -0700
Message-ID: <4B7BDAB1.3020503@mlbassoc.com>
References: <4B7AE1AD.7080400@mlbassoc.com> <201002171226.05108.peter.ujfalusi@nokia.com> <4B7BC86C.8040905@mlbassoc.com> <201002171317.27896.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:60821 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab0BQMB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 07:01:56 -0500
In-Reply-To: <201002171317.27896.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

On 02/17/2010 04:17 AM, Peter Ujfalusi wrote:
> On Wednesday 17 February 2010 12:43:56 ext Gary Thomas wrote:
>> On 02/17/2010 03:26 AM, Peter Ujfalusi wrote:
>>> On Wednesday 17 February 2010 09:03:39 ext Jarkko Nikula wrote:
>>>> On Tue, 16 Feb 2010 11:19:25 -0700
>>>>
>>>> Gary Thomas<gary@mlbassoc.com>   wrote:
>>>>> I need to connect the OMAP (3530) to a 24bit CODEC.  So far
>>>>> my attempts at getting this to go have not gone well.  Then
>>>>>
>>>>> I ran across this comment in sound/soc/omap/omap-pcm.c:
>>>>> 	/*
>>>>> 	
>>>>> 	 * Note: Regardless of interface data formats supported by OMAP McBSP
>>>>> 	 * or EAC blocks, internal representation is always fixed
>>>>> 	 16-bit/sample */
>>>>>
>>>>> Does this mean that this setup is just not supported?  even though
>>>>> the hardware can handle it?
>>>>
>>>> Yep, comment is bit misleading but true until some patch will remove
>>>> it. IRCC, the EAC was limited to 16-bit and also there wasn't need and
>>>> HW to test other formats than S16_LE in McBSP DAI.
>>>>
>>>>> Thanks for any pointers or ideas on how to get this going.
>>>>
>>>> I would first start adding support for the S32_LE into omap-pcm.c (DMA
>>>> part). Worth to look this thread:
>>>>
>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/024704
>>>> .ht ml
>>>>
>>>> Then add support for this format to the omap-mcbsp.c (link
>>>> configuration part).
>>>>
>>>> Next step would be to add support for the S24_LE on 4-byte boundaries.
>>>> I.e. the DMA is moving 32-bit samples between the memory and McBSP but
>>>> only 24-bits are transferred over the McBSP and codec.
>>>
>>> Hmmm, I think this is a bit more complicated than that at least on OMAP3.
>>> I think the DMA engine should also move 24 bit words.
>>> This is dictated by the McBSP FIFO: it has a notion of word size, and it
>>> is expecting that the DMA engine will move THRESHOLD number of words. So
>>> if the McBSP is configured for 24 bit words, than the DMA word size has
>>> to match that.
>>>
>>> Apart from this, the constraint set for the period bytes need to be
>>> changed since as you change the word size in McBSP you will have
>>> different amount of actual bytes for the FIFO (the FIFO size is in
>>> words, and the maximum word size is 32 bit).
>>
>> Thanks for the help.  I'm pretty sure I understand how to change
>> the McBSP code (omap-mcbsp.c) to handle the various formats, but
>> I'm a bit lost in the DMA setup (omap-pcm.c).  How do I identify
>> the code/width in omap_pcm_prepare()?
>
> After looking at the TRM of OMAP, the sDMA has support for 8, 16 and 32 bit data
> types. So I'm not really sure how to configure McBSP and sDMA in case of 24 bit
> packed format.
> I would go with a trial and error method and find it out how it is working...
>
>> Has no one ever used the OMAP/McBSP with data sizes other than 16 bits??
>
> At least I can not recall. I have had a plan to add support for these, but it
> got delayed and delayed ;)
>

How about sending padded data (24 bits in 32) which is what my
CODEC wants anyway?  Would this be easier to set up?  How?

(Again, I'm a bit fuzzy on how to tell omap_pcm_prepare that I
need to be moving 24 or 32 bit chunks)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
