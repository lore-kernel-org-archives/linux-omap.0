From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for save_secure_all
Date: Mon, 21 May 2012 15:13:17 +0530
Message-ID: <CAMQu2gw4XwO_pAHnHNzwY_xQ4_tHS7a3iAFMxLL1ddV8xHwPvg@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-15-git-send-email-t-kristo@ti.com> <871umj4qnl.fsf@ti.com> <1337593097.28274.19.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:33146 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752367Ab2EUJnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:43:40 -0400
Received: by qcso7 with SMTP id o7so3093572qcs.6
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:43:38 -0700 (PDT)
In-Reply-To: <1337593097.28274.19.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Mon, May 21, 2012 at 3:08 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-05-16 at 17:06 -0700, Kevin Hilman wrote:
>> +Benoit
>>
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
>> > otherwise the secure ROM code will crash.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>
>> I think I mentioned this already (I'm already lost in what I've said for
>> thisseries), but I don't think the secure RAM stuff belongs in the
>> wakeupgen driver.
>
> As mentioned, save_secure_all saves:
> - secure RAM
> - GIC registers
> - some other mysterious stuff
(mysterious:  Entire firewall registers )

Regards
Santosh
