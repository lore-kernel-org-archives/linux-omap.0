From: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Subject: Re: BUG (maybe) with find_get_entry()
Date: Wed, 8 Oct 2014 20:13:04 +0200
Message-ID: <20141008181304.GA3109@debian>
References: <20141008165714.GG22688@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141008165714.GG22688@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 08, 2014 at 11:57:14AM -0500, Felipe Balbi wrote:
> Hi,
> 
> With today's linus/master and with greg/usb-next I keep getting random
> kernel oops from find_get_entry() (see below):
> 
> [   47.700065] Unable to handle kernel paging request at virtual address ffffffff
> [   47.707667] pgd = c0004000
> [   47.710506] [ffffffff] *pgd=ae7f6821, *pte=00000000, *ppte=00000000
> [   47.717135] Internal error: Oops: 17 [#1] SMP ARM
> [   47.722047] Modules linked in: g_mass_storage usb_f_mass_storage libcomposite configfs xhci_plat_hcd xhci_hcd snd_soc_davinci_mcasp snd_soc_edma snd_soc_omap snd_soc_evm snd_soc_tlv320aic3x dwc3 snd_soc_core snd_compress omapdrm snd_pcm_dmaengine snd_pcm snd_timer snd fb_sys_fops lis3lv02d_i2c panel_dpi matrix_keypad lis3lv02d dwc3_omap input_polldev soundcore
> [   47.755668] CPU: 0 PID: 1440 Comm: file-storage Not tainted 3.17.0-02899-ga7d2165 #229
> [   47.763958] task: ed1b22c0 ti: ed20e000 task.ti: ed20e000
> [   47.769609] PC is at find_get_entry+0x64/0x100
> [   47.774281] LR is at 0xfffffffa

What GCC version are you using?

4.8.1 and 4.8.2 are known to miscompile the ARM kernel and these
find_get_entry() crashes with 0xffffffff involved smell a lot like the
earlier reports from kernels build with those compilers:

https://lkml.org/lkml/2014/6/25/456
https://lkml.org/lkml/2014/6/30/375
https://lkml.org/lkml/2014/6/30/660
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
https://lkml.org/lkml/2014/5/9/330
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
