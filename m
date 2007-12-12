From: "Meng Hu" <meng.hu@gmail.com>
Subject: Re: McSPI interfaces in newer kernel
Date: Wed, 12 Dec 2007 17:54:01 -0600
Message-ID: <94d6903b0712121554o5097604cxecaeac2b36832e33@mail.gmail.com>
References: <94d6903b0712111115h297769e2q1709777dd0e65bb7@mail.gmail.com>
	<004e01c83cd1$32c4aa40$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <004e01c83cd1$32c4aa40$988818ac@ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Dec 12, 2007 9:10 AM, Girish <girishsg@ti.com> wrote:
>
>
> >-----Original Message-----
> >From: linux-omap-open-source-bounces@linux.omap.com
> >[mailto:linux-omap-open-source-bounces@linux.omap.com] On
> >Behalf Of Meng Hu
>
> >Should I port these files by myself? or change my other
> >drivers to use the new interfaces. (I am porting a touchscreen
> >driver which heavily relies on the old mscpi drivers)
> You can very well use the SPI driver which is in upstream and further you can add any specific functionality needed on top of this.
> Guess, the old SPI driver doesn't interface with SPI framework, well on which OMAP you are working?

Hi, Girish
I am working on an OMAP2430 board, not the SDP though.
The wierd thing is, the new upstream SPI driver fails on my board.
Here are the kernel messages:
---omap2_mcspi_init---
omap2_mcspi_probe 1
omap2_mcspi: probe of omap2_mcspi.1 failed with error -2
omap2_mcspi_probe 2
omap2_mcspi: probe of omap2_mcspi.2 failed with error -2

Any idea about this?

On the other hand, I ported the old TI SPI drivers to the new kernel
and they seem to work.
And my 2046 touchscreen driver works fine with the old TI SPI drivers.
There might be potential problems. I don't know.

-Meng


>
> -Girish
> _______________________________________________
> >Linux-omap-open-source mailing list
> >Linux-omap-open-source@linux.omap.com
> >http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
>
