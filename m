From: Arnold <abo_gwapo@yahoo.com>
Subject: Re: using __raw_read function
Date: Wed, 25 Oct 2006 19:29:09 -0700 (PDT)
Message-ID: <20061026022909.16399.qmail@web55303.mail.re4.yahoo.com>
References: <20061025180428.GI4852@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061025180428.GI4852@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Thank you for taking time to answer. I checked the
ARM_RSTCT2 bit 0 and it is enabled. I also checked the
ARM_IDLECT2 bits 1 and 2 and it is already enabled. Is
there anything I should still enable inorder to change
the value of the i2c registers? It seems that I can
not write to all i2c registers. Is there anything I am
doing wrong?

Thanks,
OJ 

--- Tony Lindgren <tony@atomide.com> wrote:

> * Arnold <abo_gwapo@yahoo.com> [061024 10:20]:
> > Hi All,
> > 
> > I am having problems writing a value to a specific
> > register. I dont know if the one causing this
> problem
> > is the __raw_readl function. I've tried to use all
> the
> > registers in the I2C and I get the same problem.
> The
> > values are not changed. Is there anyone who knows
> what
> > the problem is? I dont think this is specific to
> I2C. 
> 
> Maybe you don't have I2C clock(s) enabled?
> 
> Tony
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
