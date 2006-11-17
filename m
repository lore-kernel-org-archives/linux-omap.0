From: Khem Raj <kraj@mvista.com>
Subject: Re: Reading and Writing to Omap register
Date: Thu, 16 Nov 2006 19:37:14 -0800
Message-ID: <455D2E6A.5030804@mvista.com>
References: <20061117031945.29896.qmail@web55313.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061117031945.29896.qmail@web55313.mail.re4.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnold <abo_gwapo@yahoo.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



Arnold said the following on 11/16/2006 7:19 PM:
> Hi All,
>
> I been having problems reading/writing to omap
> registers. I'm using the __raw_read and __raw_write.
> It seems that when I use the __raw_readl the values of
> the register that is passed back to when I read the
> register is always 0. I am accessing a 4byte register
> and I want to write a value to it, but whenever I
> check the values using __raw_read_l, the values does
> not change. But it confuses me when I tried to use a
> __raw_readb it changes the value. It also concerns me 
> because the register that I am accesing is a 4byte
> register and not a 1 bytes register. Below is my
> implementation:
> Using __raw_readl:
> u32 l;
>
> l = 0x10;
> __raw_writel(l,MY_REG);
> printk("MY_REG = %x \n", __raw_readl(l,MY_REG));
>   
why are you passing 'l' as first argument here? This function accepts 
only one argument and that should be MY_REG in your case.
> --> This implementation always  prints a 0.
>
> However when I use this implementation:
> l = 0x10;
> __raw_writeb(l,MY_REG);
> printk("MY_REG = %x \n", __raw_readb(l,MY_REG));
> --> This implementation  prints a 0x10.
>   
same here
> Does anyone knows whats wrong? I am using an omap5912
> and kernel2.6.17. 
>
> I hope somebody could tell me whats wrong. Thank you
> very much in advance.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>  
> ____________________________________________________________________________________
> Sponsored Link
>
> Mortgage rates near 39yr lows. 
> $510k for $1,698/mo. Calculate new payment! 
> www.LowerMyBills.com/lre
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>   

-- 
Khem Raj <kraj@mvista.com>
MontaVista Software Inc.
