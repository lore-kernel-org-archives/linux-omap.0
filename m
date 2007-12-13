From: "Girish" <girishsg@ti.com>
Subject: RE: McSPI interfaces in newer kernel
Date: Thu, 13 Dec 2007 11:28:07 +0530
Message-ID: <006201c83d4d$22a53e50$988818ac@ent.ti.com>
References: <94d6903b0712121554o5097604cxecaeac2b36832e33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <94d6903b0712121554o5097604cxecaeac2b36832e33@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Meng Hu' <meng.hu@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: Meng Hu [mailto:meng.hu@gmail.com] 
>Sent: Thursday, December 13, 2007 5:24 AM
>To: Girish
>Cc: Linux-omap-open-source@linux.omap.com

>Hi, Girish
>I am working on an OMAP2430 board, not the SDP though.
>The wierd thing is, the new upstream SPI driver fails on my board.
>Here are the kernel messages:
>---omap2_mcspi_init---
>omap2_mcspi_probe 1
>omap2_mcspi: probe of omap2_mcspi.1 failed with error -2 
>omap2_mcspi_probe 2
>omap2_mcspi: probe of omap2_mcspi.2 failed with error -2
>
>Any idea about this?

Omap2_mcspi should be working fine on 2430, check with your clock enabling, if it's causing the break.

>
>On the other hand, I ported the old TI SPI drivers to the new 
>kernel and they seem to work.
>And my 2046 touchscreen driver works fine with the old TI SPI drivers.
>There might be potential problems. I don't know.

You might want to use ads7846 touchscreen driver which is in upstream, 2046 is a newer ads7846 silicon.

-Girish
>> _______________________________________________
>> >Linux-omap-open-source mailing list
>> >Linux-omap-open-source@linux.omap.com
>> >http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>> >
>>
>>
>
