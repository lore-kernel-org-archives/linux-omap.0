From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 0/5] usb: musb/otg: cleanup and fixes
Date: Thu, 14 Mar 2013 00:00:16 +0200
Message-ID: <CANOLnOMfZJa=CrCCxnxAGxfXPGhgFwr5Vr-wp0bvfa3dNWATtg@mail.gmail.com>
References: <1363164430-19118-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363164430-19118-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 13, 2013 at 10:47 AM, Kishon Vijay Abraham I <kishon@ti.com=
> wrote:
> This series has some misc cleanup and fixes. The fix solves the cold
> plug issue in omap3 which some have reported. Developed these patches=
 on
> Linux 3.9-rc2 after applying http://www.spinics.net/lists/linux-usb/m=
sg81563.html
> (Grazvydas Ignotas patch series)
>
> Tested for g_zero enumeration in pandaboard and beagleboard in both
> cold plug and hot plug case. Any kind of testing for this series is w=
elcome.
>
> Kishon Vijay Abraham I (5):
>   usb: musb: omap: remove the check before calling otg_set_vbus
>   usb: musb: omap: always glue have the correct vbus/id status
>   usb: otg: twl4030: use devres API for regulator get and request irq
>   usb: musb: omap: add usb_phy_init in omap2430_musb_init
>   usb: otg: twl4030: fix cold plug on OMAP3

Looks and works good for me on pandora.
Tested-by: Grazvydas Ignotas <notasas@gmail.com>

>  drivers/usb/musb/omap2430.c   |   22 ++++++++++------------
>  drivers/usb/otg/twl4030-usb.c |   35 ++++++++++++-------------------=
----
>  2 files changed, 22 insertions(+), 35 deletions(-)
>
> --
> 1.7.10.4
>



--=20
Gra=C5=BEvydas
