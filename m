From: Khem Raj <kraj@mvista.com>
Subject: Re: Can Assembly Language be used to write code for the OMAP 5912
 chip
Date: Tue, 13 Feb 2007 00:07:43 -0800
Message-ID: <45D171CF.5000501@mvista.com>
References: <395747.36848.qm@web50101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <395747.36848.qm@web50101.mail.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Rene Holder <holder_rene@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



Rene Holder said the following on 2/12/2007 9:08 PM:
> Is it possible to write a program for the OMAP 5912 chip in Assembly language? 
Yes why not. After all its ARM architecture based system.
> I looked through the archives but was unsuccessfull in finding any information and I am unable to find an assembler online which can be used with the OMAP 5912 chip. 
>
>   
you can use ARM assembler from GNU binutils cross compiled for arm 
targets. You can get more documentation on binutils website on how to 
use it.
http://sourceware.org/binutils/docs-2.17/as/index.html
>  
> ---------------------------------
> We won't tell. Get more on shows you hate to love
> (and love to hate): Yahoo! TV's Guilty Pleasures list.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>   

-- 
Khem Raj <kraj@mvista.com>
MontaVista Software Inc.
