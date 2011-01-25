From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to	use
	ldrex/strex
Date: Tue, 25 Jan 2011 13:57:26 -0000
Message-ID: <5404.43312279439$1295963895@news.gmane.org>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110123001636.GA20841@n2100.arm.linux.org.uk>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

Hopefully this isn't too late to be useful.

> On Mon, Jan 17, 2011 at 07:21:40PM +0000, Russell King - ARM Linux wrote:
> > Switch the set/clear/change bitops to use the word-based exclusive
> > operations, which are only present in a wider range of ARM architectures
> > than the byte-based exclusive operations.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> As only one person replied to this patch with test information, I'm
> not happy to push this into -rc, and hence that prevents it going into
> -stable too.  That means omap2plus_defconfig .38 mainline kernels
> (including -stable) will remain potentially dangerous when run on
> SMP capable hardware.
> 
> Therefore, I see no alternative at the moment but to purposely cause
> builds which cover ARMv6, and ARMv6K or ARMv7 CPUs to save people from
> data corruption.
> 
> Please get your tested-by's to me for at least the first three patches
> of this series ASAP.

I've tested this on the Versatile Express (ca9x4, little endian) with a USB
hard drive and ext3 (rw) filesystem. I did a bunch of parallel dds of a 2GB
file containing random data whilst the system was fairly loaded. File checksums
all passed and the kernel didn't do anything untowards.

Tested-by: Will Deacon <will.deacon@arm.com>

I appreciate this is the same test configuration as the one Nicolas did,
but it at least replicates his findings.

Will
