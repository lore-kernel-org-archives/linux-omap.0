From: Arnold <abo_gwapo@yahoo.com>
Subject: Re: Is there wrong with the file :io.h????????
Date: Tue, 19 Sep 2006 03:56:45 -0700 (PDT)
Message-ID: <20060919105645.97356.qmail@web55305.mail.re4.yahoo.com>
References: <003401c6dbce$064e52a0$4e0aa8c0@wbb>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <003401c6dbce$064e52a0$4e0aa8c0@wbb>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "w.b.b" <rememberme_2000@126.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I think you need to create a char driver in order to
use the GPIO APIs. In this way you can already control
GPIO in the userspace through your char driver. There
are many linux device driver books that you could
refer to make a char driver.

Best Regards,
OJ
 

--- "w.b.b" <rememberme_2000@126.com> wrote:

> i had found the way to  avoid the error.  modify the
> file asm/arch/io.h.
>  to change the data types ,such as u8,u16,u32 with
> uint8_t,uint16_t,uint32_t.
>  then there is no error when you compile that file.
>  i think there is a little bug in the io.h!!!
> 
> ----- Original Message ----- 
> From: "w.b.b" <rememberme_2000@126.com>
> To: <Linux-omap-open-source@linux.omap.com>
> Sent: Tuesday, September 19, 2006 4:54 PM
> Subject: Is there wrong with the file :io.h???????? 
> 
> 
> > hi:
> > i 'd written a simeple program.and i'd found some
> questions about io.h.
> > the following code is:
> > that:
> >  #include<asm/arch/gpio.h>
> > main()
> > {
> > omap_request_gpio(3);
> > omap_set_gpio_direction(3,1);
> > }  
> > compile command :
> > arm-linux-gcc -I linux-2.6.13.4/include -c main.c
> > and then i got the following error information:
> > linux-2.6.13.4/include/asm/arch/io.h:91
> error:parse error before "offset"
> > linux-2.6.13.4/include/asm/arch/io.h:97
> error:parse error before "offset"
> > linux-2.6.13.4/include/asm/arch/io.h:102
> error:parse error before "offset".
> > the toolchains which i used is gcc-3.4.1 for omap
> 5912,and the kernel is linux-2.6.13.4  for osk.
> > Is the file wrong? i'm not sure about it!!!!!!!
> >            who has interest in it? i hope to get
> your help. 
> >> Linux-omap-open-source@linux.omap.com
> >>
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >>
> 
> 
>
--------------------------------------------------------------------------------
> 
> 
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> >
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
