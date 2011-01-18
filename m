From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [Query] OMAP: DSS2: Margin for downscaling in clock calculations
Date: Wed, 19 Jan 2011 02:39:13 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F923C59@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC356087035F86FA74@dbde02.ent.ti.com>
 <1295360369.27310.18.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52364 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab1ARVJV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 16:09:21 -0500
In-Reply-To: <1295360369.27310.18.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> On Tue, 2011-01-18 at 10:45 +0530, ext Taneja, Archit wrote:
>> Hi,
>> 
>> I was going through the DSS2 code which sets up the FCLK coming
>> from PRCM and the DISPC divivors to get the required pixel clock.
>> 
>> The function dss_calc_clock_div() does a brute force search across
>> all possible values of: a) DPLL divisor whose output goes to DSS,
>> b) DISPC_DIVISOR.LCD, c) DISPC_DIVISOR.pcd
>> 
>> The combination which gives a clock frequency closest to the
>> required pixel clock is chosen. 
>> 
>> Hence, it seems that the resultant DISPC_FCLK clock frequency
>> doesn't take into account the extra margin needed for downscaling:
>> 
>> Req dispc_fclk >= pck * hscale_ratio * vscale_ration * K
>> 
>> Do you thing putting a further constraint (like DISPC_FCLK needs
>> to be greater than a given value) should be a part of the
>> calculations to ensure successful scaling?
> 
> It's been a while since I looked at the fclk requirements,
> but isn't the current CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK
> enough? It is quite hackish and static, but a proper
> implementation is much harder (dynamically changing the
> clocks depending on the scaling).
> 

I think I ignored this part of the code :), I suppose this should be good
enough for most cases.

I was wondering why we can't try to get the DSS_FCLK always at the max
clock supported? Which is 173 Mhz on omap2/3.

Is it because we won't get a close enough pck with the lcd, pcd divisor
combinations or is it needed to save power?

If we stick to 173 Mhz(or something close to it) we could provide the best
possible downscaling(which may need dispc_fck as much as 8 times the pixel clock)

Consider 2 hypothetical divisor combinations for a desired pixel clock:

a)DISPC_FCLK=120Mhz, delta between calculated pck and desired pck ~ 1%
b)DISPC_FCLK=160Mhz, delta between calculated pck and desired pck ~ 2%

Wouldn't it be better to go with option (b) since it gives me something close
to a desired pixel clock and also ensures better downscaling?

Using CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK may or may not let me arrive at(b), since
it will ensure jumps at discrete multiples of pck.

I am not totally sure if I make much sense, but would appreciate comments anyway :)

Archit


> Or were there some additional restrictions?
> 
>  Tomi