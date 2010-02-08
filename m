From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV6 3/4] OMAP3: Introduce 3630 DPLL4 HSDivider changes
Date: Mon, 8 Feb 2010 12:24:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002081223070.22923@utopia.booyaka.com>
References: <1265638684-30250-1-git-send-email-vishwanath.bs@ti.com> <1265638684-30250-2-git-send-email-vishwanath.bs@ti.com> <1265638684-30250-3-git-send-email-vishwanath.bs@ti.com> <1265638684-30250-4-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45385 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab0BHTYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 14:24:14 -0500
In-Reply-To: <1265638684-30250-4-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Vishwanath,

On Mon, 8 Feb 2010, Vishwanath BS wrote:

> DPLL4 HS Divider (M2, M3, M4, M5 and M6) field width has been increased
> by 1 bit in 3630. This patch has changes to accommodate this in CM
> dynamically based on chip version.
> Basically new clock nodes have been added for 3630 DPLL4 M2,M3,M4,M5 and
> M6 and value of these nodes are used if cpu type is 3630.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

This patch looks basically okay but needs to be updated and reposted after 
the first patch in this series is fixed, since some of the macro changes 
will now happen in the first patch.


- Paul
