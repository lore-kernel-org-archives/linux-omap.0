From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 6/7] omap: iommu: remove unused exported API
Date: Thu, 18 Aug 2011 16:40:38 +0300
Message-ID: <CAPqfFkAvk92oK-7jhbVZk9zSR7Q1w1CiPLO1PL8xq3E0n1rz-g@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-7-git-send-email-ohad@wizery.com>
	<20110818.134947.522985871882962246.Hiroshi.DOYU@nokia.com>
	<CAK=Wgba0_4W=vODss4+ZKE=PQL266+W0+vb3MiwsTqQH4_1_LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35644 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1HRNkj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 09:40:39 -0400
Received: by gya6 with SMTP id 6so1464768gya.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 06:40:38 -0700 (PDT)
In-Reply-To: <CAK=Wgba0_4W=vODss4+ZKE=PQL266+W0+vb3MiwsTqQH4_1_LQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, arnd@arndb.de, tony@atomide.com, Joerg.Roedel@amd.com, iommu@lists.linux-foundation.org, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ohad,

On Thu, Aug 18, 2011 at 2:01 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Hi Hiroshi,
>
> On Thu, Aug 18, 2011 at 1:49 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
>>> -extern void iommu_set_twl(struct iommu *obj, bool on);
>>
>> This function was introduced by "Hari Kanigeri" for some OMAP4 case,
>> which is only using TLB, not H/W table walk.
>
> We discussed that internally, and concluded it's not needed anymore. =
I
> still kept the underlying plumbing mechanism, just in case it'd still
> be needed for some hw quirks in the future, but removed the interface
> (in case a future hw revision will seem to need it, it would probably
> make more sense to invoke the relevant mechanism from the underlying
> layers rather than from a higher layer).
>
>>> -extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 en=
d);
>>
>> This function was introduced by "David Cohen" to specify the availab=
le
>> ISP virtual address range.

This function wasn't actually introduced by me, but I remember to refer=
 it
when I was discussing to not define address 0x0 as valid in da range by
default (unless intentionally specified by client).

>
> Not sure if David or anyone is using this, but if someone is, it must
> be out-of-tree.

I am fine to remove it.

Br,

David

>
> In that case, even if it is needed, adding a mainline user for this
> function at this point will most likely not be accepted anymore, and
> instead, one will be suggested to use (and extend as necessary) the
> DMA-API.
>
> Thanks,
> Ohad.
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
