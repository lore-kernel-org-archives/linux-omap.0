From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OSK5912 Boot from CF?
Date: Mon, 27 Aug 2007 21:22:54 +0200
Message-ID: <46D3248E.5000604@googlemail.com>
References: <262354.79141.qm@web8503.mail.in.yahoo.com>	
	<1188239988.5137.3.camel@localhost.localdomain>	
	<46D32043.5070603@googlemail.com>
	<1188241974.5137.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1188241974.5137.7.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: hkh@cypress.com
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hingkwan Huen wrote:
> Thanks for the comment Dirk! 
> How about having the root file system on the CF, and kernel on the NOR
> flash?

This should work. If you have a bootloader (e.g. uboot) with CF & 
filesystem support in NOR, you should even be able to put the kernel 
on CF as well.

> Regards,
> kwan
> 
> On Mon, 2007-08-27 at 21:04 +0200, Dirk Behme wrote:
> 
>>Hingkwan Huen wrote:
>>
>>>Dear All,
>>>Can OSK5912 boot from CF?
>>
>>No, I don't think so. Some time ago booting was described in "OMAP5912 
>>Multimedia Processor Initialization Reference Guide (spru752)", but 
>>looks like this changed. Check [1] if you can find anything there 
>>about booting.
>>
>>Regards
>>
>>Dirk
>>
>>[1] 
>>http://focus.ti.com/docs/prod/folders/print/omap5912.html#technicaldocuments
>>
>>
> 
> 
> 
