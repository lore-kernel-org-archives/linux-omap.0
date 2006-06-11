From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 11 Jun 2006 13:08:02 +0300
Message-ID: <448BEB82.5020609@solidboot.com>
References: <20060611083756.85274.qmail@web37912.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060611083756.85274.qmail@web37912.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Komal Shah wrote:

> After looking at the files which are needed to change for
> prcm_read/write[l], clock.c needs the major update. I hope Richard is
> OK with going from __REG32(...) to __raw_read/write[l] based prcm_rw
> wrappers? 

read_reg() and write_reg() are definitely the way to go.  The __REG() 
macros are unportable, and usually even lead to inefficient assembly code.

As for which API is the most coherent, I've found that this approach 
makes the most sense:

static void __iomem *prcm_base;

static u32 prcm_read_reg(int reg);
static void prcm_write_reg(int reg, u32 value);

If you go with the readl/writel argument ordering, you'll end up with 
oddness like:

static u32 mmc_writel(struct mmc *mmc, u32 value, int reg);

You should also not expose the raw register read/write functions, but 
rather implement wrapper functions to modify the relevant registers. 
Otherwise you might run into race issues with a preemptible kernel.

Cheers,
Juha
