From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Fri, 1 Jun 2018 16:55:02 +0100
Message-ID: <20180601155502.GB6920@n2100.armlinux.org.uk>
References: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
 <20180601153512.GV5705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180601153512.GV5705@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 01, 2018 at 08:35:12AM -0700, Tony Lindgren wrote:
> * Russell King <rmk+kernel@armlinux.org.uk> [180601 11:02]:
> > Executing loops such as:
> > 
> > 	while (1)
> > 		cpu_relax();
> > 
> > with interrupts disabled results in a livelock of the entire system,
> > as other CPUs are prevented making progress.  This is most noticable
> > as a failure of crashdump kexec, which stops just after issuing:
> > 
> > 	Loading crashdump kernel...
> > 
> > to the system console.  Two other locations of these loops within the
> > ARM code have been identified and fixed up.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Works for me thanks:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks.

> BTW, do LZMA crashkernels boot for you with crashdump?
> 
> For me LZMA crashkernels fail to boot while GZIP crashkernels
> boots. Some more info below for failing and working output.
> 
> Regards,
> 
> Tony
> 
> 8< ----------------------
> CONFIG_KERNEL_LZMA fails:
> 
> Try gzip decompression.
> Try LZMA decompression.
> lzma_decompress_file: read on /boot/zImage of 65536 bytes failed
> kernel: 0xb6abb010 kernel_size: 0x43d0f0
> MEMORY RANGES
> 0000000080000000-00000000bfdfffff (0)
> zImage header: 0x016f2818 0x00000000 0x0043d0f0
> zImage size 0x43d0f0, file size 0x43d0f0
> Reserved memory ranges

This looks like an old kexec binary as it's missing the output from:

        dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);

Please can you test with the current version - the official
repository should now be up to date with my version.  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
