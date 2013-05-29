From: =?UTF-8?Q?Adrien_Verg=C3=A9?= <adrienverge@gmail.com>
Subject: Re: [PATCH 2/5] USB: ehci-omap: select NOP_USB_XCEIV PHY driver
Date: Wed, 29 May 2013 11:33:05 -0400
Message-ID: <CANsc=4VicTFGLO_zbDDsQam3dKsNNUgvQa=zR_u7beKseWh3UA@mail.gmail.com>
References: <1369827811-534-1-git-send-email-rogerq@ti.com>
	<1369827811-534-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369827811-534-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, kishon@ti.com, arnd@arndb.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2013/5/29 Roger Quadros <rogerq@ti.com>:
> ehci-omap needs NOP_USB_XCEIV PHY driver to function
> properly, so select it. As the USB PHY drivers no longer
> depend on USB_PHY, it is safe to select the PHY drivers.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>

Works well on Pandaboard (OMAP4430).
Thank you!
