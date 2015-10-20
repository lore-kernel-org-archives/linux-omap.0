From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] soc: ti: Introduce wkup_m3_ipc driver
Date: Tue, 20 Oct 2015 09:18:43 -0700
Message-ID: <20151020161843.GE3078@atomide.com>
References: <1442967294-23837-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442967294-23837-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Keerty J <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [150922 17:20]:
> Hi,
> This series is version 3 of the code to introduce a wkup_m3_ipc driver
> to handle communication between the MPU and Cortex M3 present on TI AM335x
> and AM437x SoCs. v2 of this series can be found at [1]. Only patch 3
> has been changed based on a request from Tony and a few cleanups:
> 
> - Rather than exporting all of the functionality of the driver, added
>   wkup_m3_ipc_get and wkup_m3_ipc_put to allow users to just get a handle
>   containing an ops structure for use.
> 
> - Changed all ops (previously exported functions) to take pointer to
>   struct wkup_m3_ipc as an argument now that user code will get this
>   from wkup_m3_ipc_get.
> 
> - General cleanup to probe function
> 
> - Added MODULE_DEVICE_TABLE so driver can probe automatically.
> 
> The series containing the DT nodes can be found here [2]. The actual dt
> nodes for wkup_m3_ipc (last two patches) have been merged but discussion
> is still open for the ti,mbox-send-noirq flag patches and depends on the
> comments provided for the omap-mailbox change presented in patch 1 of
> this series.
> 
> A full branch containing all necessary PM code for both am335x and am437x
> has been pushed here [3] to provide a big picture view of the plan for
> this series.
> 
> This driver relies on the firmware at [4] in the next-upstream branch
> being present in /lib/firmware in the rootfs or built in to the kernel.

Anybody got comments on this one? Should I pick up this series or
what's the plan?

Regards,

Tony


> [1] https://lkml.org/lkml/2015/7/17/797
> [2] https://lkml.org/lkml/2015/7/17/813
> [3] https://github.com/dgerlach/linux-pm/tree/pm-v4.3-rc1-amx3-suspend
> [4] https://git.ti.com/ti-cm3-pm-firmware
> 
> Dave Gerlach (3):
>   mailbox/omap: Add ti,mbox-send-noirq quirk to fix AM33xx CPU Idle
>   Documentation: dt: add bindings for TI Wakeup M3 IPC device
>   soc: ti: Add wkup_m3_ipc driver
> 
>  .../devicetree/bindings/mailbox/omap-mailbox.txt   |   8 +
>  .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt     |  57 +++
>  drivers/mailbox/omap-mailbox.c                     |  49 +-
>  drivers/soc/ti/Kconfig                             |  10 +
>  drivers/soc/ti/Makefile                            |   1 +
>  drivers/soc/ti/wkup_m3_ipc.c                       | 508 +++++++++++++++++++++
>  include/linux/wkup_m3_ipc.h                        |  55 +++
>  7 files changed, 684 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
>  create mode 100644 drivers/soc/ti/wkup_m3_ipc.c
>  create mode 100644 include/linux/wkup_m3_ipc.h
> 
> -- 
> 2.4.6
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
