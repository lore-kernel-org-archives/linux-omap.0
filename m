From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 16/21] OMAPDSS: handle output-driver reg/unreg more dynamically
Date: Thu, 8 Mar 2012 15:20:24 +0530
Message-ID: <4F5880E0.3040507@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>  <1331124290-6285-17-git-send-email-tomi.valkeinen@ti.com>  <4F586EFD.1020208@ti.com> <1331196364.2354.49.camel@deskari>  <4F587A62.3020202@ti.com> <1331199297.2354.62.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59131 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab2CHJum (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 04:50:42 -0500
In-Reply-To: <1331199297.2354.62.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 08 March 2012 03:04 PM, Tomi Valkeinen wrote:
> On Thu, 2012-03-08 at 14:52 +0530, Archit Taneja wrote:
>> On Thursday 08 March 2012 02:16 PM, Tomi Valkeinen wrote:
>>> On Thu, 2012-03-08 at 14:04 +0530, Archit Taneja wrote:

<snip>

>> Oh okay. But the comment after the patch set still says "It's ok if the
>> output-driver register fails.", we could change it to "It's ok if the
>> output-driver probe fails."
>
> Well, I guess this goes into nitpicking area, but if there are no
> devices, probe is not called at all. So I think it's the driver register
> that fails in that case. If there is a device, and it is probed, and
> that fails, then it's probe which fails.

Yes, that's fair enough I guess.

<snip>

>>
>> If we ensure that none of our probes return ENODEV(even though it may
>> make sense to return it if a func within probe fails), we could
>> differentiate between the 2 cases, right?
>
> True, I thought about that. But we can never be sure that the functions
> called by the probe (clk_get, or whatever) won't return ENODEV. Of
> course, we could check what they return, and change the error to
> something else, but I'm not sure if that's good either.

That's true.

<snip>

> Alternatively, if the platform driver code was changed to tell us
> clearly if it was the probe that failed or if there just weren't any
> devices, we could also use that.

Yes, I wonder how that could be done.

Archit

>
>   Tomi
>

