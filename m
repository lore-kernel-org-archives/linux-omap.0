From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH] Fix bootup crash for LDP platform
Date: Wed, 22 Oct 2008 23:35:16 +0800
Message-ID: <386072610810220835s2fe78519s7eaa7bb00585c684@mail.gmail.com>
References: <1224284642-13863-1-git-send-email-vikram.pandita@ti.com>
	 <200810181228.09194.david-b@pacbell.net>
	 <20081018194304.GP31842@frodo>
	 <200810181316.51253.david-b@pacbell.net>
	 <20081018203625.GR31842@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:11833 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbYJVPfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 11:35:18 -0400
Received: by yw-out-2324.google.com with SMTP id 9so559479ywe.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 08:35:16 -0700 (PDT)
In-Reply-To: <20081018203625.GR31842@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
>> Right.  Does Blackfin have an integrated transceiver like
>> DaVinci and TUSB?  Or does it use a discrete one?
>
> I'll revisit the blackfin patches, they're going only for 2.6.29 merge
> window.
>

Hi Felipe, is it possible to push blackfin patches in the 2.6.28?
because we are planning to use 2.6.28 stable release as our 2009R1 release.

If the usb part are merged, it is much easier for me to do the release.

Thanks
-Bryan
