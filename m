From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] iommu/omap: fix NULL pointer dereference
Date: Wed, 22 Feb 2012 11:10:38 +0200
Message-ID: <CAK=Wgba1CfpZpDqN3fruL-Ax_a_DwGuB=92pq4Ng3cSUGL8e2Q@mail.gmail.com>
References: <1329900772-9306-1-git-send-email-ohad@wizery.com>
 <1329900772-9306-2-git-send-email-ohad@wizery.com> <20120222085623.GF22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:36133 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752950Ab2BVJK6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 04:10:58 -0500
Received: by obcva7 with SMTP id va7so9648298obc.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 01:10:58 -0800 (PST)
In-Reply-To: <20120222085623.GF22675@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hdoyu@nvidia.com>

On Wed, Feb 22, 2012 at 10:56 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> There's something else which needs fixing here - the return code. =A0=
If
> omap_find_iovm_area() returns an error code that needs propagating.
> Otherwise it might as well just return NULL for all errors.

Seems like it does just return NULL for all errors, so a cleaner fix
can probably just be s/IS_ERR(area)/!area/.

I'll submit it, but Joerg, if you feel this is becoming a "cleanup",
feel free to take the first version.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
