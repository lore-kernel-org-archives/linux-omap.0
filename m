From: Arnold <abo_gwapo@yahoo.com>
Subject: Reading and Writing to Omap register
Date: Thu, 16 Nov 2006 19:19:42 -0800 (PST)
Message-ID: <20061117031945.29896.qmail@web55313.mail.re4.yahoo.com>
References: <ae36f8040611090927qfd0272ao39babf4388c82091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ae36f8040611090927qfd0272ao39babf4388c82091@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

I been having problems reading/writing to omap
registers. I'm using the __raw_read and __raw_write.
It seems that when I use the __raw_readl the values of
the register that is passed back to when I read the
register is always 0. I am accessing a 4byte register
and I want to write a value to it, but whenever I
check the values using __raw_read_l, the values does
not change. But it confuses me when I tried to use a
__raw_readb it changes the value. It also concerns me 
because the register that I am accesing is a 4byte
register and not a 1 bytes register. Below is my
implementation:
Using __raw_readl:
u32 l;

l = 0x10;
__raw_writel(l,MY_REG);
printk("MY_REG = %x \n", __raw_readl(l,MY_REG));
--> This implementation always  prints a 0.

However when I use this implementation:
l = 0x10;
__raw_writeb(l,MY_REG);
printk("MY_REG = %x \n", __raw_readb(l,MY_REG));
--> This implementation  prints a 0x10.

Does anyone knows whats wrong? I am using an omap5912
and kernel2.6.17. 

I hope somebody could tell me whats wrong. Thank you
very much in advance.















 
____________________________________________________________________________________
Sponsored Link

Mortgage rates near 39yr lows. 
$510k for $1,698/mo. Calculate new payment! 
www.LowerMyBills.com/lre
