From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 0/3] musb_hdrc, remove MGC_{Read,Write}Csr{8,16}
Date: Thu, 18 Jan 2007 16:03:02 -0800
Message-ID: <20070119000301.GA7915@atomide.com>
References: <200701181535.08332.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200701181535.08332.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070118 15:39]:
> Folowing this are three patches removing those annoying CaMeLcAsE
> macros cluttering up the sources ... this is the last significant
> such fix that's needed IMO, although certainly struct members,
> variables, and function/procedure parameters can be cleaned up.
> 
> Given that, issues I know about on the musb_hdrc code in GIT right
> now, observed on tusb6010 but not tested on DaVinci, include:
> 
>  - Hmm, host side was not enumerating ... new failure

I've noticed that too, I'm getting this after plugging in a powered hub
and a mouse in OTG mode:

tusb_interrupt 525: TUSB IRQ 0000a000
tusb_interrupt 556: wake active 06
tusb_otg_ints 435: vbus change, b_idle, otg 171
tusb_interrupt 525: TUSB IRQ 00004000
tusb_otg_ints 404: Default-A
tusb_set_vbus 384: VBUS a_wait_vrise, devctl 99 otg 171 conf c0010000 prcm 00a800
tusb_interrupt 525: TUSB IRQ 00010000
tusb_otg_ints 467: a_wait_vrise timer, 171
tusb_interrupt 525: TUSB IRQ 00000010
musb_interrupt 1351: ** IRQ host usb0010 tx0000 rx0000
musb_stage0_irq 310: <== Power=e0, DevCtl=5d, bIntrUSB=0x10
musb_stage0_irq 515: CONNECT (a_host) devctl 5d

Are you getting same results on h4?

>  - DMA wierdness of various types
>  - Various issues with suspend states and remote wakeup
> 
> That list is just so anyone running into them needn't be too
> surprised.

Pushed all.

Tony
