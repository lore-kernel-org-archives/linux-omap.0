From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: sleep: byteswap data for big-endian
Date: Tue, 14 Jan 2014 13:14:28 +0200
Message-ID: <CAArO44samX_uMeC93w4DBbC+yskEmrvVt_i-5VV_seatM56ypw@mail.gmail.com>
References: <1389625399-24087-1-git-send-email-taras.kondratiuk@linaro.org>
	<52D404DE.2020806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:64816 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaANLO3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 06:14:29 -0500
Received: by mail-bk0-f47.google.com with SMTP id mx12so177445bkb.34
        for <linux-omap@vger.kernel.org>; Tue, 14 Jan 2014 03:14:28 -0800 (PST)
In-Reply-To: <52D404DE.2020806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Patch Tracking <patches@linaro.org>, Linaro Networking <linaro-networking@linaro.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, Victor Kamensky <victor.kamensky@linaro.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

On 13 January 2014 17:23, Nishanth Menon <nm@ti.com> wrote:
> On 01/13/2014 09:03 AM, Taras Kondratiuk wrote:
>> From: Victor Kamensky <victor.kamensky@linaro.org>
>>
>> Assembler functions defined in sleep44xx.S need to byteswap values
>> after read / before write from h/w register if code compiled in big
>> endian mode. Simple change to do 'rev x, x' before str instruction
>> and after ldr instruction that deals with h/w registers.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
>> ---
>> This is a part of RFC series [1].
>> Based on v3.13-rc8.
>>
>> [1] http://www.spinics.net/lists/linux-omap/msg99927.html
>>
>>  arch/arm/mach-omap2/sleep44xx.S |   17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>
> OMAP4 is LE, and if there is a gcc flag for the same, is'nt it cleaner
> to deal with it in Makefile rather than trying to make an assembly
> meant only for LE by force building it for BE?

Hi Nishanth
I'm not sure I got your point.
Do you propose to build this file as LE while the rest of kernel is BE?

-- 
Regards,
Taras Kondratiuk
