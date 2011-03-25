From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while
 arch_iommu is in use
Date: Fri, 25 Mar 2011 17:44:38 +0200
Message-ID: <BANLkTi=Ncc5anUOB-yaAdX01UnwJ0ThPtQ@mail.gmail.com>
References: <4D8CB217.1050909@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58654 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab1CYPok convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 11:44:40 -0400
Received: by iwn34 with SMTP id 34so1180981iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:44:39 -0700 (PDT)
In-Reply-To: <4D8CB217.1050909@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Cohen David Abraham <david.cohen@nokia.com>

On Fri, Mar 25, 2011 at 5:17 PM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Hi,

Hi Sakari,

>
> [Resend: the patches were accidentally sent to linux-media instead.
> Apologies.]
>
> This patchset is aimed to fix a problem in arch_iommu implementation
> references. When an actual arch_iommu implementation is not loaded wh=
ile
> iommu_get() is being called results to a kernel oops, as well as
> removing an arch_iommu implementation which is in use.
>
> This patchset fixes both issues.

Sounds nice.

>
> The patchset assumes the arch_iommu is uninstalled at module unload
> time. Is this an acceptable requirement?

I can't see a reason why this assumption could be wrong. In my point
of view it's acceptable. Let's see Hiroshi's.

Regards,

David Cohen

>
> Serialisation of the access to arch_iommu is done using mutex called
> arch_iommu_mutex.
>
> module_put() doesn't need to have the arch_iommu_mutex since when thi=
s
> gets called there won't be any users on the arch_iommu anyway.
>
> Comments are welcome. :-)
>
> Cheers,
>
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com
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
