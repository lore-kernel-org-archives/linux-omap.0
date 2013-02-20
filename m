From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: hwmod: extract module address space from
 DT blob
Date: Wed, 20 Feb 2013 21:16:04 +0530
Message-ID: <5124EFBC.1010806@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com> <1361374735-22018-8-git-send-email-santosh.shilimkar@ti.com> <20130220154258.GI16652@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48315 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832Ab3BTPom (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 10:44:42 -0500
In-Reply-To: <20130220154258.GI16652@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Wednesday 20 February 2013 09:12 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Feb 20, 2013 at 09:08:54PM +0530, Santosh Shilimkar wrote:
>> Patch adds the code for extracting the module ocp address space from device
>> tree blob in case the hwmod address space look up fails.
>
> IMHO you should lookup on DT first and if that fails try hwmod ;-)
>
I thought about that one. Since we have more devices rely on hwmod than
DT, I put the code that way. Eventually, we will need only the dt
version.

Regards,
Santosh
