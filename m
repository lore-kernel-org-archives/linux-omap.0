From: "Girish" <girishsg@ti.com>
Subject: RE: McSPI interfaces in newer kernel
Date: Wed, 12 Dec 2007 20:40:56 +0530
Message-ID: <004e01c83cd1$32c4aa40$988818ac@ent.ti.com>
References: <94d6903b0712111115h297769e2q1709777dd0e65bb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <94d6903b0712111115h297769e2q1709777dd0e65bb7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Meng Hu' <meng.hu@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com 
>[mailto:linux-omap-open-source-bounces@linux.omap.com] On 
>Behalf Of Meng Hu

>Should I port these files by myself? or change my other 
>drivers to use the new interfaces. (I am porting a touchscreen 
>driver which heavily relies on the old mscpi drivers)
You can very well use the SPI driver which is in upstream and further you can add any specific functionality needed on top of this.
Guess, the old SPI driver doesn't interface with SPI framework, well on which OMAP you are working?

-Girish
_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
