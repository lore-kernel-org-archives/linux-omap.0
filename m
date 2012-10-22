From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/7] ARM: OMAP: second set of PRM/CM/CGRM cleanup patches
 for 3.8
Date: Mon, 22 Oct 2012 17:06:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210221641310.13464@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <5085389F.6070106@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56715 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab2JVRGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 13:06:55 -0400
In-Reply-To: <5085389F.6070106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 22 Oct 2012, Benoit Cousson wrote:

> What is CGRM? Is it a typo?

That's the OMAP1 Clock Generation and Reset Module that contains the 
ARM_SYSST register:

http://www.ti.com/lit/ug/spru678a/spru678a.pdf

- Paul
