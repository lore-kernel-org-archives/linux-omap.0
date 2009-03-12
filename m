From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] OMAP:clock: missing list_del for clk_notifier_unregister
Date: Thu, 12 Mar 2009 02:33:19 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51DBC4@dlee02.ent.ti.com>
References: <1236790153-9324-1-git-send-email-nm@ti.com>
 <alpine.DEB.2.00.0903120128570.26959@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33528 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbZCLHdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 03:33:33 -0400
In-Reply-To: <alpine.DEB.2.00.0903120128570.26959@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Palande Ameya <ameya.palande@nokia.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, March 12, 2009 9:31 AM
> To: Menon, Nishanth
> Cc: linux-omap@vger.kernel.org; Woodruff, Richard; Nayak, Rajendra; Gupta,
> Ramesh; Palande Ameya
> Subject: Re: [PATCH] OMAP:clock: missing list_del for
> clk_notifier_unregister
 
> Just to clarify, this is currently against the PM branch.  There's a new
Yes. This is against the PM branch
> version of the clock notifier patch coming out soon against l-o; will roll
> this fix in.
> 
Thanks.
Regards,
Nishanth Menon

