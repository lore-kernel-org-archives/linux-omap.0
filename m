From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 0/2] IOMMU fault callback support
Date: Tue, 15 Feb 2011 15:32:24 +0200
Message-ID: <AANLkTinPD_iktt22eY4MPc3uG4CKB+c5A5QSYjFLxHfU@mail.gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50090 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1BONcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 08:32:25 -0500
Received: by wwa36 with SMTP id 36so179683wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 05:32:24 -0800 (PST)
In-Reply-To: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

A missing prefix in the cover letter's subject. It's: OMAP: IOMMU:

Br,

David

On Tue, Feb 15, 2011 at 3:20 PM, David Cohen <dacohen@gmail.com> wrote:
> Hi,
>
> This patch set adds fault callback support to allow IOMMU users to de=
bug or
> react when a fault happens.
> IOMMU faults might be very difficult to reproduce and then to figure =
out
> the source of the problem. Currently IOMMU driver prints not so usefu=
l
> debug message and does not notice user about such issue.
> With a fault callback, IOMMU user may debug much more useful informat=
ion
> and/or react to go back to a valid state.
>
> Br,
>
> David
> ---
>
> David Cohen (2):
> =C2=A0OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
> =C2=A0OMAP: IOMMU: add support to callback during fault handling
>
> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 27 ++++++++++++++++----
> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 15 ++++++++++-
> =C2=A0arch/arm/plat-omap/iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 41 ++++++++++++++++++++++++++++---
> =C2=A03 files changed, 72 insertions(+), 11 deletions(-)
>
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
