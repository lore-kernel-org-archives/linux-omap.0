From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v3 0/2] OMAP: omap_device: API to modify SYSCONFIG register
Date: Fri, 8 Jul 2011 18:51:38 +0530
Message-ID: <CAAe_U6+rRLSm6My1SWHt=Fc1MZjN_0bvsWvpZeqNG6c48nsHzA@mail.gmail.com>
References: <1309777713-17528-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51689 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553Ab1GHNVj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jul 2011 09:21:39 -0400
In-Reply-To: <1309777713-17528-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, vishwanath.bs@ti.com, p-basak2@ti.com, peter.ujfalusi@ti.com, jhnikula@gmail.com, kishon@ti.com, charu@ti.com

Paul, Benoit,

Do you have any comments for this series?

Regards
Kishon

On Mon, Jul 4, 2011 at 4:38 PM, Kishon Vijay Abraham I <kishon@ti.com> =
wrote:
> Certain peripherals require autoidle bits to be disabled before perfo=
rming
> some operations. This patch series provides APIs in omap_device layer=
 and
> omap_hwmod layer to modify the SYSCONFIG register.
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
> commit-id: d9be6df1331f8078618745298d38ed619729ec91
> Tested on OMAP4430 and OMAP3430 SDP boards. Verified that this patch
> series does not break the OMAP1 build.
>
> V3:
> created one-one mapping between omap_device APIs and omap_hwmod APIs =
to
> modify the sysconfig register.
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
> [1]: http://www.mail-archive.com/linux-omap <at> vger.kernel.org/msg3=
9647.html
> [2]: https://patchwork.kernel.org/patch/134371/
> [3]: http://www.mail-archive.com/linux-omap <at> vger.kernel.org/msg3=
9615.html
>
> Kishon Vijay Abraham I (2):
> =A0OMAP: omap_hwmod: API to modify AUTOIDLE and SMARTIDLE bits
> =A0OMAP: omap_device: API to modify AUTOIDLE and SMARTIDLE bits
>
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
93 ++++++++++++++
> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A06 +
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 11 ++
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A01=
65 +++++++++++++++++++++++++
> =A04 files changed, 275 insertions(+), 0 deletions(-)
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
