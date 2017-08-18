From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [balbi-usb:testing/next 48/49]
 drivers/usb//gadget/function/u_serial.c:540:19: error: invalid operands to
 binary & (have 'unsigned int' and 'struct tty_struct *')
Date: Fri, 18 Aug 2017 16:10:47 +0000
Message-ID: <31ad87c0ef114d2893eed54b93f62108@HQMAIL107.nvidia.com>
References: <201708181625.uPy8R6nk%fengguang.wu@intel.com>
 <87d17tql3l.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87d17tql3l.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote at Friday, August 18, 2017 3:30 AM:
> Hi,
> 
> kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
> > head:   862b43460309779e5814616a68aa36d29a70d6e0
> > commit: 2b4e4d3c929db0fc7cf99212bfac0570b6902c14 [48/49] usb: gadget: serial: fix oops when data rx'd after close
> > config: xtensa-allmodconfig (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 4.9.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 2b4e4d3c929db0fc7cf99212bfac0570b6902c14
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=xtensa
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/usb//gadget/function/u_serial.c: In function 'gs_rx_push':
> >>> drivers/usb//gadget/function/u_serial.c:540:19: error: invalid operands to binary & (have 'unsigned int' and 'struct tty_struct *')
> >       if (req->actual & tty) {
> 
> fixed locally.

Sorry about that, and thanks for fixing it. When I moved this between kernel
trees I re-implemented it since it was so trivial, rather than copying the
patch via git mechanisms. That's obviously a very bad idea:-(

-- 
nvpublic
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
