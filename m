From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Modified omap_mux_init_signal() to take in
 const char *
Date: Fri, 22 Oct 2010 10:21:20 -0700
Message-ID: <20101022172120.GH9149@atomide.com>
References: <1287687041-22377-1-git-send-email-tim.nordell@logicpd.com>
 <4CC09042.3000201@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62556 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab0JVRVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 13:21:25 -0400
Content-Disposition: inline
In-Reply-To: <4CC09042.3000201@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Nordell <tim.nordell@logicpd.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

* Tim Nordell <tim.nordell@logicpd.com> [101021 12:02]:
>  On 10/21/10 13:50, Tim Nordell wrote:
> 
> It looks like by inspection that there could be a couple of things wrong
> with that patch however.  Namely, on the comparison of muxname to
> m0_entry, if they have the same string up to mode0_len, such as
> "dss_data1" and "dss_data12" it'd match there prematurely as it'd stop
> comparing.  Also, a minor display issue on the printk of the new muxname.

Good catch, it would be nice to get those fixed too. Got any patches
for those issues?

Regards,

Tony
