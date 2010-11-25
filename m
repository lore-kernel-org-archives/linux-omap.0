From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 00/12] Media controller (core and V4L2)
Date: Thu, 25 Nov 2010 14:28:04 +0000
Message-ID: <20101125142803.GA15099@sirena.org.uk>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 25, 2010 at 03:28:07AM +0100, Laurent Pinchart wrote:

> I want to emphasize that the media controller API does *not* replace the V4L,
> DVB or ALSA APIs. It complements them.

Overall this looks relatively good and should be mappable onto the
embedded audio stack.  I'd need to sit down and actually do that to
go into too much specific detail but the only real issue I see is
working out how the control aspects of this interact with the control in
ALSA.  The simplest thing would be to have the userspace API be read
only for ALSA devices, I guess.

One potential issue 
