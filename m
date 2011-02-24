From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to
 omap_display
Date: Thu, 24 Feb 2011 11:27:23 +0200
Message-ID: <1298539643.16119.54.camel@deskari>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	 <1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41070 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966Ab1BXJ1a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 04:27:30 -0500
In-Reply-To: <1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>
Cc: paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Senthilvadivu Guruswamy <svadivu@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Mon, 2011-01-24 at 11:51 +0530, ext Sumit Semwal wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Change the driver name from omapdss to omap_display as the driver takes care of
> the display devices ie number of panels, type of panels available in the
> platform.  Change the device name in the board files and 2420,2430,3xxx clock
> files from omapdss to omap_display to match the driver name.

I just realized that changing the driver name will break all scripts and
applications using omapdss sysfs files.

How does this sound:

Let's leave the omapdss device name as it is. It represents a "super"
device, containing the dss sysfs files and upper level dss management.

Name the HW module platform drivers as: omapdss_dss, omapdss_venc,
omapdss_dispc, etc. This would indicate them to be clearly parts of DSS,
and would also prevent any possible name conflict if there would happen
to be a, say, "dsi" block in some other HW component.

 Tomi


