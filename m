From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Adio on BeagleBoard XM 2.6.37-rc8
Date: Wed, 19 Jan 2011 15:02:33 +0200
Message-ID: <20110119150233.b27475bc.jhnikula@gmail.com>
References: <AANLkTikPks0AcOpAK6We5zvju9k9qR=9z0-ua7qkKsLt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35047 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab1ASNCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 08:02:43 -0500
Received: by fxm20 with SMTP id 20so849220fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 05:02:42 -0800 (PST)
In-Reply-To: <AANLkTikPks0AcOpAK6We5zvju9k9qR=9z0-ua7qkKsLt@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashok Babu <ashok3d@gmail.com>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

On Wed, 19 Jan 2011 17:17:11 +0530
Ashok Babu <ashok3d@gmail.com> wrote:

> Hi folks,
> 
> After upgrading to 2.6.37-rc8, I am not able to play any audio.
> 
> Fund that the code in sound/soc/omap/omap-mcbsp.c uses the function
> "cpu_is_omap343x()" which fails and returns ENODEV.
> 
> Does the call should be "cpu_is_omap34xx()" instead ?
> 
It looks like so. cpu_is_omap34xx() checks the lowest 8 bits from
omap_rev (that are 0x34 for omap3x ) and cpu_is_omap343x() checks upper
12 bits (that are 0x363 for 3630).

Peter: I think cpu_is_omap343x() tests can be replaced by
cpu_is_omap34xx() in omap-mcbsp.c? 

-- 
Jarkko
