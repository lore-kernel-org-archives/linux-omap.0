From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2] OMAP: HWMOD: Bug fixes in hwmod structure
 definitions
Date: Sat, 27 Feb 2010 02:11:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002270211020.2701@utopia.booyaka.com>
References: <1266988886-12548-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37060 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968044Ab0B0JLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Feb 2010 04:11:14 -0500
In-Reply-To: <1266988886-12548-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 24 Feb 2010, Thara Gopinath wrote:

> This patch corrects the width of sysc_flags in hwmod sysconfig structure
> where the values to be stored to this variable exceed the current
> field width.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>

Thanks, queued for .34-rcX.


- Paul
