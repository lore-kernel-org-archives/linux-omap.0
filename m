From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 6/9] ARM: OMAP4+: Remove out of placed smp_wmb() in secondary
 wakeup code
Date: Thu, 21 Feb 2013 18:29:24 +0530
Message-ID: <51261A2C.6020707@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-7-git-send-email-santosh.shilimkar@ti.com> <51261945.4040508@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab3BUM6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Feb 2013 07:58:05 -0500
In-Reply-To: <51261945.4040508@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 21 February 2013 06:25 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 20-02-2013 19:18, Santosh Shilimkar wrote:
>
>> The smp_wmb() here is out of placed
>
>     s/placed/place/
>
>> and redundant. So remove it. It is
>> a left over of the pain_release
>
>    Sure it's not 'pen_release'?
>
>> cleanup mostly.
>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
Yes... Will fix.

Regards,
Santosh

