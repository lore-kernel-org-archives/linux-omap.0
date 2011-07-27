From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 0/7] decouple platform_device from omap_device
Date: Wed, 27 Jul 2011 19:34:57 +0530
Message-ID: <20110727140457.GA8558@manju-desktop>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50079 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751313Ab1G0OFQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 10:05:16 -0400
Received: by mail-gx0-f169.google.com with SMTP id 23so1365632gxk.14
        for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 07:05:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311292338-11830-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Kevin,

On Thu, Jul 21, 2011 at 04:52:10PM -0700, Kevin Hilman wrote:
> Here's a first whack, proof-of-concept on how we could start to
> decouple the platform_device from an omap_device.
> 
> The main RFC is in the last patch, and everything leading up to it are
> misc. omap_device cleanups that make the last patch cleaner and
> clearer.  It's really the last patch that does the decoupling.
> 
> This will be necessary if we're going to decouple the platform_device
> creation from the omap_device/omap_hwmod creation etc.  This patch
> leaves them both done in omap_device_build(), but shows that they can
> be decoupled.
Can you pls mention baseline used for these patches? I tried applying on
latest mainline, v3.0 and  git://git.pwsan.com/linux-2.6 prcm-devel-3.1

It will not apply cleanly.

-M
