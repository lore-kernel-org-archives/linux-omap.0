From: Tony Lindgren <tony@atomide.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 16 Oct 2008 15:59:06 -0700
Message-ID: <20081016225905.GB15820@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com> <20081009124357.GF26230@atomide.com> <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com> <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com> <e5e6ade50810152349x38b6f5e2oe59780cc2008c837@mail.gmail.com> <20081016205743.GS15820@atomide.com> <e5e6ade50810161507y4a5ac9d6m9754169575dfbdda@mail.gmail.com> <20081016221053.GZ15820@atomide.com> <e5e6ade50810161515h6c050ab2k1657e1e3a12edd6c@mail.gmail.com> <20081016225222.GA15820@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64473 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbYJPW7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 18:59:10 -0400
Content-Disposition: inline
In-Reply-To: <20081016225222.GA15820@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, Rick Bronson <rick@efn.org>

* Tony Lindgren <tony@atomide.com> [081016 15:53]:
> * Nathan Monson <nmonson@gmail.com> [081016 15:15]:
> > On Thu, Oct 16, 2008 at 3:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > No.. And I also got some -33 errors here too :( So back to the drawing
> > > board.
> > >
> > > Could you post step by step instructions on how you can reproduce your
> > > problem?
> > 
> > I'm running the DSP Bridge patches in my kernel.  I got them set up
> > using this guide:
> > http://elinux.org/BeagleBoard/DSP_Howto
> > 
> > That guide also points to some sample binaries, including 'ping.out',
> > which is a simple round-trip test between the DSP and ARM.
> > 
> > To reproduce, I do this:
> > 1) Boot kernel with mem=122m
> > 2) modprobe bridgedriver phys_mempool_base=0x87a00000
> > phys_mempool_size=0x600000
> > base_img=/home/root/dsp/ddspbase_tiomap3430.dof64P
> > 3) while true; do ./ping.out; done
> > 
> > This ALWAYS reproduces within seconds.
> > 
> > If the DSP patches are too much work to get set up, I've also heard
> > that people can reproduce this issue by playing movie files with
> > mplayer on Angstrom.
> 
> Thanks, I'll set that up when I get a chance.
> 
> Meanwhile, here's one more patch for you to test if you have a chance.
> Maybe also do a power off for few seconds before booting with this
> just in case.
> 
> If this still does not help, then we'll use the strongly ordered patch
> for now, and tag v2.6.27-omap1 tomorrow. Then we can continue debugging
> the issue until we fully understand it.

Well with this one I eventually got one -33 error, but not a series of
them.

> Tony

> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -53,6 +53,7 @@ static struct omap_irq_bank {
>  static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
>  {
>  	__raw_writel(val, bank->base_reg + reg);
> +	__raw_readl(bank->base_reg + reg);
>  }
>  
>  static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)

