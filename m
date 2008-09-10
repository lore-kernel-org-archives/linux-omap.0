From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: camera module has no target IDLEST bit
Date: Wed, 10 Sep 2008 11:25:26 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809101124310.20446@utopia.booyaka.com>
References: <alpine.DEB.1.00.0809051332380.32223@utopia.booyaka.com> <20080905223725.GD17156@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42206 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbYIJRZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 13:25:28 -0400
In-Reply-To: <20080905223725.GD17156@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, saaguirre@ti.com

Hello Russell,

On Fri, 5 Sep 2008, Russell King - ARM Linux wrote:

> On Fri, Sep 05, 2008 at 01:34:03PM -0600, Paul Walmsley wrote:
> > We must not attempt to wait for the CAM module to become ready after
> > clock enable, since it has no target IDLEST bit.
> 
> Grrr.  These things seem to be collecting here, and in need of a
> more generic and elegant solution.  (Please always do that rather
> than extending an already existing hack.)

OK, I will send some patches to clean up that function somewhat also.  

- Paul
