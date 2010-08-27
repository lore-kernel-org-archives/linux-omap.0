From: Tony Lindgren <tony.m.lindgren@gmail.com>
Subject: Re: [PATCH 2/9] omap: mux: Add new style pin multiplexing code for
 omap3
Date: Fri, 27 Aug 2010 14:26:41 -0700
Message-ID: <20100827212640.GE28816@atomide.com>
References: <S1752576Ab0H0BhI/20100827013708Z+1681@vger.kernel.org>
 <1282876196.13328.45.camel@I097020.innocomm.com>
 <4C778455.8050108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63061 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab0H0V0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 17:26:47 -0400
Content-Disposition: inline
In-Reply-To: <4C778455.8050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: rockefeller <rockefeller.lin@innocomm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

* Cousson, Benoit <b-cousson@ti.com> [100827 02:17]:
> On 8/27/2010 4:29 AM, rockefeller wrote:
> >
> >Because "muxname.mode7" in in RAM is modifiable, after function call
> >to function1(), the *pine_mux_name will be "muxname" and therefore when
> >calls to function2() to try to set this pin in mode7 with value 0x0000
> >might be un-expected result.
> 
> In theory the pin mux is done once at init time, so I'm not sure
> this case is supposed to happen. Is it a real case?
> 
> Anyway, I think that a simple strlcpy(tmp, muxname, 32) in
> omap_mux_init_signal can fix it.
> 
> Do you mind submitting a patch to fix that?

Yeah that's a bug, we should not trash the muxname.

Regards,

Tony
