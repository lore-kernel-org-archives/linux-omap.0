From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Doesn't power management switch off the LCD's LED backlight?
Date: Tue, 19 May 2009 16:22:34 -0700
Message-ID: <87ljos4r0l.fsf@deeprootsystems.com>
References: <094F3A5A-9980-4F07-9CB2-3A90EA54C9DE@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:22008 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbZESXWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:22:36 -0400
Received: by rv-out-0506.google.com with SMTP id f9so29816rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 16:22:37 -0700 (PDT)
In-Reply-To: <094F3A5A-9980-4F07-9CB2-3A90EA54C9DE@mac.com> (Elvis Dowson's message of "Tue\, 19 May 2009 22\:52\:59 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> 	I just applied all the 191 pm patches successfully. I was just
> wondering, doesn't the pm patches turn off the LCD LED backlight? I
> have a samsung lcd touschreen, and although the screen turns dark when
> it goes to suspend mode, I can still see the LED backlight on from if
> I look at it at an angle.

As I've stated before, the PM branch currently focues on getting core
PM infrastructure in place.  There are lots of drivers that do not
have proper PM support in place.

In this case, the screen blanking is a feature of the
framebuffer/display drivers and has yet to be implemented.

Kevin
