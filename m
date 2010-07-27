From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 0/6] Introducing OMAP Remote Processor module
Date: Tue, 27 Jul 2010 17:57:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2107@dbde02.ent.ti.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46162 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab0G0M1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 08:27:09 -0400
In-Reply-To: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ben-cohen, Ohad" <ohadb@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohen
> Sent: Friday, July 02, 2010 3:53 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ben-cohen, Ohad
> Subject: [RFC 0/6] Introducing OMAP Remote Processor module
> 
> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> This is a preliminary version of OMAP's remoteproc module,
> submitted for RFC purposes.
> 
> The purpose of the remoteproc module is to decouple
> hw-specific code from generic IPC drivers (such as
> dspbridge and syslink), in order to eventually make
> those IPC drivers platform-independent.
> 
> Currently the supported operations are starting and stopping
> the remote processor, but in the future additional functionality
> might be added.
> 
> Both OMAP3 and OMAP4 are supported; OMAP3 supports the dsp
> remote processor, and OMAP4 supports ducati (tesla support
> is planned as well).
> 
> The code was tested on both OMAP3 (using dspbridge) and OMAP4
> (using syslink).
> 
> The code is preliminary: we plan to add much more extensive
> hwmod support, ideally squashing as much hw-specific code
> as possible (including RST and PRCM manipulations).
> In addition, a rebase to recent code bases is needed.
> 
> While dspbridge accesses remoteproc's interface via pdata
> pointers, syslink accesses it from user space, via character
> device interface, so both kernel and user space interfaces
> are supported.
> 
> A few words on the char device interface:
> 
> * Each remote processor is represented by a different
>   character device: /dev/omap-rproc0, /dev/omap-rproc1, ...

[sp] Concept of remote processor is not really tied to omap.
     Though the implementation is being done in context of
     OMAP, I would suggest removing the prefix "omap-" from
     the device name.

> * A rproc character device can only be opened by a single user
>   (e.g. the syslink daemon)
> * The start/stop/get_state functionality is exposed via ioctl's
> * We plan to add automatic stop() invokation in case the user
>   closes the device after starting a remote processor (for
>   resource cleanup purposes. Thus the user will be required
>   to hold the device open as long as it lives).
> 
> Thanks,
> 
> Hari Kanigeri (1):
>   omap: introduce OMAP4 remoteproc module
> 
> Ohad Ben-Cohen (5):
>   omap: add iva2 hwmod support to omap3
>   omap: introduce OMAP3 remoteproc module
>   omap: introduce common remoteproc module
>   omap: add remoteproc device(s)
>   omap: enable remoteproc building
> 
>  arch/arm/mach-omap2/Makefile                 |    6 +
>  arch/arm/mach-omap2/devices.c                |   86 +++++++
>  arch/arm/mach-omap2/omap_hwmod_34xx.h        |   23 ++
>  arch/arm/mach-omap2/remoteproc3xxx.c         |  226 
> ++++++++++++++++++
>  arch/arm/mach-omap2/remoteproc44xx.c         |  196 ++++++++++++++++
>  arch/arm/plat-omap/Kconfig                   |    7 +
>  arch/arm/plat-omap/Makefile                  |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>  arch/arm/plat-omap/include/plat/remoteproc.h |   75 ++++++
>  arch/arm/plat-omap/remoteproc.c              |  316 
> ++++++++++++++++++++++++++
>  10 files changed, 937 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/remoteproc3xxx.c
>  create mode 100644 arch/arm/mach-omap2/remoteproc44xx.c
>  create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
>  create mode 100644 arch/arm/plat-omap/remoteproc.c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 