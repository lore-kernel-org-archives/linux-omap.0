From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/3] ocp2scp: add non-dt support
Date: Wed, 7 Nov 2012 10:24:05 -0800
Message-ID: <20121107182405.GH6801@atomide.com>
References: <1351844088-27059-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351844088-27059-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, arnd@arndb.de, olof@lixom.net, rdunlap@xenotime.net, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [121102 01:16]:
> This patch series allows ocp2scp driver to create its child devices
> from the platform data.
> 
> In omap platforms, usb phy is connected to ocp2scp and usb phy is needed
> for MUSB to be functional. When ocp2scp driver was added, it had only dt
> support which means it wont create usb phy devices for non-dt boot.
> 
> This patch series adds non-dt support to ocp2scp and this series is needed
> for getting MUSB functional in non-dt boot.

Thanks I've pushed these into omap-for-v3.7-rc4/musb-regression with
updated description to describe the regression for the -rc cycle.

Regards,

Tony
