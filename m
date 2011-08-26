From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 0/7] omap: iommu migration, relocation and cleanups
Date: Fri, 26 Aug 2011 15:21:14 +0300
Message-ID: <CAK=WgbbvOf-3C8HtoZwV9nDomjPHVsEr+ztcMxf4tV=4KDXZ7g@mail.gmail.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com> <20110826112531.GQ1923@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:39539 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab1HZMW2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 08:22:28 -0400
Received: by wwe5 with SMTP id 5so424009wwe.1
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 05:22:27 -0700 (PDT)
In-Reply-To: <20110826112531.GQ1923@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Fri, Aug 26, 2011 at 2:25 PM, Roedel, Joerg <Joerg.Roedel@amd.com> w=
rote:
> Applied all to arm/omap, thanks Ohad. I also put a commit on-top whic=
h
> finished the mutex->spin_lock conversion. Looks like one call-place w=
as
> missed. See attached patch.
>
> commit 4234541f1a64d9dc6d489cf8f614dc01c62360f6
> Author: Joerg Roedel <joerg.roedel@amd.com>
> Date: =A0 Fri Aug 26 13:20:06 2011 +0200
>
> =A0 =A0omap: iommu: Fix up mutex->spin_lock conversion of iommu_lock
>
> =A0 =A0The omap_iommu_set_isr() was still using the mutex functions

Thanks, Joerg.

(I am already working on removing omap_iommu_set_isr() and providing
that functionality via the IOMMU API, so the s/mutex/spinlock/ patch I
squashed with the original patch set accidentally didn't cover that
function).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
