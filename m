From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v2 0/2] OMAP: omap_device: API to modify SYSCONFIG register
Date: Tue, 15 Feb 2011 12:08:38 +0530
Message-ID: <AANLkTin0kLETwO1MfYLqAoMxfs876mzvvV-HPQz=is1s@mail.gmail.com>
References: <1296477288-26253-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38606 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751005Ab1BOGij convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 01:38:39 -0500
Received: by gyd8 with SMTP id 8so2392891gyd.6
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 22:38:38 -0800 (PST)
In-Reply-To: <1296477288-26253-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com
Cc: charu@ti.com, shubhrajyoti@ti.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Kevin, Paul, Benoit,

Do you have any comments for this patch series?

-Kishon

On Mon, Jan 31, 2011 at 6:04 PM, Kishon Vijay Abraham I <kishon@ti.com>=
 wrote:
> Certain peripherals require autoidle bits to be disabled before perfo=
rming
> some operations. This patch series provides APIs in omap_device layer=
 to
> modify the SYSCONFIG register.
>
> Since current implementation of PM run time framework does not suppor=
t
> changing sysconfig settings during middle of the on going operation,
> these APIs will support the same.
>
> For e.g McBSP 2 and 3 in OMAP3 has sidetone feature which requires
> autoidle to be disabled before starting the sidetone.
>
> McBSP also requires the SYSCONFIG to be in NOIDLE when ELEMENTSYNCH
> mode is selected for DMA operation.
>
> Created on top of linux OMAP master (linux-omap-2.6 :master)
> Tested on OMAP4430, OMAP3430 and OMAP2430 SDP boards. Verified that t=
his patch
> series does not break the OMAP1 build.
>
> V2:
> Mutex is replaced with spinlock.
>
> V1:
> * Creates 3 separate API's to change the idle mode to NOIDLE, SMARTID=
LE
> =A0and FORCEIDLE and one more API to change the idlemode to default v=
alue
> =A0based on the hwmod flag. This change is done to align with the dis=
cussion
> =A0on [3]
>
> * Added hwmod mutex in omap hwmod APIs that modifies SYSCONFIG regist=
er.
>
> * omap_hwmod_set_slave_idlemode() is not modified to take true/false =
kind-of
> argument since 3 states are associated with SIDLE bits (force, no and=
 smart).
>
> These changes were made to align with Benoit's and Paul's comments fo=
r a
> similar patch written by Manjunath [1] for changing MSTANDBY bits.
>
> The discussions that happened for the RFC patch can be found at [2]
>
> [1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39647.=
html
> [2]: https://patchwork.kernel.org/patch/134371/
> [3]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39615.=
html
>
> Kishon Vijay Abraham I (2):
> =A0OMAP: hwmod: API to handle autoidle mode
> =A0OMAP: omap_device: API to modify AUTOIDLE and SMARTIDLE bits
>
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
36 +++++
> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A06 +
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A01 +
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A01=
76 +++++++++++++++++++++++++
> =A04 files changed, 219 insertions(+), 0 deletions(-)
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
