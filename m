From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP: omap-mcbsp: Fix building after replacement
Date: Fri, 21 Jan 2011 11:55:55 +0530
Message-ID: <AANLkTikkApJAa_mnwr9tKT2e2OUnERHoEifbdj8+CcEe@mail.gmail.com>
References: <1295532731-5438-1-git-send-email-weber@corscience.de>
 <AANLkTimd--8qbUd7Dnj5dyGiRAZByp_xBUesXN7SPFDj@mail.gmail.com> <20110120181952.GY4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37902 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752379Ab1AUG0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 01:26:35 -0500
Received: by mail-gy0-f173.google.com with SMTP id 5so498473gye.32
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 22:26:35 -0800 (PST)
In-Reply-To: <20110120181952.GY4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

On Thu, Jan 20, 2011 at 23:49, Tony Lindgren <tony@atomide.com> wrote:
> * Poddar, Sourav <sourav.poddar@ti.com> [110120 07:08]:
>> On Thu, Jan 20, 2011 at 7:42 PM, Thomas Weber <weber@corscience.de> =
wrote:
>> > Fix building omap-mcbsp after replacing ARCH_OMAP24x0 in
>> > commit 8a9c1aa6a4caa7db1c2fca4b47168af9077e0f95.
>> >
>> >> =A0 omap: Start using CONFIG_SOC_OMAP
>> >>
>> >> =A0 =A0We want to have just CONFIG_ARCH_OMAP2, 3 and 4. The rest
>> >> =A0 =A0are nowadays just subcategories of these.
>> >>
>> >> =A0 =A0Search and replace the following:
>> >>
>> >> =A0 =A0ARCH_OMAP2420 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SOC_OMAP2420
>> >> =A0 =A0ARCH_OMAP2430 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SOC_OMAP2430
>> >> =A0 =A0ARCH_OMAP3430 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SOC_OMAP3430
>> >
>>
>> I was just about to post a patch for this, but you beat me
>> to it!
>>
>> > Signed-off-by: Thomas Weber <weber@corscience.de>
>>
>> Acked-by: Sourav Poddar <sourav.poddar@ti.com>
>
> Thanks, merging this into the original. Also adding
> applying into linux-omap master.
>

Aren't we breaking multi-omap build with this?

-V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
