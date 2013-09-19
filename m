From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 01/15] phy: rename struct omap_control_usb to struct
 omap_control_phy
Date: Thu, 19 Sep 2013 16:25:30 +0200
Message-ID: <523B095A.9070006@gmail.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379595943-14622-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 19.09.2013 15:05, Roger Quadros wrote:
> From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> 
> Rename struct omap_control_usb to struct omap_control_phy since it can
> be used to control PHY of USB, SATA and PCIE. Also move the driver and
> include files under *phy* and made the corresponding changes in the users
> of phy-omap-control.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/phy/Kconfig                  |   14 ++-
>  drivers/phy/Makefile                 |    1 +
>  drivers/phy/phy-omap-control.c       |  300 ++++++++++++++++++++++++++++++++++
>  drivers/phy/phy-omap-pipe3.c         |    8 +-
>  drivers/phy/phy-omap-usb2.c          |    9 +-
>  drivers/usb/musb/omap2430.c          |    2 +-
>  drivers/usb/phy/Kconfig              |   10 -
>  drivers/usb/phy/Makefile             |    1 -
>  drivers/usb/phy/phy-omap-control.c   |  300 ----------------------------------
>  include/linux/phy/omap_control_phy.h |   83 ++++++++++
>  include/linux/usb/omap_control_usb.h |   83 ----------
>  11 files changed, 406 insertions(+), 405 deletions(-)
>  create mode 100644 drivers/phy/phy-omap-control.c
>  delete mode 100644 drivers/usb/phy/phy-omap-control.c
>  create mode 100644 include/linux/phy/omap_control_phy.h
>  delete mode 100644 include/linux/usb/omap_control_usb.h

In case you do another version of this set, please use "git format-patch
-M", which will detect renames and hence make the review much easier.


Daniel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
