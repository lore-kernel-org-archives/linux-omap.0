From: Felipe Balbi <balbi@ti.com>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in
 musb_g_tx
Date: Wed, 15 Sep 2010 14:07:45 +0300
Message-ID: <20100915110745.GP3393@legolas.emea.dhcp.ti.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
 <20100915105641.GO3393@legolas.emea.dhcp.ti.com>
 <AANLkTi=gYSsxSHqAur+isj_UinVLC-YWkdmi5j_vkSUV@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=gYSsxSHqAur+isj_UinVLC-YWkdmi5j_vkSUV@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 15, 2010 at 06:02:22AM -0500, Ming Lei wrote:
>If so, once the dma interrupt comes, will request->actual be same
>with request->length in musb_g_tx?  And if it is true, could we remove the
>check for 'is_dma'?

see that is_dma is set to true by just checking if dma in enabled in
txcsr, it might be that dma didn't complete everything and you need to
write txpktrdy by hand to send last short packet. So to remove that you
would need to re-work a bit more code.

You need to know when this is a dma IRQ or an endpoint IRQ.

-- 
balbi
