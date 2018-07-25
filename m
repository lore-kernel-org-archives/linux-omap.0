From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [Letux-kernel] [PATCH 09/32] ARM: dts: omap3-gta04: make NAND
 partitions compatible with recent U-Boot
Date: Wed, 25 Jul 2018 22:07:19 +0200
Message-ID: <20180725200719.GA28936@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com>
 <20180725080735.GA7467@lenoch>
 <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
 <20180725083305.GB8303@lenoch>
 <20180725182745.6e436abc@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992289AbeGYUHXGkuy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Wed, 25 Jul 2018 22:07:23 +0200
Content-Disposition: inline
In-Reply-To: <20180725182745.6e436abc@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 25, 2018 at 06:27:45PM +0200, Andreas Kemnade wrote:
> On Wed, 25 Jul 2018 10:33:05 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
> > >   
> > > > Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > > > 
> > > > On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:  
> > > >> Vendor defined U-Boot has changed the partition scheme a while ago:
> > > >> 
> > > >> * kernel partition 6MB
> > > >> * file system partition uses the remainder up to end of the NAND
> > > >> * increased size of the environment partition (to get an OneNAND compatible base address)
> > > >> * shrink the U-Boot partition
> > > >> 
> > > >> Let's be compatible (e.g. Debian kernel built from upstream).  
> > > > 
> > > > That, in fact, is breaking compatibility.  
> > > 
> > > With what? Nobody is using the old u-boot partition scheme any more
> > > (it is >5 years old).
> > >   
> > > > So once you are touching this
> > > > what about relying on partitioning provided by bootloader just to prevent
> > > > something like this happening again?  
> > > 
> > > Well, we define what compatible means here (since we are the vendor).
> > > And people complain with us. We simply recommend them to upgrade the
> > > boot-loader.  
> > 
> > Fair enough. Suggestion was to remove partitioning scheme from DTB alltogether
> > and let U-Boot provide one. But you being vendor you decide, of course :)
> > (I'd use only two partitions: MLO and UBI, latter one with BCH8, and store
> > everything in UBI volumes. That's a bit more flexible approach)
> > 
> hmm, so using mtdparts kernel commandline parameter? Somehow it sounds
> to be sane to not have partition tables in kernel. What only is needed
> is to have a nice transition scheme for systems in the wild, can
> commandline mtdparts overwrite dtb? So dtb is a fallback?

That's beginning to be offtopic here...  Anyway, see U-Boot's
CONFIG_FDT_FIXUP_PARTITIONS. Probably better to start a thread on
U-Boot mailing list if needed.

> But I think all that is a future improvement?

Depends on vendor decision, it could be done in a few days :)

Best regards,
	ladis
