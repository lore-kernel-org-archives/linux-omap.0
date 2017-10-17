From: Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 34/43]
 drivers/usb/mtu3/mtu3_qmu.c:261:2: note: in expansion of macro 'dev_dbg'
Date: Tue, 17 Oct 2017 17:47:09 +0800
Message-ID: <1508233629.17567.79.camel@mhfsdcap03>
References: <201710171728.UXKlCAtU%fengguang.wu@intel.com>
         <87infejes0.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87infejes0.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2017-10-17 at 12:37 +0300, Felipe Balbi wrote:
> Hi,
> 
> kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
> > head:   39325b9a22301178ef684effade7c8bce04b5246
> > commit: 8706b37e87e58cd4d4dea593767d34447321610a [34/43] usb: mtu3: support 36-bit DMA address
> > config: xtensa-allyesconfig (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 4.9.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 8706b37e87e58cd4d4dea593767d34447321610a
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=xtensa 
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/printk.h:329:0,
> >                     from include/linux/kernel.h:13,
> >                     from include/asm-generic/bug.h:15,
> >                     from ./arch/xtensa/include/generated/asm/bug.h:1,
> >                     from include/linux/bug.h:4,
> >                     from include/linux/scatterlist.h:6,
> >                     from include/linux/dmapool.h:14,
> >                     from drivers/usb/mtu3/mtu3_qmu.c:30:
> >    drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_tx_gpd':
> >    include/linux/dynamic_debug.h:74:16: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
> >      static struct _ddebug  __aligned(8)   \
> >                    ^
> >    include/linux/dynamic_debug.h:110:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_KEY'
> >      DEFINE_DYNAMIC_DEBUG_METADATA_KEY(name, fmt, 0, 0)
> >      ^
> >    include/linux/dynamic_debug.h:132:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
> >      DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
> >      ^
> >    include/linux/device.h:1351:2: note: in expansion of macro 'dynamic_dev_dbg'
> >      dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
> >      ^
> >>> drivers/usb/mtu3/mtu3_qmu.c:261:2: note: in expansion of macro 'dev_dbg'
> >      dev_dbg(mep->mtu->dev, "TX-EP%d queue gpd=%p, enq=%p, qdma=%llx\n",
> >      ^
> 
> fixed it myself. Changed to %pad.
Thank you
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
