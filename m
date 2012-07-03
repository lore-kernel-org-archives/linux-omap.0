From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [FYI/RFC] usb: musb: DMA doesn't work with "nop" PHYs
Date: Tue, 3 Jul 2012 12:03:48 +0530
Message-ID: <CAAe_U6+zBUvQV0bDG3cmYzXcxH7NjVye0oe1fM1AtdnG6Wfs0Q@mail.gmail.com>
References: <20120702223837.GA31796@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:59313 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932754Ab2GCGdu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 02:33:50 -0400
Received: by vcbf11 with SMTP id f11so4494880vcb.5
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 23:33:48 -0700 (PDT)
In-Reply-To: <20120702223837.GA31796@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi,

Couple of questions..

On Tue, Jul 3, 2012 at 4:08 AM, Mark A. Greer <mgreer@animalcreek.com> =
wrote:
> [The reason I'm sending this is that there is an issue but I probably
> =A0won't be able to spend much time on it for a while. =A0So, I'm sen=
ding
> =A0it in case a) it helps someone else who bumps into it and b) someo=
ne
> =A0else picks up and completes the fix.]
>
> Hello.
>
> In testing USB OTG Gadget on the am37x EVM with the mainline kernel
> I discovered that DMA doesn't work (but PIO does). =A0When I tested
> the same kernel on the BeagleBoard-xM (BBxM), which has essentially
> the same SoC, it worked fine. =A0They do have different OTG PHYs, tho=
ugh.
> The am37x EVM uses an ISP 1507 and the BBxM uses the PHY on the
> TPS65950 (twl4030). =A0The different PHYs means that they use differe=
nt
> drivers in drivers/usb/otg. =A0The am37x EVM uses nop-usb-xceiv.c and
> the BBxM uses twl4030-usb.c.

Where does the comparator (VBUS) exist in am37x? Who will be first
interrupted when a cable is connected?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
