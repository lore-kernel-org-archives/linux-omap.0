From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: About to tag 2.6.16-omap1 & current patch status
Date: Wed, 29 Mar 2006 00:01:49 -0800 (PST)
Message-ID: <20060329080149.23826.qmail@web32901.mail.mud.yahoo.com>
References: <20060328153500.GF28751@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060328153500.GF28751@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> Hi all,
> 
> We're about to ready to tag 2.6.16-omap1. Let's do some testing
> and try to get few issues fixed. Currently there's at least the MMC
> issue with I2C powered sockets that we should fix before tagging
> 2.6.16-omap1.

I am able to boot the kernel on h4 EVM. No MMC crash. But following 
line on boot sequence. Bootloader is in prcm5b configuration.

...
Kernel command line: console=ttyS0,115200n8 root=/dev/nfs
nfsroot=172.21.41.211:
/pub/fs/oss,wsize=1024,rsize=1024 ip=dhcp
Clocking rate (Crystal/DPLL/MPU): 12.0/880/440 MHz
...

...
initcall at 0xc0010ae0: omap2_clk_arch_init+0x0/0xec(): returned with
error code
 -22
....

This is not a bug, as I am not passing mpurate on command line.

> 
> Pending patches for post 2.6.16-omap1
> 
> Komal Shah [PATCH] OMAP2 MCSPI Use resources

One bug in this patch: passing vaddr to request_mem_region.

> Komal Shah [PATCH] CBUS: various cleanups

These patches are need to be rebased. I will do it once you sync up
with latest mainline tree and -omap1 tag.

> Komal Shah [PATCH] OMAP: MMC: Move set_power to platform data

Remove this patch from pending queue, as it doesn't seems to be clean
solution as of now.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
