From: Arnold <abo_gwapo@yahoo.com>
Subject: using __raw_read function
Date: Tue, 24 Oct 2006 00:19:24 -0700 (PDT)
Message-ID: <20061024071924.15614.qmail@web55307.mail.re4.yahoo.com>
References: <CC7B089C59ED6841BAE28F1EA69A8543873721@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A8543873721@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

I am having problems writing a value to a specific
register. I dont know if the one causing this problem
is the __raw_readl function. I've tried to use all the
registers in the I2C and I get the same problem. The
values are not changed. Is there anyone who knows what
the problem is? I dont think this is specific to I2C. 

Below is the example code that I am doing. I want to
write to the register 0xFFFB382C a value of 0x48. With
the use of printk I could see that the value was not
changed. 

#define LXK_I2C_BASE  (void *) IO_ADDRESS(0xFFFB3800)
#define I2C_SA                          0x2C

void *g_i2c_base = LXK_I2C_BASE;

static int i2c_open(struct inode *inode, struct file
*filp)
 u32 l;
 l = 0x48;
    __raw_writel(l,g_i2c_base + I2C_SA);
    printk("Slave address = %x
\n",(__raw_readl(g_i2c_base + I2C_SA)));


        return 0;
}

If someone have an idea on whats going on, please give
me a hand.

Thanks,
OJ


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
