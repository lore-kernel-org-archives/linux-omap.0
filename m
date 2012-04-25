From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 01/10] OMAPDSS: HDMI: Remove ASoC codec
Date: Tue, 24 Apr 2012 21:27:43 -0500
Message-ID: <4F97611F.1040102@ti.com>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>  <1332974305-4578-2-git-send-email-ricardo.neri@ti.com> <1335187034.1535.35.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43523 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab2DYC1t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 22:27:49 -0400
In-Reply-To: <1335187034.1535.35.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org

Hi Tomi,

Thanks for your comments!

On 04/23/2012 08:17 AM, Tomi Valkeinen wrote:
> On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
>> Instead of having an ASoC codec embedded into DSS code, use the generic DSS
>> device driverinterface for audio support. This allows to any potential user,
>> including an ASoC driver, take advantage of the HDMI audio functionality.
>
> The description could be improved. The patch removes lots of code from
> the hdmi driver, but the description doesn't really describe what's
> going on and where the code goes (if anywhere). In fact, it even feels
> that the description is about something else. It basically just says
> "use generic DSS interface for audio", but the patch doesn't do that, it
> removes code.

Yes. It seems that the description is more suitable for the whole patch 
series. I was trying to justify why I was removing the ASoC HDMI codec. 
I will rephrase to state that this patch removes the HDMI audio support 
to restore in a separate patch through the DSS audio interface.
>
> Also how does this affect the current driver? I presume it effectively
> removes HDMI audio support? Does the code still compile with this patch?

Yes, the code still compiles as the current ASoC HDMI codec exists with 
independences of the ASoC HDMI DAI and machine drivers. It will compile 
but it will not probe and ALSA HDMI audio support will be missing.

BR,

Ricardo
>
>   Tomi

