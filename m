From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Problems with USB Gadget on the OMAP3EVM
Date: Wed, 6 Aug 2008 12:21:27 +0300
Message-ID: <20080806092127.GD30719@gandalf.research.nokia.com>
References: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com> <20080805112736.GZ30539@gandalf.research.nokia.com> <ece1079f0808052212r6f4b2830i2ace5e66263998dd@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB02569B8CA0@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49356 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYHFJVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 05:21:50 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8CA0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: kanagesh radhakrishnan <rkanagesh@gmail.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Aug 06, 2008 at 01:27:40PM +0530, ext Gadiyar, Anand wrote:
> > >  Also increase MUSB_LOGLEVEL to 3 in your .config file and reabuild that
> > >  2.6.22.18 kernel.
> > >
> 
> Don't bother re-building the kernel. You could just do an
>         "echo D3 > /proc/driver/musb_hdrc"
> or even D5 for more detail. If low-level debug is not enabled, you can
>         "echo 8 > /proc/sys/kernel/printk"
> and you should be able to see the debug prints.
> 
> Those might be useful. This should work on the linux-omap kernel as well.
> 
> By the way, does g_file_storage work on this board?

Didn't know you guys had that on your tree as well. Good to know :-)

-- 
balbi
