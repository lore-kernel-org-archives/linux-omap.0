From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 0/6] Introducing OMAP Remote Processor module
Date: Tue, 27 Jul 2010 20:09:20 +0300
Message-ID: <AANLkTimEVTBP_j4EYG1Q4Utaz0OKdxbkx2BgSMHGRi6D@mail.gmail.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7DA2107@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37253 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0G0RJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 13:09:42 -0400
Received: by wyf19 with SMTP id 19so3281297wyf.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Jul 2010 10:09:41 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2107@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Sanjeev,

Thanks for your comments.

As we plan to move remoteproc to hwmod, the code will be substantially =
changed.

We will keep your comments in mind, and also keep in mind other TI
platforms (like davinci).

Thanks,
Ohad.

On Tue, Jul 27, 2010 at 3:27 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohe=
n
>> Sent: Friday, July 02, 2010 3:53 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Kanigeri, Hari; Ben-cohen, Ohad
>> Subject: [RFC 0/6] Introducing OMAP Remote Processor module
>>
>> From: Ohad Ben-Cohen <ohadb@ti.com>
>>
>> This is a preliminary version of OMAP's remoteproc module,
>> submitted for RFC purposes.
>>
>> The purpose of the remoteproc module is to decouple
>> hw-specific code from generic IPC drivers (such as
>> dspbridge and syslink), in order to eventually make
>> those IPC drivers platform-independent.
>>
>> Currently the supported operations are starting and stopping
>> the remote processor, but in the future additional functionality
>> might be added.
>>
>> Both OMAP3 and OMAP4 are supported; OMAP3 supports the dsp
>> remote processor, and OMAP4 supports ducati (tesla support
>> is planned as well).
>>
>> The code was tested on both OMAP3 (using dspbridge) and OMAP4
>> (using syslink).
>>
>> The code is preliminary: we plan to add much more extensive
>> hwmod support, ideally squashing as much hw-specific code
>> as possible (including RST and PRCM manipulations).
>> In addition, a rebase to recent code bases is needed.
>>
>> While dspbridge accesses remoteproc's interface via pdata
>> pointers, syslink accesses it from user space, via character
>> device interface, so both kernel and user space interfaces
>> are supported.
>>
>> A few words on the char device interface:
>>
>> * Each remote processor is represented by a different
>> =A0 character device: /dev/omap-rproc0, /dev/omap-rproc1, ...
>
> [sp] Concept of remote processor is not really tied to omap.
> =A0 =A0 Though the implementation is being done in context of
> =A0 =A0 OMAP, I would suggest removing the prefix "omap-" from
> =A0 =A0 the device name.
>
>> * A rproc character device can only be opened by a single user
>> =A0 (e.g. the syslink daemon)
>> * The start/stop/get_state functionality is exposed via ioctl's
>> * We plan to add automatic stop() invokation in case the user
>> =A0 closes the device after starting a remote processor (for
>> =A0 resource cleanup purposes. Thus the user will be required
>> =A0 to hold the device open as long as it lives).
>>
>> Thanks,
>>
>> Hari Kanigeri (1):
>> =A0 omap: introduce OMAP4 remoteproc module
>>
>> Ohad Ben-Cohen (5):
>> =A0 omap: add iva2 hwmod support to omap3
>> =A0 omap: introduce OMAP3 remoteproc module
>> =A0 omap: introduce common remoteproc module
>> =A0 omap: add remoteproc device(s)
>> =A0 omap: enable remoteproc building
>>
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06 +
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 86 +++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_34xx.h =A0 =A0 =A0 =A0| =A0 23 ++
>> =A0arch/arm/mach-omap2/remoteproc3xxx.c =A0 =A0 =A0 =A0 | =A0226
>> ++++++++++++++++++
>> =A0arch/arm/mach-omap2/remoteproc44xx.c =A0 =A0 =A0 =A0 | =A0196 +++=
+++++++++++++
>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A07 +
>> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A01 +
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
>> =A0arch/arm/plat-omap/include/plat/remoteproc.h | =A0 75 ++++++
>> =A0arch/arm/plat-omap/remoteproc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A03=
16
>> ++++++++++++++++++++++++++
>> =A010 files changed, 937 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/remoteproc3xxx.c
>> =A0create mode 100644 arch/arm/mach-omap2/remoteproc44xx.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
>> =A0create mode 100644 arch/arm/plat-omap/remoteproc.c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
