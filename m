From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH v6 02/12] media: Media device
Date: Thu, 25 Nov 2010 15:42:13 +0100
Message-ID: <201011251542.14024.laurent.pinchart@ideasonboard.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com> <1290652099-15102-3-git-send-email-laurent.pinchart@ideasonboard.com> <4CEE2D4E.6070906@ladisch.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:39309 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab0KYOl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 09:41:59 -0500
In-Reply-To: <4CEE2D4E.6070906@ladisch.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, lennart@poettering.net

Hi Clemens,

Thanks for the review.

On Thursday 25 November 2010 10:33:02 Clemens Ladisch wrote:
> Laurent Pinchart wrote:
> > +struct media_device {
> > ...
> > +	u8 model[32];
> > +	u8 serial[40];
> > +	u8 bus_info[32];
> 
> All drivers and userspace applications have to treat this as char[], so
> why u8[]?

Good question. I've copied the V4L2 practice of using u8 (or __u8) for fixed-
length strings in structures. I can't think of any reason for that.

I will replace u8 with char unless someone comes up with a good reason to keep 
u8.

-- 
Regards,

Laurent Pinchart
