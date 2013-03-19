From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from
 the driver
Date: Mon, 18 Mar 2013 17:11:05 -0700
Message-ID: <20130319001105.GA13449@kroah.com>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
 <87sj4rqa7r.fsf@linaro.org>
 <5124EF59.5080206@ti.com>
 <51419A3D.1000703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34865 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab3CSAJt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Mar 2013 20:09:49 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so6872986pbc.0
        for <linux-omap@vger.kernel.org>; Mon, 18 Mar 2013 17:09:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51419A3D.1000703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Mar 14, 2013 at 03:07:01PM +0530, Santosh Shilimkar wrote:
> (Looping Greg KH.)
> 
> Greg,
> 
> On Wednesday 20 February 2013 09:14 PM, Santosh Shilimkar wrote:
> > On Wednesday 20 February 2013 08:54 PM, Kevin Hilman wrote:
> >> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> >>
> >>> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
> >>> so remove the hackery from the driver.
> >>>
> >>> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> >>> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> >>> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> >>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>
> >>> ---
> >>>   drivers/tty/serial/omap-serial.c |   23 -----------------------
> >>>   1 file changed, 23 deletions(-)
> >>
> >> This patch should also remove the hooks from
> >> <linux/platform_data/serial-omap.h>
> >>
> > Right. Will fix that in next version. Thanks.
> > 
> Sorry for not CC'ing first place
> The subject patch is part of the series which cleans up the slave
> idle handling from OMAP serial driver. It will be best to queue
> it along with rest of the patches with your ack on $subject patch.
> 
> Here is the updated version which also removed the hooks
> from 'linux/platform_data/serial-omap.h' as per Kevin suggestion.
> 
> >From 92916b8e0d895962c88fefbf99284967a4b94426 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 15 Feb 2013 15:50:37 +0530
> Subject: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from the
>  driver
> 
> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
> so remove the hackery from the driver.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
