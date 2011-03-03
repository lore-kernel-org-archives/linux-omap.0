From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/8] OMAP4 : DSS2 : HDMI: HDMI specific display
 controller and dss change.
Date: Thu, 3 Mar 2011 08:40:32 +0200
Message-ID: <1299134432.2615.12.camel@deskari>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	 <1298988988-28429-3-git-send-email-mythripk@ti.com>
	 <1298998905.2049.34.camel@deskari>
	 <AANLkTikVsqLdRKPwQoeyOMqH+yiLfoGWcjvQDuEO=wYD@mail.gmail.com>
	 <AANLkTikzAD-B9LcK30v8J6MeMPHZ2FDRYcp5VFPR47TY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46632 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab1CCGk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 01:40:57 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p236euYS023889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 00:40:56 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p236euLx025085
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 00:40:56 -0600 (CST)
In-Reply-To: <AANLkTikzAD-B9LcK30v8J6MeMPHZ2FDRYcp5VFPR47TY@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2011-03-02 at 23:29 -0600, K, Mythri P wrote:
> Hi Tomi,
> I just rechecked the TRM.
> The TRM description of the bit is VENC_HDMI_switch , Wouldnt it be
> appropriate to have the same
> name for the enum and the variables as suggested by you.

Please don't top-post when posting to mailing lists.

Yes, it's a good rule of thumb to have similar naming with the TRM.
However, we shouldn't follow TRM blindly, and also TRM can be changed.

In this case we already have a bunch of functions to configure the clock
muxes, like
void dss_select_dispc_clk_source(enum dss_clk_source clk_src)

Also, a function name like dss_select_hdmi_venc doesn't really tell
anything about what it does. Even if you know the architecture of DSS
HW, you can't deduce what the function does.

And usually when you are pondering about the clocking configuration, you
look at the DSS clock tree figure (fig 10-4), or the DSS clock sources
table 10-3. And in this case I believe the naming in those figures and
tables are much better than the name of the bit we are setting.

 Tomi


