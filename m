From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP: GPIO: fix auto-disable of debounce clock
Date: Mon, 7 Jun 2010 15:08:55 +0300
Message-ID: <20100607120855.GB31590@nokia.com>
References: <1275492149-29063-1-git-send-email-khilman@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25103 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab0FGMKF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 08:10:05 -0400
Content-Disposition: inline
In-Reply-To: <1275492149-29063-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Wed, Jun 02, 2010 at 05:22:29PM +0200, ext Kevin Hilman wrote:
>The addition of the new debounce code (commit
>168ef3d9a56bd8bffe0ef4189c450888b4aefefe) broke the auto-disable of
>debounce clocks on idle by forgetting to update the debounce clock
>enable mask.
>
>Add back the updating of bank->dbck_enable_mask so debounce clocks are
>auto-disabled.
>
>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>---
>Please include for 2.6.35-rc series.

oops, my bad :-(

-- 
balbi

DefectiveByDesign.org
