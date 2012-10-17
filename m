From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: Updated status of the removal of plat headers
Date: Wed, 17 Oct 2012 16:51:49 -0500
Message-ID: <507F2875.2050406@ti.com>
References: <20121016230040.GP15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38947 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab2JQVvy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 17:51:54 -0400
In-Reply-To: <20121016230040.GP15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.luna@linaro.org>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Tony,

On 10/16/2012 06:00 PM, Tony Lindgren wrote:
> Hi all,
> 
> Here's a quick status update on the removal of remaining
> #include <plat/*.h> files. Most files are now fixed up, and
> we only have the following remaining:
> 
> cpu.h		wrapper only left, will be removed as soon as drivers are fixed
> 
> dmtimer.h	Jon is fixing this

I have patches ready for this. However, as you know I have a few timer
series cooking at the moment and just sent out the latest timer DT
series today [1][2].

I have also updated my timer fixes series [3] too, however, I was not
going to send out until the DT stuff is sorted. At the moment I have
included the dmtimer header patches with the fixes series as there are
some dependencies but this series has now grown into a 20+ patch series.
So if it is easier to manage, I could split this into a fixes series and
a clean-up series. Or if you only want the header stuff now, I could
send this and send the fixes and clean-up later.

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=135049690119218&w=2
[2] http://marc.info/?l=linux-omap&m=135049882020029&w=2
[3] http://marc.info/?l=linux-arm-kernel&m=134687192121865&w=2
