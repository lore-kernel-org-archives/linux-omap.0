From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 02/11] omapdss: HDMI: create a HDMI PLL library
Date: Tue, 17 Sep 2013 12:40:59 -0700
Message-ID: <CAPtuhTh-6JJnpqp=0FCQqkPS2yBUmj7-zniY4vRQR9xq+t8htg@mail.gmail.com>
References: <1379401597-27222-1-git-send-email-archit@ti.com>
 <1379401597-27222-3-git-send-email-archit@ti.com> <20130917093813.27384.67975@quantum>
 <523828A7.8050204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:55578 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab3IQTlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Sep 2013 15:41:21 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so5588353wgh.29
        for <linux-omap@vger.kernel.org>; Tue, 17 Sep 2013 12:41:20 -0700 (PDT)
In-Reply-To: <523828A7.8050204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Sep 17, 2013 at 3:02 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 17/09/13 12:38, Mike Turquette wrote:
>> Quoting Archit Taneja (2013-09-17 00:06:28)
>>> HDMI PLL is a block common to DSS in OMAP4, OMAP5 and DRA7x. Move the
>>> existing PLL functions from ti_hdmi_4xxx_ip.c and hdmi.c to a separate file.
>>> These funcs are called directly from the hdmi driver rather than hdmi_ip_ops
>>> function pointer calls.
>>>
>>> Add the PLL library function declarations to ti_hdmi.h. These will be shared
>>> amongst the omap4/5 hdmi platform drivers. Remove the PLL function pointer ops
>>> from the ti_hdmi_ip_ops struct. These will be shared amongst the omap4/5 hdmi
>>> platform drivers and other libraries.
>>>
>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>
>> Would be cool to see this convert to the common clock framework
>> implementation (include/linux/clk-provider.h). It appears that this PLL
>> only needs to support .enable, .disable and .recalc_rate callbacks at
>> first glance.
>
> We've got a (very) long term plan to use CCF for DSS. And, if I'm not
> mistaken, the PLL used for HDMI and DSI is the same as used elsewhere in
> OMAP (I don't remember the PLL type name).
>
> I think the main issue with DSS clocks is that we require as exact
> clocks as possible, and there are multiple dividers/multipliers on the
> clock path. So we iterate over the divider/multiplier ranges, trying to
> find as good freq match as possible.
>
> So if the clock path is composed from "black boxes", and we can only ask
> for a certain frequency, and get back probably some other frequency, it
> gets quite difficult to find good clock matches. Well, at least I
> imagine so, I have not tried to implement that.

I hope that the existing CLK_SET_RATE_PARENT flag could help you get
the frequency you need; it causes a call to clk_set_rate(leaf_clk,
target_rate) to walk up the chain of parents and configure rates as
needed.

However I have been looking at standardizing a way to define clock
rate tables, possibly in DT. In many cases it is a board-specific
issue (e.g. different oscillators or other reference clocks that feed
into the SoC) and specifying rate tables in DT is one way to store
known-good configurations for complex clock subtrees.

Regards,
Mike

>
>  Tomi
>
>
