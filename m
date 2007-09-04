From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [01/17 PATCH] MMC: OMAP: Introduces new structures for
	MMC	multislot support.
Date: Tue, 4 Sep 2007 14:02:37 +0530
Message-ID: <002f01c7eece$27b31570$9f8818ac@ent.ti.com>
References: <46DC1262.1000002@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46DC1262.1000002@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Carlos Aguiar' <carlos.aguiar@indt.org.br>, 'ext David Brownell' <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Carlos,

>The concept of multislot applied here is to provide a code (and needed
>modifications) that runs OMAP platforms with a single and/or two MMC slots.
Does this mean that supporting one or more MMC memory cards sharing the same
bus?

Regards,
Madhu
 
-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Carlos
Aguiar
Sent: Monday, September 03, 2007 7:26 PM
To: ext David Brownell
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [01/17 PATCH] MMC: OMAP: Introduces new structures for MMC
multislot support.

ext David Brownell wrote:
> On Friday 17 August 2007, David Brownell wrote:
>   
>> On Friday 17 August 2007, Carlos Aguiar wrote:
>>     
>>> Introduces new structures for MMC multislot support.
>>>       
>> Seems like #1 and #2 should be a single patch, since
>> after #1 it won't compile ...
>>     
>
>   
Hi Dave,
> ... and maybe #3, and ... ?
>   
You're right! But this 'level of granularity' of the patches was
requested by Tony.
> Also, this doesn't look to me primarily like "multislot"
> support.  It's also "stop relying on GPIOs" for various
> things that newer boards handle with external chips
> (like CD and WP switches), and "move board-specific code
> out of the MMC driver"...
>   
The concept of multislot applied here is to provide a code (and needed
modifications) that runs OMAP platforms with a single and/or two MMC slots.

BR,

Carlos.
> - Dave
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
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

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
