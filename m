From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM MDK (Re: LDP support)
Date: Fri, 08 May 2009 19:47:09 +0300
Message-ID: <87hbzv8rua.fsf@litku.valot.fi>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com>
	<4A03F8DD.4070307@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:58346 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbZEHQrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 12:47:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so805993fkq.5
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2009 09:47:12 -0700 (PDT)
In-Reply-To: <4A03F8DD.4070307@windriver.com> (stanley miao's message of "Fri\, 08 May 2009 17\:18\:21 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

"stanley.miao" <stanley.miao@windriver.com> writes:

>> Looks like you used the CodeSourcery 2007q3 toolchain. This had been
>> reported earlier. Switching to 2008q3 works.
>
> Yeah, Now the kernel booted. it's compiler's problem.

I was bitten by the same problem few weeks ago. Any chance of getting a
warning/error if using 2007q3 compiler until the problem is fixed?

-- 
Kalle Valo
