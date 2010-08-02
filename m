From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: Add Zorder Support on OMAP4
Date: Mon, 02 Aug 2010 14:42:27 +0300
Message-ID: <1280749347.3436.45.camel@tubuntu.research.nokia.com>
References: <1279541407-17711-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61630 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab0HBLmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 07:42:42 -0400
In-Reply-To: <1279541407-17711-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sumit Semwal <sumit.semwal@ti.com>

On Mon, 2010-07-19 at 14:10 +0200, ext Archit Taneja wrote:
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> This patch series adds Zorder Support on OMAP4, this feature
> allows deciding the visibility order of the overlays based on
> the Zorder value given to a sysfs attribute of the overlay object.
> 
> Since this feature is not supported on OMAP3 and OMAP2, the sysfs
> attibutes always return Zorder as 0 and do not write to dispc registers
> for non OMAP4 architectures.

It would be better if the sysfs file only appears on OMAP4. I know that
method is not currently used for any other DSS sysfs files, but it's
long been in the todo list...

 Tomi


