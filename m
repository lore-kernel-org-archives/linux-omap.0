From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 6/7] ARM: OMAP: Disable POSTED mode for errata i103 and
 i767
Date: Mon, 25 Nov 2013 16:17:55 -0600
Message-ID: <5293CC93.6040603@ti.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com> <1385415876-12387-7-git-send-email-joelf@ti.com> <20131125221437.GW10023@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59042 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab3KYWST (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 17:18:19 -0500
In-Reply-To: <20131125221437.GW10023@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On 11/25/2013 04:14 PM, Tony Lindgren wrote:
> * Joel Fernandes <joelf@ti.com> [131125 13:46]:
>> Enabling of Posted mode is seen to cause problems on dmtimer modules on AM33xx
>> (much like other OMAPs).  Reference discussions on forums [1] [2]. Earlier
>> patch solving this on other OMAPs [3].
>>
>> For OMAP SoCs with this errata, the fix has been to not enable Posted mode.
>> However, on some SoCs (atleast AM33xx) which carry this errata, Posted mode
>> is enabled on reset. So we not only need to ignore enabling of the POSTED bit
>> when the timer is requested, but also disable Posted mode if errata is present.
> 
> This could explain some occasional lost timers I saw a while back when
> testing things.. We most likely should merge for the -rc series with cc stable.

Sure, I agree.

> 
> Does this depend on the other patches in this series?
> 

No it doesn't depend.


thanks,

-Joel
