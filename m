From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] ARM: dts: omap3-evm: Fix missing NAND partition
 information
Date: Tue, 12 Dec 2017 18:03:02 +0100
Message-ID: <20171212170302.GA8381@lenoch>
References: <20171212041213.27436-1-woods.technical@gmail.com>
 <20171212063930.GA2791@lenoch>
 <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Derald D. Woods" <woods.technical@gmail.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 12, 2017 at 10:31:26AM -0600, Derald D. Woods wrote:
> > What about passing U-Boot partitions information to kernel instead?
>
> I am testing using an appended device-tree. This has been the most
> reliable method for the OMAP34XX boards that I have. If you have an
> example config, with working command line MTDPARTS, for beagleboard(Rev.
> C4), Overo TOBI, or similiar OMAP34XX, I will gladly use it. Also note
> that other OMAP34XX boards currently provide a default partition
> layout. Is that bad practice for all of those as well? I am open to
> exploring the method that actually works.

Well, appended device tree is indeed good only for testing purposes
where bootloader is unable to provide one.

Problem with hardcoded partitions is that you need to keep bootloader
and kernel view of partitions the same. That's why U-Boot introduced
CONFIG_FDT_FIXUP_PARTITIONS which will add mtdparts into DTB.

	ladis
