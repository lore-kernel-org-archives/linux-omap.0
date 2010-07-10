From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
Date: Sat, 10 Jul 2010 16:56:39 +0200
Message-ID: <20100710145639.GC10080@8bytes.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org> <1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org> <20100701101746.3810cc3b.randy.dunlap@oracle.com> <20100701180241.GA3594@basil.fritz.box> <1278021944.7738.43.camel@c-dwalke-linux.qualcomm.com> <4C2D965F.5000206@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 8bytes.org ([88.198.83.132]:34386 "EHLO 8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab0GJO4k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jul 2010 10:56:40 -0400
Content-Disposition: inline
In-Reply-To: <4C2D965F.5000206@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zach Pfeffer <zpfeffer@codeaurora.org>
Cc: Daniel Walker <dwalker@codeaurora.org>, Andi Kleen <andi@firstfloor.org>, Randy Dunlap <randy.dunlap@oracle.com>, mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 02, 2010 at 12:33:51AM -0700, Zach Pfeffer wrote:
> Daniel Walker wrote:

> > So if we include this code which "map implementations" could you
> > collapse into this implementations ? Generally , what currently existing
> > code can VCMM help to eliminate?
> 
> In theory, it can eliminate all code the interoperates between IOMMU,
> CPU and non-IOMMU based devices and all the mapping code, alignment,
> mapping attribute and special block size support that's been
> implemented.

Thats a very abstract statement. Can you point to particular code files
and give a rough sketch how it could be improved using VCMM?

	Joerg

