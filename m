From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: Anybody has MMC on Innovator 1510 working
Date: Fri, 28 Apr 2006 10:28:29 -0400
Message-ID: <4452268D.5010804@indt.org.br>
References: <00a401c66a52$76969380$6cfea8c0@wescongroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <00a401c66a52$76969380$6cfea8c0@wescongroup.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Jason Huang <jason.huang@wescongroup.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Jason Huang wrote:

>Dear list members:
>
>Is there anybody has MMC on Innovator working? Which version of Linux?
>
>I tried 2.6.11-omap1, 2.6.16-omap1, 2.6.16-omap2 as well as current git
>tree.
>All I got: MMC1: Command timeout, CMD0 when I did 'modprobe omap'.
>
>Any help is much appreciated.
>
>Best Regards.
> 
>Jason Huang
>1-408-727-8818
>
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>  
>
Hi Jason,

The MMC Driver is working fine on TI OMAP H2 and H3 using
Linux-2.6.16-omap1 and Linux-2.6.16-omap2 trees.

As Tony said, the current OMAP git tree it's broken because of switching
to use the mainline MMC code.

BR,

Carlos.


-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
