From: Tony Lindgren <tony@atomide.com>
Subject: Re: Config Linux for omap embedded system
Date: Thu, 12 Jan 2006 14:51:53 -0800
Message-ID: <20060112225153.GK5461@atomide.com>
References: <93481F4E3CC5F042BBDE9376E50F759A2A5A8B@zmy16exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <93481F4E3CC5F042BBDE9376E50F759A2A5A8B@zmy16exm63.ds.mot.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Chen leonard-a17094 <liangchen@motorola.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

You probably already figured all these out, but just in case...

* Chen leonard-a17094 <liangchen@motorola.com> [060104 18:07]:
> Hi, 
> 
> I'm a newbie for linux-omap, and am trying to port the linux-omap onto a
> specific embedded system, which has 8M/8M rom/ram.
> 
> I have some questions regarding with configuring Linux:
> 1. how to config the total memory when making the kernel? For example,
> 8M/8M rom/ram.

Adding mem=8M to kernel cmdline should do it.

> 2. how to specify the startup address when making the kernel? For
> example, the kernel is expected to start from 0x0a000000.

See Makefile.boot in mach-omap1 directory.
 
> 3. how to let the linker allocate code/data/stack on specific addresses?
> For example, code starts from 0x0a000000, data starts from 0x08000000,
> and stack starts from 0x04000000.

You can set a mapping in .lds file. See the old Psion second stage
bootloader boot2nd at:

http://www.yipton.demon.co.uk/boot2nd/latest/boot2nd.tgz

The file you want to look is boot2nd.lds.

Regards,

Tony
