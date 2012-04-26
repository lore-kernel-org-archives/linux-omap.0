From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] arm: omap3: am35x: Fix clockdomain dependencies
Date: Thu, 26 Apr 2012 16:56:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204261656160.10308@utopia.booyaka.com>
References: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42912 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab2DZW4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 18:56:40 -0400
In-Reply-To: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Thu, 19 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs do not have an IVA so
> a parallel set of clockdomain dependencies are
> required that are simililar to OMAP3 but without
> any IVA dependencies.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Thanks, queued for 3.5.


- Paul
