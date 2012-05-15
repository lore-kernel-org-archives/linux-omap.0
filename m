From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/2] arm: omap3: am35x: Convert emac to hwmod & disable
 hlt when open
Date: Tue, 15 May 2012 17:50:04 +0530
Message-ID: <4FB249F4.4000807@ti.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com> <874nripckw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427Ab2EOMUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 08:20:48 -0400
In-Reply-To: <874nripckw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>

Hi Kevin,

On 5/15/2012 4:58 AM, Kevin Hilman wrote:
> +Sekhar,
> 
> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>>
>> Paul, Kevin,
>>
>> These patches convert the davinci emac support for the am35x SoC
>> to use hwmod and add enable_hlt()/disable_hlt() calls to the
>> pm_runtime hooks for that driver.
> 
> Great.  I didn't look closely at the hwmod data, but the approach is
> right here, IMO.
> 
>> I have converted the davinci_emac driver to use pm_runtime but I
>> can't formally submit it yet since it requires some changes on the
>> mach-davinci side that haven't happened yet.  I will send it as an
>> RFC in a reply to this thread.
> 
> Sekhar, are you planning to add runtime PM core support to davinci?

Yes, Vaibhav is going to be working on this and will start very soon.

> I recommend looking at the simple OMAP1 layer that implements a basic
> clocks-only runtime PM layer.

Thanks. I have CCed Vaibhav on this mail for his information.

Regards,
Sekhar
