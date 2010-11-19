From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] OMAP4: mux: Initialise OMAP4 mux pins.
Date: Fri, 19 Nov 2010 08:04:04 -0800
Message-ID: <20101119160403.GQ9264@atomide.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
 <20101118190650.GK9264@atomide.com>
 <4CE59573.80408@ti.com>
 <20101118212626.GN9264@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB5930247388A41@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38405 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0KSQES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 11:04:18 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247388A41@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* R, Sricharan <r.sricharan@ti.com> [101119 00:39]:
> 
> Ok . This means that the pin muxing introduced
>  would be applicable for omap 2 ,3 and 4 also, with the
> board file passing the respective data if they are different ?

Well the pin configuration stays board specific, but the code
to set the pads is same for all omap2/3/4.

Even if the signal names stay the same, the pad configuration
register value may be different if external pulls are used
instead of the internal ones.

Regards,

Tony
