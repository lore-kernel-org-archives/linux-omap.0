From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [v3,1/3] OMAP2PLUS: DSS2: Add OMAP4 Kconfig support
Date: Fri, 11 Feb 2011 14:06:03 +0200
Message-ID: <1297425963.9552.305.camel@deskari>
References: <1296127024-17507-2-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1BKMGM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 07:06:12 -0500
In-Reply-To: <1296127024-17507-2-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, Mayuresh Janorkar <mayur@ti.com>

Hi,

On Thu, 2011-01-27 at 11:17 +0000, Sumit Semwal wrote:
> From: Mayuresh Janorkar <mayur@ti.com>
> 
> Enable DSS2 and OMAPFB for OMAP4 in Kconfig

The indentation in this patch seems to be a bit inconsistent with the
current Kconfigs. For example, you use two tabs in the help lines, and
the current files use either one tab and 2 spaces, or 10 spaces.

Please stick to the current indentation, or change the indentation for
the whole file in a separate patch.

 Tomi


