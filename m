From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/15] OMAP3 camera driver: V4L2: Adding IOCTL command to get slave private data.
Date: Sun, 31 Aug 2008 14:35:47 -0700
Message-ID: <200808311435.47689.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE89441191E320@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:32225 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758545AbYHaVfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:35:50 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89441191E320@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 29 August 2008, Aguirre Rodriguez, Sergio Alberto wrote:
> From: Sakari Ailus <sakari.ailus@nokia.com>
> Date: Tue, 15 Apr 2008 10:35:15 +0300
> Subject: [PATCH] Adding IOCTL command to get slave private data.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  include/media/v4l2-int-device.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Seeing that series of patches from Felipe makes me wonder why
these patches shouldn't go *first* to the V4L list ... to help
avoid letting code sit for a long time in the OMAP tree without
going upstream.

This particular patch for example is not OMAP-specific.

And in general, the relevant review team for a V4L driver
(the rest of this series) is the V4L team not the OMAP team.
And if this driver passes their review, why not just merge
to mainline right away?
