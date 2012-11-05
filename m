From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
Date: Mon, 5 Nov 2012 19:53:45 +0530
Message-ID: <5097CBF1.6060108@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com> <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com> <20121105141442.GD4815@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37561 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab2KEOYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 09:24:17 -0500
In-Reply-To: <20121105141442.GD4815@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
>> -							dev->syscstate);
>> > -		}
> not sure if this will work. What about the first time you call reset() ?
> won't SYSC just contain the reset values ?
No actually the hwmod sets the value.

