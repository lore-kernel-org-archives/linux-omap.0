From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL
 is enabled
Date: Thu, 9 Nov 2017 06:44:49 +0100
Message-ID: <E542DC13-D6C4-4C84-8521-8CE468BD0AFE@goldelico.com>
References: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
 <20171108222755.GW28152@atomide.com>
 <20171108223604.GG28231@n2100.armlinux.org.uk>
 <20171108223810.GH28231@n2100.armlinux.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171108223810.GH28231@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: letux-kernel@openphoenux.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Russel,

> Am 08.11.2017 um 23:38 schrieb Russell King - ARM Linux <linux@armlinux.org.uk>:
> 
> On Wed, Nov 08, 2017 at 10:36:04PM +0000, Russell King - ARM Linux wrote:
>> We don't need a compiler warning there, we probably need better help
>> text against DEBUG_LL and against EARLY_PRINTK.
> 
> Actually, this is already clearly stated against DEBUG_LL:
> 
>          Note that selecting this option will limit the kernel to a single
>          UART definition, as specified below. Attempting to boot the kernel
>          image on a different platform *will not work*, so this option should
>          not be enabled for kernels that are intended to be portable.
> 
> and since EARLY_PRINTK depends on DEBUG_LL... I guess people don't
> read help texts anymore.

Yes, we read, but we face a situation where it doesn't help that it is a
well known problem *for you* or anyone else and that it is described in the help.

We simply had a private defconfig for years and someone enabled DEBUG_LL some
years ago and it worked.

Then we upgrade the kernel for every -rc and it continued to work well. Then,
recently when doing just one update the compiled kernel failed to boot. Nobody
did change and look at the defconfig and its help. We just merged the latest
patches from linus/master.

Do you expect anybody to remember after 3 years of *not* changing DEBUG_LL what
was written in a help message? Or to understand that DEBUG_LL has anything to
do with the mysteriously appearing boot problem? Which can't easily be debugged
since there are no messages despite playing with EARLY_PRINTK/EARLYCON?

It took me several hours of git bisect to find out the problematic commits
and needed help by the author to relate it to DEBUG_LL in the defconfig.

So we are coming from the other end with much less knowledge than you have.
Linux has grown to be a beast that only a handful of people fully understand.
And this patch is to help those poor production kernel maintainers like me
who don't...

A technically different solution would be to automatically disable DEBUG_LL
if it is not compatible with some other setting.

BTW it appears that there was similar code elsewhere long time ago:

http://elixir.free-electrons.com/linux/v3.1.10/source/arch/arm/plat-mxc/include/mach/debug-macro.S

BR and thanks,
Nikolaus Schaller
