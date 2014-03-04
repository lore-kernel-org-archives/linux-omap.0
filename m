From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 01/12] phy: rename struct omap_control_usb to struct
 omap_control_phy
Date: Tue, 4 Mar 2014 14:56:54 +0530
Message-ID: <53159C5E.2040701@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
 <1393859254-10937-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393859254-10937-2-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, balajitk@ti.com, linux-ide@vger.kernel.org, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Roger,

On Monday 03 March 2014 08:37 PM, Roger Quadros wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
>
> Rename struct omap_control_usb to struct omap_control_phy since it can
> be used to control PHY of USB, SATA and PCIE. Also move the driver and
> include files under *phy* and made the corresponding changes in the users
> of phy-omap-control.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/phy/Kconfig                  |  14 +-
>   drivers/phy/Makefile                 |   1 +
>   drivers/phy/phy-omap-control.c       | 320 +++++++++++++++++++++++++++++++++++
>   drivers/phy/phy-omap-usb2.c          |   8 +-
>   drivers/phy/phy-ti-pipe3.c           |   8 +-
>   drivers/usb/musb/omap2430.c          |   2 +-
>   drivers/usb/phy/Kconfig              |  10 --
>   drivers/usb/phy/Makefile             |   1 -
>   drivers/usb/phy/phy-omap-control.c   | 319 ----------------------------------
>   include/linux/phy/omap_control_phy.h |  89 ++++++++++
>   include/linux/usb/omap_control_usb.h |  89 ----------
>   11 files changed, 431 insertions(+), 430 deletions(-)
>   create mode 100644 drivers/phy/phy-omap-control.c
>   delete mode 100644 drivers/usb/phy/phy-omap-control.c
>   create mode 100644 include/linux/phy/omap_control_phy.h
>   delete mode 100644 include/linux/usb/omap_control_usb.h

you can use git format-patch -M if a file is moved from one place to 
another. The diff count will be less in that case and reviewing will be 
easier ;-)

Cheers
Kishon
