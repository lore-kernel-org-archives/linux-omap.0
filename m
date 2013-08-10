From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 0/4] Add phy support for AM335X platform using Generic
 PHy framework
Date: Sat, 10 Aug 2013 08:59:38 -0300
Message-ID: <20130810115936.GA2365@localhost>
References: <1374237277-17769-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374237277-17769-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: linux-usb@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, kishon@ti.com, bigeasy@linutronix.de
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 19, 2013 at 06:04:33PM +0530, George Cherian wrote:
> This patch series adds phy support for AM335X platform.
> This patch series is based on Generic PHY framework [1].
>=20
>=20
> This series has
>         - adds dual musb instances support for am335x platform=20
>         - adds phy-amxxxx-usb driver used in AMxxxx platforms
> 	- adds OTG callbacks
> 	- adds PHY wakeup enable/disable
>         - adds dt  bindings for the phys
>         - removes usb-phy and replaced with generic phy apis in glue =
layer
>=20
> All these changes are avilable at [2]
>=20
> [1] - http://marc.info/?l=3Dlinux-usb&m=3D137224750928570&w=3D2
> [2] - git://git.ti.com/~georgecherian/ti-linux-kernel/georgec-connect=
ivity-linux-feature-tree.git
>         am335x-phy-driver-v2
>=20
> George Cherian (4):
>   usb: phy: phy-omap-control: Add API to power and wakeup
>   phy: phy-amxxxx-usb: Add PHY driver for amxxxx platform
>   arm: dts: Add USB phy nodes for AM33XX

Is there any reason why there's no DT binding patch to this
series? (aka Documentation/devicetree/... + sent to devicetree list)

(sorry if this has been already explained somewhere...)

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
