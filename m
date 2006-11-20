From: Arnold <abo_gwapo@yahoo.com>
Subject: Re: Reading and Writing to Omap register
Date: Sun, 19 Nov 2006 17:51:16 -0800 (PST)
Message-ID: <121193.77841.qm@web55306.mail.re4.yahoo.com>
References: <455D2E6A.5030804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <455D2E6A.5030804@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Khem Raj <kraj@mvista.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Sorry it was just a typo error. What I am using is:

__raw_writel(l,MY_REG);
printk("MY_REG = %x \n", __raw_readl(MY_REG));

The MY_REG is a 4byte register. I can not change the
value if I am using the __raw_writel. But if I use a
__raw_writew or __raw_writeb and if I print the value
of the register using __raw_readw and __raw_readb the
value changes. 

Is there something wrong with what I am doing? It
seems to be weird.





--- Khem Raj <kraj@mvista.com> wrote:

> 
> 
> Arnold said the following on 11/16/2006 7:19 PM:
> > Hi All,
> >
> > I been having problems reading/writing to omap
> > registers. I'm using the __raw_read and
> __raw_write.
> > It seems that when I use the __raw_readl the
> values of
> > the register that is passed back to when I read
> the
> > register is always 0. I am accessing a 4byte
> register
> > and I want to write a value to it, but whenever I
> > check the values using __raw_read_l, the values
> does
> > not change. But it confuses me when I tried to use
> a
> > __raw_readb it changes the value. It also concerns
> me 
> > because the register that I am accesing is a 4byte
> > register and not a 1 bytes register. Below is my
> > implementation:
> > Using __raw_readl:
> > u32 l;
> >
> > l = 0x10;
> > __raw_writel(l,MY_REG);
> > printk("MY_REG = %x \n", __raw_readl(l,MY_REG));
> >   
> why are you passing 'l' as first argument here? This
> function accepts 
> only one argument and that should be MY_REG in your
> case.
> > --> This implementation always  prints a 0.
> >
> > However when I use this implementation:
> > l = 0x10;
> > __raw_writeb(l,MY_REG);
> > printk("MY_REG = %x \n", __raw_readb(l,MY_REG));
> > --> This implementation  prints a 0x10.
> >   
> same here
> > Does anyone knows whats wrong? I am using an
> omap5912
> > and kernel2.6.17. 
> >
> > I hope somebody could tell me whats wrong. Thank
> you
> > very much in advance.
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >  
> >
>
____________________________________________________________________________________
> > Sponsored Link
> >
> > Mortgage rates near 39yr lows. 
> > $510k for $1,698/mo. Calculate new payment! 
> > www.LowerMyBills.com/lre
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> >
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >   
> 
> -- 
> Khem Raj <kraj@mvista.com>
> MontaVista Software Inc.
> 
> 



 
____________________________________________________________________________________
Sponsored Link

$420k for $1,399/mo. 
Think You Pay Too Much For Your Mortgage? 
Find Out! www.LowerMyBills.com/lre
