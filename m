From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 09/12] media: Entity locking and pipeline
 management
Date: Thu, 25 Nov 2010 13:53:51 +0000
Message-ID: <20101125135351.GD24208@opensource.wolfsonmicro.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290652099-15102-10-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49844 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752172Ab0KYNxm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 08:53:42 -0500
Content-Disposition: inline
In-Reply-To: <1290652099-15102-10-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net

On Thu, Nov 25, 2010 at 03:28:16AM +0100, Laurent Pinchart wrote:
> Link states must not be modified while streaming is in progress on a
> graph they belong or connect to. The entity locking API helps drivers
> enforcing that requirement.

This is not desirable for embedded audio - for example, it is very
common to wish to switch from headphone to speaker and back mid
playback, or to move between headset, speakerphone and handset modes on
a phone.  This is normally implemented by reconfiguring the output paths
at runtime without interrupting applications.
