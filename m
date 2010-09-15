From: Felipe Balbi <balbi@ti.com>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in
 musb_g_tx
Date: Wed, 15 Sep 2010 13:56:41 +0300
Message-ID: <20100915105641.GO3393@legolas.emea.dhcp.ti.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "Balbi, Felipe" <balbi@ti.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 15, 2010 at 05:53:10AM -0500, Ming Lei wrote:
>1),  why is the check for "is_dma" needed here?
>
>      if (is_dma || request->actual == request->length) {
>           ....
>      }

if you programmed dma to request->length (and assuming it worked just
fine) mode1 will only interrupt you when the entire request has been
sent.

>2), why is a zlp needed in the case below?
>
>      #ifdef CONFIG_USB_INVENTRA_DMA
>                  || (is_dma && (!dma->desired_mode ||
>                     (request->actual & (musb_ep->packet_sz - 1))))
>     #endif

in that case, it's not a zlp, it's short packet. Inventra will *NOT*
transfer short packets, you need to set txpktrdy by hand to get it
transfered.

>IMO, it is not difficult to give a good fix for the ZLP problem
>if the two questions are clear.

true, but some re-work needs to be done.

-- 
balbi
