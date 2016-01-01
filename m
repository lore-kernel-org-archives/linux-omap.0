From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: musb module names in 4.4.0-rc7
Date: Fri, 1 Jan 2016 06:15:36 +0100
Message-ID: <56860B78.6040802@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

Using the openSUSE kernel config [1] I've noticed the following modules
get built for recent RCs:

/lib/modules/4.4.0-rc7-1.g276c9f4-lpae/kernel/drivers/usb/musb> ls
am35x.ko  musb_am335x.ko  musb_dsps.ko  musb_hdrc.ko  omap2430.ko  sunx=
i.ko

In my case I was testing on a sun9i based Optimus Board and needed to
specify "sunxi" as driver for dracut to add to my initrd for USB root.
Shouldn't that rather be "musb_sunxi" for module name uniqueness?

Same issue with am35x and omap2430 above, I guess.

Cheers and Happy New Year,
Andreas

[1] http://kernel.opensuse.org/cgit/kernel-source/tree/config/armv7hl

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton; HRB 21284 (AG=
 N=C3=BCrnberg)
