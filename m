From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Does SmartReflex pm patches affect USB suspend resume operations
Date: Tue, 19 May 2009 09:12:32 -0700
Message-ID: <87tz3h6phr.fsf@deeprootsystems.com>
References: <7B1B64C5-631E-4C63-B1F3-F4429C697614@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:40121 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbZESQMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 12:12:33 -0400
Received: by pxi29 with SMTP id 29so2498058pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 09:12:34 -0700 (PDT)
In-Reply-To: <7B1B64C5-631E-4C63-B1F3-F4429C697614@mac.com> (Elvis Dowson's message of "Tue\, 19 May 2009 18\:48\:48 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

>      Does the SmartReflex pm patches affect the operation of USB
> suspend/resume functions? Without the SR patches, the TI OMAP 3503
> does not go to suspend mode at the moment.

You're testing something that others are not: PM branch minus SR
patches.

I suggest you re-add the SR patches and try the suggestions of others:
Roger's patches + fix your board file.

Then try USB again.

That being said, the USB driver is known to be not fully PM aware yet.
On my SDP, I've tested MUSB in host mode with mass storage and a USB
key and it can suspend/resume just fine.  However, it does not work
with off-mode.

Kevin
