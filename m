From: Kevin Hilman <khilman@ti.com>
Subject: Re: v3.5-rc4 doesn't wake from dynamic idle on 3530ES3 Beagle
Date: Wed, 27 Jun 2012 13:26:34 -0500
Message-ID: <87k3ysr4px.fsf@ti.com>
References: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:48998 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753386Ab2F0S00 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 14:26:26 -0400
Received: by yhmm54 with SMTP id m54so1634396yhm.5
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 11:26:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 27 Jun 2012 11:03:35 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Looks like something broke between v3.5-rc3 and v3.5-rc4 with dynamic 
> idle on 3530ES3 Beagle.  37xx EVM doesn't seem to be affected.
>
> Taking a closer look now.

I don't currently have access to a 3530 Beagle so I couldn't test there,
but just confirmed that vanilla v3.5-rc4 wakes up from dynamic idle (via
serial console) on 3430/n900, 3730/OveroSTORM and 3730/Beagle-xM.

Sounds like it may be something specific to Beagle board changes?

Kevin
