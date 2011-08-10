From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC/PATCH 04/14] OMAP: McBSP: use existing macros for
 converting between devices
Date: Wed, 10 Aug 2011 10:07:04 +0300
Message-ID: <20110810100704.856fcc5c.jhnikula@gmail.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<1312897232-4792-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46189 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab1HJHHJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 03:07:09 -0400
Received: by bke11 with SMTP id 11so188341bke.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 00:07:07 -0700 (PDT)
In-Reply-To: <1312897232-4792-5-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, Kevin Hilman <khilman@ti.com>

Hi

On Tue, 09 Aug 2011 19:10:22 +0500
"G, Manjunath Kondaiah" <manjugk@ti.com> wrote:

> From: Kevin Hilman <khilman@ti.com>
> 
> For converting from struct device to platform_device, and from
> platform_device to struct device, there are existing macros.  Use
> them instead of manual use of container_of().
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
Kevin dropped this patch and used mine that does more cleanups:

http://marc.info/?l=linux-omap&m=131255627918065&w=2

Worth to check also other patches since Kevin's updated set seems to
have other differences too:

http://marc.info/?l=linux-omap&m=131258997416300&w=2

-- 
Jarkko
