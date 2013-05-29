From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ
 pin and msecure line
Date: Wed, 29 May 2013 16:23:37 +0200
Message-ID: <51A60F69.7050203@ti.com>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org> <20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna> <87obc0f54r.fsf@linaro.org> <CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com> <87a9nkf3mu.fsf@linaro.org> <51A5CCA5.7000700@ti.com> <87ehcpano0.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60467 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966410Ab3E2PHV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 May 2013 11:07:21 -0400
In-Reply-To: <87ehcpano0.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5/29/2013 4:03 PM, Kevin Hilman wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
> [...]
>
>>>
>>> Let me respin this after some more doc reading.
>>
>> Did you re-spin it already?
>
> Yes, v2 is here.
>
> http://marc.info/?l=linux-omap&m=136944147521955&w=2
>
> It also needed a rework because the fref_clk0_out pin is also in the
> wkup section of the padconf, not core.

OK, I'll wait for the v3 then :-)

Benoit

