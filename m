From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to	use
	ldrex/strex
Date: Tue, 25 Jan 2011 14:19:39 -0000
Message-ID: <48949.9852680185$1295965237@news.gmane.org>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
	<000601cbbc97$cc6955d0$653c0170$@deacon@arm.com>
	<20110125141153.GA17286@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110125141153.GA17286@n2100.arm.linux.org.uk>
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
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

> > I've tested this on the Versatile Express (ca9x4, little endian) with a USB
> > hard drive and ext3 (rw) filesystem. I did a bunch of parallel dds of a 2GB
> > file containing random data whilst the system was fairly loaded. File checksums
> > all passed and the kernel didn't do anything untowards.
> >
> > Tested-by: Will Deacon <will.deacon@arm.com>
> >
> > I appreciate this is the same test configuration as the one Nicolas did,
> > but it at least replicates his findings.
> 
> Was this for just the first three or the complete set?

This was for your -devel branch as of last night (head 75c4aa97).
If I try to extract patches from the mailing list, Exchange destroys
them :(

Will
