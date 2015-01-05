From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] soc: ti: Add wkup_m3_ipc driver
Date: Mon, 5 Jan 2015 14:51:35 -0800
Message-ID: <20150105225134.GN4081@atomide.com>
References: <1420228817-41310-1-git-send-email-d-gerlach@ti.com>
 <1420228817-41310-3-git-send-email-d-gerlach@ti.com>
 <20150102201643.GE4920@saruman>
 <54AB14E4.2010607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54AB14E4.2010607-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [150105 14:51]:
> Felipe,
> On 01/02/2015 02:16 PM, Felipe Balbi wrote:
> > On Fri, Jan 02, 2015 at 02:00:16PM -0600, Dave Gerlach wrote:
> >> Introduce a wkup_m3_ipc driver to handle communication between the MPU
> >> and Cortex M3 wkup_m3 present on am335x.
> >>
> >> This driver is responsible for actually booting the wkup_m3_rproc and
> >> also handling all IPC which is done using the IPC registers in the control
> >> module, a mailbox, and a separate interrupt back from the wkup_m3. A small
> >> API is exposed for executing specific power commands, which include
> >> configuring for low power mode, request a transition to a low power mode,
> >> and status info on a previous transition.
> >>
> >> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  drivers/soc/ti/Kconfig       |  11 ++
> >>  drivers/soc/ti/Makefile      |   1 +
> >>  drivers/soc/ti/wkup_m3_ipc.c | 451 +++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/wkup_m3_ipc.h  |  33 ++++
> >>  4 files changed, 496 insertions(+)
> >>  create mode 100644 drivers/soc/ti/wkup_m3_ipc.c
> >>  create mode 100644 include/linux/wkup_m3_ipc.h
> >>
> >> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> >> index 7266b21..61cda85 100644
> >> --- a/drivers/soc/ti/Kconfig
> >> +++ b/drivers/soc/ti/Kconfig
> >> @@ -28,4 +28,15 @@ config KEYSTONE_NAVIGATOR_DMA
> >>  
> >>  	  If unsure, say N.
> >>  
> >> +config WKUP_M3_IPC
> >> +	bool "TI AM33XX Wkup-M3 IPC Driver"
> > 
> > tristate ?
> 
> If we want to allow this and the rproc driver to be built as modules than we can
> change this.

Yes please, the PM is never needed early, and should be optional.
And doing that will make it a lot easier for you to do further work
on your driver ;)

And it will also make it easier to add support for other SoCs as
it seems the same M3 is used at least on am437x.
 
> > 
> >> +	depends on WKUP_M3_RPROC
> >> +	select MAILBOX
> >> +	select OMAP2PLUS_MBOX
> > 
> > selects are usually frowned upon.
> 
> Followed example set by OMAP_REMOTEPROC which selects the mailbox, thought that
> would be alright.

The select should be only done if the option selected is a silen
Kconfig option where it's never selectable by the user. Otherwise
you will errors sooner or later with make randconfig builds as the
dependencies change. Using depends on is better for those cases.

Regards,

Tony 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
