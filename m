From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 08/65] OMAPDSS: remove partial update from panel-taal
Date: Wed, 23 Nov 2011 11:19:45 +0530
Message-ID: <4ECC8979.2080905@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>	 <1321953724-6350-9-git-send-email-tomi.valkeinen@ti.com>	 <4ECB8D39.4000005@ti.com> <1321965130.1887.46.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1KWFuV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 00:50:21 -0500
In-Reply-To: <1321965130.1887.46.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Tuesday 22 November 2011 06:02 PM, Tomi Valkeinen wrote:
> On Tue, 2011-11-22 at 17:23 +0530, Archit Taneja wrote:
>>> -     r = taal_set_update_window(td, x, y, w, h);
>>> +     /* XXX no need to send this every frame, but dsi break if not
>> done */
>>> +     r = taal_set_update_window(td, 0, 0,
>>> +                     td->panel_config->timings.x_res,
>>> +                     td->panel_config->timings.y_res);
>>
>> How about sending a null short packet, and a BTA after that. This
>> will
>> keep automatic TE mode in place, and we'll need to send 1 short
>> packet
>> instead of 2 long packets every frame.
>
> To be honest, I didn't spend any time with this. True, sending a null
> packet and BTA instead of the 2 long packets is possible. But probably
> even better would be to track the TE status, and send a BTA only when
> needed.

Right, if we maintain the TE status, we may not need to send a packet at 
all, so I guess we could stick with this for now, and remove it once we 
start maintaining the number of BTAs we have sent to the panel.

Archit

>
>   Tomi
>

