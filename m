From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Fri, 27 Jul 2012 12:15:04 -0500
Message-ID: <5012CC98.60206@ti.com>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org> <20120625005134.GA2342@S2101-09.ap.freescale.net> <20120625084905.GD19226@n2100.arm.linux.org.uk> <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34617 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab2G0RPT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 13:15:19 -0400
In-Reply-To: <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Javier,

On 06/25/2012 05:31 AM, Javier Martinez Canillas wrote:
> On Mon, Jun 25, 2012 at 10:49 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Jun 25, 2012 at 08:51:37AM +0800, Shawn Guo wrote:
>>> It seems the same patch has been there for a while.
>>>
>>> http://thread.gmane.org/gmane.linux.kernel/1303115
>>
>> Bah, why doesn't stuff like this get resent if nothing has happened for
>> a while?
> 
> Indeed. At least other people that face the same issue (like me) sends
> similar patches to remind you :-)

I checked with Russell but this one is not in his patch tracking system
[1] and so still not queued. Can you submit this? Would be great to get
this one in.

Cheers
Jon

[1] http://www.arm.linux.org.uk/developer/patches/
