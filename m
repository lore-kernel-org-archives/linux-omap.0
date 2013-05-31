From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 1/1] ARM: dts: OMAP4/AM35xx: Fix missing dtb in the
 dtbs target
Date: Fri, 31 May 2013 18:07:35 +0200
Message-ID: <51A8CAC7.9000205@epfl.ch>
References: <1370009151-32362-1-git-send-email-florian.vaussard@epfl.ch> <1370009151-32362-2-git-send-email-florian.vaussard@epfl.ch> <51A8B782.2020203@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:58757 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753627Ab3EaQHk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 12:07:40 -0400
In-Reply-To: <51A8B782.2020203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hello Benoit,

On 05/31/2013 04:45 PM, Benoit Cousson wrote:
> On 05/31/2013 04:05 PM, Florian Vaussard wrote:
>> When making the dtbs target on OMAP/AM35xx, some trees are not
>> built.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>
> Thanks for the fix Florian.
>
> I need to applied your AM series first to take that one otherwise the
> am3517-evm will fail since it depends on omap3.dtsi.
>

Right. It was a bad idea to split in two series, sorry.

> BTW, I applied some more AM patches in my branch, and I cannot apply
> "ARM: dts: AM33XX: Use pinctrl constants" anymore.
>
> Just wait for some review from AM folks before updating the whole series.
>

Ok, I will rebase on your branch in the coming days.

Regards,
Florian
