From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Fri, 9 May 2014 11:49:43 +0530
Message-ID: <536C737F.80205@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com> <536B1A9C.7050006@ti.com> <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37686 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbaEIGVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 02:21:16 -0400
In-Reply-To: <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Thursday 08 May 2014 09:31 PM, Paul Walmsley wrote:
<snip>

>> The problem is that we have multiple hwmods which use the same MODULEMODE bit.
>> There is no use-counting done when it comes to enabling/disabling modulemode.
>> If there was such a thing, we could have provided MODULEMODE flags even for
>> the children hwmods.
>
> Thanks for the summary.  This is indeed a long-overdue item for the hwmod
> core code.  Can you please patch the hwmod core code to add this?  I'd
> suggest making the use-counting functionality conditional on a hwmod flag
> that you can set for all of the DSS hwmods.  (Ideally, the core code would
> detect that several modules share the same MODULEMODE bits, and
> automatically set it for those cases, but that seems a bit too complex for
> a first cut.)

Sure, I can work on this.

Archit

