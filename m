From: "Girish" <girishsg@ti.com>
Subject: RE: touch screen on 2430sdp not giving X and Y values
Date: Fri, 26 Oct 2007 21:31:48 +0530
Message-ID: <000901c817e9$83f48c80$6a8918ac@ent.ti.com>
References: <c656a4d20710260532wb60aa47r369f80c3c58c946a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c656a4d20710260532wb60aa47r369f80c3c58c946a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'arun c' <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com 
>[mailto:linux-omap-open-source-bounces@linux.omap.com] On 

>Subject: touch screen on 2430sdp not giving X and Y values
>
>Hi all,
>
>I am working on 2430sdp. I am using the kernel linux-2.6.14-omap2-v4.
>
>I wanted to use the touch screen on sdp. I built the kernel 
>using the default configuration came with the kernel source.
>
Check in menu config whether OMAP SPI is enabled and see 
Touch Screen interface power is enabled. 

>I downloaded the evtest.c from net to test the touch screen.
Try enabling debug statements in the driver(if exists or you can
put some debug statements for printing x y & z).
>
>If i run it on 2430sdp i am getting the below result.

>
>am i missing anything????
>
>Regards,
>arun
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
