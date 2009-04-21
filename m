From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: lcd rotation in omapfb_main.c
Date: Wed, 22 Apr 2009 00:29:30 +0200
Message-ID: <200904220029.30297.marek.vasut@gmail.com>
References: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:56056 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbZDUW31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 18:29:27 -0400
Received: by fxm2 with SMTP id 2so2787281fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 15:29:25 -0700 (PDT)
In-Reply-To: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wednesday 22 of April 2009 00:18:54 twebb wrote:
> I'm trying to start up the LCD panel on a new omap35xx-based platform
> in portrait mode, though the native orientation of the display is
> landscape.  I'm running linux-2.6.27-omap1.  However, when I change
> "def_rotate" to 90 in omapfb_main.c, it doesn't seem to make any
> difference in the orientation of the display.  Any ideas why this
> might be happening?  Could there be outstanding fixes/patches I need?

change it to 1 or something ... btw. this should be configurable through some 
platform_data. Also, dont bring up new platform on deprecated kernel.
>
> Thanks,
> twebb
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


