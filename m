From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 4/5] ARM: OMAP3: bind omap3isp_device to its iommu device
Date: Wed, 9 Nov 2011 11:29:18 +0200
Message-ID: <CAK=WgbbizCd5ZBjyk=sukWtR6j1vVv+1Jc-QRzfppPCaQ+67HQ@mail.gmail.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
 <1316948337-7924-5-git-send-email-ohad@wizery.com> <201111091017.18860.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64519 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab1KIJ3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 04:29:39 -0500
In-Reply-To: <201111091017.18860.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Cousson Benoit <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hiroshi Doyu <hdoyu@nvidia.com>

On Wed, Nov 9, 2011 at 11:17 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Ohad,
>
> On Sunday 25 September 2011 12:58:56 Ohad Ben-Cohen wrote:
>> Bind OMAP3's isp device to the isp's dedicated iommu, by setting
>> the device's archdata iommu member.
>>
>> This way omap3isp will be able to use the generic IOMMU API without
>> having to call any omap-specific binding method.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, Laurent!

Tony, can you please Ack the OMAP parts of this patch set:

https://lkml.org/lkml/2011/9/25/44 (patch 3/5)
https://lkml.org/lkml/2011/9/25/46 (patch 4/5)
https://lkml.org/lkml/2011/9/25/45 (patch 5/5)

With this in hand, generic iommu users will now work on OMAP platforms
too (without calling any omap-specific API).

Thanks,
Ohad.
