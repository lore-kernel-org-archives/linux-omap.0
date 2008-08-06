From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Problems with USB Gadget on the OMAP3EVM
Date: Wed, 6 Aug 2008 13:27:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8CA0@dbde02.ent.ti.com>
References: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
	 <20080805112736.GZ30539@gandalf.research.nokia.com>
 <ece1079f0808052212r6f4b2830i2ace5e66263998dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193AbYHFIF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 04:05:27 -0400
In-Reply-To: <ece1079f0808052212r6f4b2830i2ace5e66263998dd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kanagesh radhakrishnan <rkanagesh@gmail.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> >  Also increase MUSB_LOGLEVEL to 3 in your .config file and reabuild that
> >  2.6.22.18 kernel.
> >

Don't bother re-building the kernel. You could just do an
        "echo D3 > /proc/driver/musb_hdrc"
or even D5 for more detail. If low-level debug is not enabled, you can
        "echo 8 > /proc/sys/kernel/printk"
and you should be able to see the debug prints.

Those might be useful. This should work on the linux-omap kernel as well.

By the way, does g_file_storage work on this board?

- Anand


> Hello everyone,
>
> Thank you very much for the comments and suggestions.
>
> The version of Linux kernel on the native host Fedora Core 5 machine
> is the default 2.6.9-1.667 kernel that comes with the FC5 release.
> Keeping in mind where we are, this does sound like an ancient kernel.
> However, I have USB networking with Gadget drivers working on this
> same machine with OMAP5912 OSK, OMAP2430 SDP and another custom
> OMAP2430 based board.
>
> Nevertheless, I decided to upgrade to a more recent version of the
> Linux kernel on the host system.  I will test the setup once again and
> update the observation.
>
> Meanwhile, I tested the setup with a Windows XP host machine and these
> are the observations:
> On insertion of the USB cable to the Win XP host machine, the OMAP3EVM
> board gets detected as 'RNDIS/Ethernet' Device.  I go through the
> driver installation (driver used is file Documentation/usb/linux.inf
> from the standard Linux kernel sources).  After the installation is
> complete, I get an error from the Windows XP system saying "An error
> was encountered while installing the driver and the hardware might not
> function as intended"
>
> Thank you all,
> Regards,
> Kanagesh
