From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ pin and msecure line
Date: Wed, 29 May 2013 07:03:27 -0700
Message-ID: <87ehcpano0.fsf@linaro.org>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org>
	<20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna>
	<87obc0f54r.fsf@linaro.org>
	<CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com>
	<87a9nkf3mu.fsf@linaro.org> <51A5CCA5.7000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62264 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966716Ab3E2ODa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 10:03:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so9225631pbb.33
        for <linux-omap@vger.kernel.org>; Wed, 29 May 2013 07:03:30 -0700 (PDT)
In-Reply-To: <51A5CCA5.7000700@ti.com> (Benoit Cousson's message of "Wed, 29
	May 2013 11:38:45 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

[...]

>>
>> Let me respin this after some more doc reading.
>
> Did you re-spin it already?

Yes, v2 is here.  

http://marc.info/?l=linux-omap&m=136944147521955&w=2

It also needed a rework because the fref_clk0_out pin is also in the
wkup section of the padconf, not core.

Kevin
