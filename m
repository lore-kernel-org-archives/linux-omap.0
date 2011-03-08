From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v2 0/3] *** SUBJECT HERE ***
Date: Tue, 8 Mar 2011 22:09:46 +0200
Message-ID: <AANLkTi=6kaSNQ1YUJ3SGQ+izttfs+yec8UpXtbNancQ5@mail.gmail.com>
References: <1299614690-15100-1-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35052 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1CHUJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 15:09:47 -0500
In-Reply-To: <1299614690-15100-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, fernando.lugo@ti.com, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com, David Cohen <dacohen@gmail.com>

On Tue, Mar 8, 2011 at 10:04 PM, David Cohen <dacohen@gmail.com> wrote:
> *** BLURB HERE ***

Sorry for this garbage :/

Br,

David

>
> David Cohen (2):
> =C2=A0omap3: change ISP's IOMMU da_start address
> =C2=A0omap: iovmm: don't check 'da' to set IOVMF_DA_FIXED flag
>
> Michael Jones (1):
> =C2=A0omap: iovmm: disallow mapping NULL address
>
> =C2=A0arch/arm/mach-omap2/omap-iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A02 +-
> =C2=A0arch/arm/plat-omap/include/plat/iovmm.h | =C2=A0 =C2=A02 --
> =C2=A0arch/arm/plat-omap/iovmm.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 30 +++++++++++++++---------------
> =C2=A03 files changed, 16 insertions(+), 18 deletions(-)
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
