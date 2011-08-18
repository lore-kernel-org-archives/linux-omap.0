From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] mfd: omap-usb-host: Make TLL mode work again
Date: Thu, 18 Aug 2011 16:52:22 +0530
Message-ID: <CAP05o4J01FpphHgV5tpkFGNfTBbjhtScKjWZm4iLi3H1V=EKDQ@mail.gmail.com>
References: <1313664271-694-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313664271-694-1-git-send-email-gadiyar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 18, 2011 at 4:14 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> This code section seems to have been accidentally copy pasted.
> It causes incorrect bits to be set up in the TLL_CHANNEL_CONF
> register and prevents the TLL mode from working correctly.
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Keshava Munegowda <keshava_mgowda@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> Against v3.1-rc2; tested against linux-next as of 20110817 as well.
>
> This probably needs to go to -stable as well. The original code
> by me worked fine but this was broken during the code reorganization
> Keshava did.
>
> =A0drivers/mfd/omap-usb-host.c | =A0 =A01 -
> =A01 file changed, 1 deletion(-)
>
> Index: linux-2.6/drivers/mfd/omap-usb-host.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/mfd/omap-usb-host.c
> +++ linux-2.6/drivers/mfd/omap-usb-host.c
> @@ -676,7 +676,6 @@ static void usbhs_omap_tll_init(struct d
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| OMAP=
_TLL_CHANNEL_CONF_ULPINOBITSTUFF
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| OMAP=
_TLL_CHANNEL_CONF_ULPIDDRMODE);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (1 << (i + 1))=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;

Samuel Ortiz and balbi
please ack this patch

I am going to re-base runtime pm patches on top of this patch.


Regards
keshava
