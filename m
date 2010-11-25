From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH v6 09/12] media: Entity locking and pipeline management
Date: Thu, 25 Nov 2010 16:47:44 +0100
Message-ID: <201011251647.45488.laurent.pinchart@ideasonboard.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com> <1290652099-15102-10-git-send-email-laurent.pinchart@ideasonboard.com> <20101125135351.GD24208@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54090 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0KYPrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 10:47:31 -0500
In-Reply-To: <20101125135351.GD24208@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net

Hi Mark,

On Thursday 25 November 2010 14:53:51 Mark Brown wrote:
> On Thu, Nov 25, 2010 at 03:28:16AM +0100, Laurent Pinchart wrote:
> > Link states must not be modified while streaming is in progress on a
> > graph they belong or connect to. The entity locking API helps drivers
> > enforcing that requirement.
> 
> This is not desirable for embedded audio - for example, it is very
> common to wish to switch from headphone to speaker and back mid
> playback, or to move between headset, speakerphone and handset modes on
> a phone.  This is normally implemented by reconfiguring the output paths
> at runtime without interrupting applications.

Agreed. The locking should be made optional. I'll work on that.

-- 
Regards,

Laurent Pinchart
