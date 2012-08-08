From: Archit Taneja <a0393947@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 8 Aug 2012 14:08:13 +0530
Message-ID: <50222575.6050807@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>    <1344349948.7216.82.camel@lappyti> <502201B7.9030205@ti.com>   <1344407158.17575.21.camel@lappyti> <50220B94.5040303@ti.com>  <1344410835.17575.54.camel@lappyti> <50221C4D.8000503@ti.com> <1344413580.4932.5.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2HHIjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 04:39:39 -0400
In-Reply-To: <1344413580.4932.5.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Wednesday 08 August 2012 01:43 PM, Tomi Valkeinen wrote:
> On Wed, 2012-08-08 at 13:29 +0530, Archit Taneja wrote:
>
>> Okay, one thing which I want to align on is that most of these functions
>> don't really do the actual configurations. That is, they'll just update
>> the private data, and the actual configuration will only happen on enable.
>>
>> We would want set_timings() op to have a direct impact. But we wouldn't
>> want the same for setting the data lines, that could be clubbed with
>> other configurations at enable. That's okay, right?
>
> I'm not sure we want/need set_timings to have direct impact. Changing
> the timings on the fly has some problems, like the output size changing
> to smaller than the overlays, and we perhaps may need to adjust the
> clock dividers (dispc's, DSI PLL's or PRCM's).
>
> It feels just much easier and safer to require that the mgr is disabled
> when these changes are made. And as far as I can see, there shouldn't be
> any need to change the timings via the shadow registers, as quickly as
> possible and during vblank...

That makes sense. But currently set_timings for DPI has a direct impact. 
HDMI/VENC/SDI take the easier route of disabling and enabling the interface.

I agree it's safer and easier to make sure things are disabled first, 
but maybe it's good to have the capability set hdmi timings on the fly 
in the future, it would make the switch faster, same goes for reading edid.

What I meant to ask was whether we should do the same for something like 
dpi_set_data_lines(), that is, disable dpi, update the data_lines 
private data with a new value, and enable dpi again.

>
> This makes me also think that if the output related settings can only be
> changed when the output is off, the apply mechanism is not really needed
> at all for these. Not that it causes any harm, but just a point I
> realized.

Hmm, unfortunately you are right. It's still good to have all the DISPC 
writes only in APPLY though, and it gives us the option to do some 
operation on the fly if needed in the future.

Archit

