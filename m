From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [01/17 PATCH] MMC: OMAP: Introduces new structures for
	MMC	multislot support.
Date: Tue, 4 Sep 2007 20:29:59 +0530
Message-ID: <005901c7ef04$445a1350$9f8818ac@ent.ti.com>
References: <46DD7059.9000107@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46DD7059.9000107@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Carlos Aguiar' <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>If I got it right you're asking if this code controls the
>concurrency between both slots sharing the same bus. Is that right? If
>so, yes. This code does it.
 Yes. That is what I meant. 

Thanks for the clarification.

Regards,
Madhu

 
-----Original Message-----
From: Carlos Aguiar [mailto:carlos.aguiar@indt.org.br] 
Sent: Tuesday, September 04, 2007 8:19 PM
To: ext Madhusudhan Chikkature Rajashekar
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [01/17 PATCH] MMC: OMAP: Introduces new structures for MMC
multislot support.

ext Madhusudhan Chikkature Rajashekar wrote:
> Hi Carlos,
>   
Hi Madhu,
>   
>> The concept of multislot applied here is to provide a code (and needed
>> modifications) that runs OMAP platforms with a single and/or two MMC
slots.
>>     
> Does this mean that supporting one or more MMC memory cards sharing the
same
> bus?
>   
Could you please re-work your question? I couldn't get it nicely... But
even though, if I got it right you're asking if this code controls the
concurrency between both slots sharing the same bus. Is that right? If
so, yes. This code does it.

BR,

Carlos.
> Regards,
> Madhu
>  
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Carlos
> Aguiar
> Sent: Monday, September 03, 2007 7:26 PM
> To: ext David Brownell
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: [01/17 PATCH] MMC: OMAP: Introduces new structures for MMC
> multislot support.
>
> ext David Brownell wrote:
>   
>> On Friday 17 August 2007, David Brownell wrote:
>>   
>>     
>>> On Friday 17 August 2007, Carlos Aguiar wrote:
>>>     
>>>       
>>>> Introduces new structures for MMC multislot support.
>>>>       
>>>>         
>>> Seems like #1 and #2 should be a single patch, since
>>> after #1 it won't compile ...
>>>     
>>>       
>>   
>>     
> Hi Dave,
>   
>> ... and maybe #3, and ... ?
>>   
>>     
> You're right! But this 'level of granularity' of the patches was
> requested by Tony.
>   
>> Also, this doesn't look to me primarily like "multislot"
>> support.  It's also "stop relying on GPIOs" for various
>> things that newer boards handle with external chips
>> (like CD and WP switches), and "move board-specific code
>> out of the MMC driver"...
>>   
>>     
> The concept of multislot applied here is to provide a code (and needed
> modifications) that runs OMAP platforms with a single and/or two MMC
slots.
>
> BR,
>
> Carlos.
>   
>> - Dave
>>
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>>   
>>     
>
>
>   


-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
