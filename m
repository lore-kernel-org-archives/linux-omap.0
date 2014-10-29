From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 29 Oct 2014 08:43:03 -0500
Message-ID: <5450EEE7.8070801@ti.com>
References: <20141027200008.GR2560@atomide.com> <20141027230138.GB7805@drone.musicnaut.iki.fi> <20141028221243.GU2542@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43256 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932746AbaJ2Nnn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2014 09:43:43 -0400
In-Reply-To: <20141028221243.GU2542@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 10/28/2014 05:12 PM, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [141027 16:03]:
>> Hi,
>>
>> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
>>> +
>>> +	if (!of_have_populated_dt())
>>> +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
>>> +
>>
>> Maybe use WARN so that the warning is more verbose and kernel gets tainted?
> 
> Well I was hoping to avoid annoying people with the trace.
> But can do that if people prefer that, what do others think?
> 

WARN is better and eye catchy. Also, could we add information on when
the support will be removed since we call it deprecated?


-- 
Regards,
Nishanth Menon
