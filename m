From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [01/17 PATCH] MMC: OMAP: Introduces new structures for
 MMC	multislot support.
Date: Mon, 03 Sep 2007 09:55:46 -0400
Message-ID: <46DC1262.1000002@indt.org.br>
References: <46C5F08D.7070207@indt.org.br>	<200708171445.28921.david-b@pacbell.net>
	<200708171455.15439.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708171455.15439.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
