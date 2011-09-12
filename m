From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCHv2 2/4] OMAP: 2420SDP: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 17:45:38 +0530
Message-ID: <4E6DF7EA.4080105@ti.com>
References: <1315826494-27993-1-git-send-email-tomi.valkeinen@ti.com>	 <1315826494-27993-3-git-send-email-tomi.valkeinen@ti.com>	 <4E6DF170.20303@ti.com> <1315828651.2177.31.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54190 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755595Ab1ILMOq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 08:14:46 -0400
In-Reply-To: <1315828651.2177.31.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hunyue Yau <hyau@mvista.com>

On Monday 12 September 2011 05:27 PM, Valkeinen, Tomi wrote:
> On Mon, 2011-09-12 at 17:18 +0530, Archit Taneja wrote:
>> On Monday 12 September 2011 04:51 PM, Valkeinen, Tomi wrote:
>>> Port the old omapfb panel driver for 2420SDP to DSS2.
>>
>> Minor comment: The subject and commit message say 2420SDP, but patch
>> says 2430SDP.
>
> Ah, so it does, thanks.
>
>> I'll try to find the name of the panel.
>
> If you find a 2430 SDP board, I guess you can remove the panel by
> removing a few screws, and the chances are there's the manufacturer and
> model printed in the back of the panel.

I found it in a TI site, its a NEC panel, model is called "NL2432DR22-11B"
>
>   Tomi
>
>

