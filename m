From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/4] power: isp1704_charger: Fix driver to work with
 changes introduced in v3.5
Date: Tue, 22 Oct 2013 14:03:38 -0700
Message-ID: <20131022210337.GA6148@teo>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378630239-10006-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

On Sun, Sep 08, 2013 at 10:50:37AM +0200, Pali Roh=C3=A1r wrote:
> * omap musb driver does not report USB_EVENT_ENUMERATED event anymore
> * omap musb driver reporting USB_EVENT_VBUS when charger is connected
> * read last event from phy->last_event (instead from ulpi register)
> * do not call wall charger detection more times
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Applied, thanks a lot!

(Per others' review comments I am assuming that the second isp1704 patc=
h
will be reworked to support device-tree, so I am not applying it.)

Thanks,

Anton
