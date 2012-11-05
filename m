From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
Date: Mon, 5 Nov 2012 18:24:18 +0100
Message-ID: <5097F642.9010803@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com> <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com> <20121105141442.GD4815@arwen.pp.htv.fi> <5097CBF1.6060108@ti.com> <20121105142517.GG4815@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43032 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932813Ab2KERYm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 12:24:42 -0500
In-Reply-To: <20121105142517.GG4815@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

On 11/5/2012 3:25 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Nov 05, 2012 at 07:53:45PM +0530, Shubhrajyoti wrote:
>> On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
>>>> -							dev->syscstate);
>>>>> -		}
>>> not sure if this will work. What about the first time you call reset() ?
>>> won't SYSC just contain the reset values ?
>> No actually the hwmod sets the value.
>
> ahaaa, ok good. Let's get an Ack from Benoit, then.

Well, in fact, I'm a little bit surprised that we still have to hack the 
SYSC directly without using an omap_device API. I know that we have to 
do some weird stuff for reseting that IP, but didn't we already exposed 
something to allow that?

Regards,
Benoit


