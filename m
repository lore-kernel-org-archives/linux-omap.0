From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 2/8] misc: ddr: add LPDDR2 data from JESD209-2
Date: Thu, 16 Feb 2012 11:10:43 +0000
Message-ID: <20120216111043.3256189f@pyramind.ukuu.org.uk>
References: <1328357771-31644-1-git-send-email-aneesh@ti.com>
	<1328357771-31644-3-git-send-email-aneesh@ti.com>
	<4F3CD55C.2020002@ti.com>
	<4F3CDA2D.2060001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53752 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab2BPLJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 06:09:03 -0500
In-Reply-To: <4F3CDA2D.2060001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Thu, 16 Feb 2012 15:57:57 +0530
Aneesh V <aneesh@ti.com> wrote:

> On Thursday 16 February 2012 03:37 PM, Santosh Shilimkar wrote:
> > On Saturday 04 February 2012 05:46 PM, Aneesh V wrote:
> >> add LPDDR2 data from the JEDEC spec JESD209-2. The data
> >> includes:
> >>
> >> 1. Addressing information for LPDDR2 memories of different
> >>     densities and types(S2/S4)
> >> 2. AC timing data.
> >>
> >> This data will useful for memory controller device drivers

I don't think it belongs in drivers/misc. It's not a driver but a
library. lib/ might be a better place for it perhaps ?

Alan
