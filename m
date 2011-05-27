From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD
 init
Date: Fri, 27 May 2011 14:16:08 +0200
Message-ID: <4DDF9608.3060401@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-4-git-send-email-nm@ti.com> <87oc2p82q0.fsf@ti.com> <4DDF4E4D.6060008@ti.com> <BANLkTi=dHknRn5KJSh3_bG-o19BUg2AjrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59283 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab1E0MQM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 08:16:12 -0400
In-Reply-To: <BANLkTi=dHknRn5KJSh3_bG-o19BUg2AjrA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

On 5/27/2011 9:26 AM, Govindraj wrote:
>
> On Fri, May 27, 2011 at 12:40 PM, Cousson, Benoit <b-cousson@ti.com
> <mailto:b-cousson@ti.com>> wrote:
>
>     On 5/27/2011 1:24 AM, Hilman, Kevin wrote:
>
>         Nishanth Menon<nm@ti.com <mailto:nm@ti.com>>  writes:
>
>             From: Moiz Sonasath<m-sonasath@ti.com
>             <mailto:m-sonasath@ti.com>>
>
>             For OMAP4460, GPIO-7 of bank1 is used for controling
>             the TPS modes, hence GPIO1 should not be reset
>             during init as reset will cause the TPS voltage to
>             drop to 0.9 V.
>
>
>         ouch.  I knew one of these days something like this was going to
>         happen
>         with GPIO resets.
>
>
>     BTW, don't we have the same kind of issue with the debug UART? I
>     remember that you had to do some hacks at some point to change these
>     hwmod flags in the UART code.
>
>
> Yes. we use below flags.
>
> uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;

Yeah, that's ugly... we do have to get rid of that as well using some 
board settings / API.

Benoit
