From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] OMAP: UART conversion to omap_device/omap_hwmod
Date: Tue, 12 Jan 2010 16:04:01 -0800
Message-ID: <87bpgy6fbi.fsf@deeprootsystems.com>
References: <1263340728-17929-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42930 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0AMAEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 19:04:04 -0500
Received: by pwj9 with SMTP id 9so2462937pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 16:04:03 -0800 (PST)
In-Reply-To: <1263340728-17929-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Tue\, 12 Jan 2010 15\:58\:46 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj R <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> This series applies on curren PM branch plus my omap_device series
> posted on 8 jan:
>
>   [PATCH 0/3] misc. omap_device/omap_hwmod updates
>
> and is also available as branch 'pm-wip/uart' in my linux-omap-pm repo[1].
>
> This series should allow further development and testing of the new
> omap-serial driver from Govindraj.

Govindraj,

I forgot to mention that I tested this both with the 8250 driver and
your V4 omap-serial driver.

There still seem to be some strange hangs when using omap-serial
driver compard to 8250, especially when booting a full userspace like
Arago.  I haven't debugged fully, but omap-serial needs some more
testing with this.

Kevin

