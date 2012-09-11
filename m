From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] arm/dts: omap: Add omap-usb2 dt data
Date: Tue, 11 Sep 2012 14:20:11 +0530
Message-ID: <CAAe_U6+8MAUAZgLZq8+Yc6SxOCJ0xQ4NFO-R4p2kgiSOXHZL2w@mail.gmail.com>
References: <1347343932-3656-1-git-send-email-kishon@ti.com>
	<504EF4FD.2080001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <504EF4FD.2080001-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 11, 2012 at 1:53 PM, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org> wrote:
> Hi Kishon,
>
> On 09/11/2012 08:12 AM, Kishon Vijay Abraham I wrote:
>> Add omap-usb2 data node in omap4 device tree file. Since omap-usb2 is
>> connected to ocp2scp, omap-usb2 dt data is added as a child node
>> of ocp2scp.
>
> Could you add more details about the omap-usb2?
I think information about omap-usb2 driver is added in
 *usb: phy: add a new driver for omap usb2 phy.*.
Do you want the same thing to be added here?
>
> You must update the Documentation binding with that compatible name.
Yes. It's part of *usb: phy: add a new driver for omap usb2 phy.*
> Is it already part of the driver serie? The MUSB driver is referring to
> "ti,musb-omap2430" only.

Will correct the Documentation for MUSB.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
