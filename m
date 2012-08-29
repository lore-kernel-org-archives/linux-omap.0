From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: timer: obey the !CONFIG_OMAP_32K_TIMER
Date: Thu, 30 Aug 2012 01:01:13 +0300
Message-ID: <503E9129.9060408@compulab.co.il>
References: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il> <CAMQu2gxZBq0wMw4rgbFpDT2pmA83ULKAJ-Mwv+VKvQQZMRQ4Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59393 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab2H2WBt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 18:01:49 -0400
In-Reply-To: <CAMQu2gxZBq0wMw4rgbFpDT2pmA83ULKAJ-Mwv+VKvQQZMRQ4Dw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/28/12 01:43, Shilimkar, Santosh wrote:
> On Mon, Aug 27, 2012 at 3:26 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> Currently, omap2_sync32k_clocksource_init() function initializes the 32K
>> timer as the system clock source regardless of the CONFIG_OMAP_32K_TIMER
>> setting.
>> Fix this by providing a default implementation for
>> !CONFIG_OMAP_32K_TIMER case.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Reviewed-by: Paul Walmsley <paul@pwsan.com>
>> ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks Santosh!

Tony, apparently, this bug has been there for a while,
so probably I should have added:
Cc: stable@vger.kernel.org

Thanks!

-- 
Regards,
Igor.
