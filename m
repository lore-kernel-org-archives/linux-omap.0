From: Greg KH <greg@kroah.com>
Subject: Re: linux-next: manual merge of the staging-next tree with the
	omap tree
Date: Tue, 5 Oct 2010 20:36:05 -0700
Message-ID: <20101006033605.GB5719@kroah.com>
References: <20101006142110.e757f27c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101006142110.e757f27c.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 06, 2010 at 02:21:10PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging-next tree got a conflict in
> arch/arm/plat-omap/devices.c between commit
> f2ce62312650211f6cf665cd6dc519c334c4071e ("OMAP: WDT: Split OMAP1 and
> OMAP2PLUS device registration") from the omap tree and commit
> 90173882ed15a8034d6d162da5f343a2c7d87587 ("omap: add dsp platform
> device") from the staging-next tree.
> 
> Just overlapping removal/additions (I think).  I fixed it up (see below)
> and can carry the changes as necessary.

Your fixup looks correct to me, thanks for carrying it.

greg k-h
