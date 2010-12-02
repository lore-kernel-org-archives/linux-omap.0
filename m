From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v8 00/11] OMAP: GPIO: Implement GPIO as platform device
Date: Thu, 2 Dec 2010 19:48:07 +0530
Message-ID: <AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <20101201183357.GI17222@atomide.com> <87zkso4hu3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57276 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757591Ab0LBOSs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 09:18:48 -0500
Received: by mail-iw0-f179.google.com with SMTP id 5so1334161iwn.38
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 06:18:47 -0800 (PST)
In-Reply-To: <87zkso4hu3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com

On Thu, Dec 2, 2010 at 15:28, Kevin Hilman <khilman@deeprootsystems.com> wrote:
> Tony Lindgren <tony@atomide.com> writes:
>
>> * Varadarajan, Charulatha <charu@ti.com> [101125 04:39]:
>>> Implement OMAP GPIO module in platform device model. OMAP2+ specific GPIO
>>> module uses hwmod FW.
>>>
>>> Tested on OMAP2430, OMAP4430, OMAP3430 SDP boards, OMAP4430 Blaze board
>>> and zoom3 board. Verified that this patch series does not break the OMAP1
>>> build.
>>
>> I've boot tested this on N800 + 5912OSK.
>>
>> I'll apply these patches into devel-gpio branch and start merging these
>> into linux-omap master branch and into for-next for the next merge window.
>>
>> I've also added one minor fix for 16xx, will post that separately.

Tony, thanks for the patch.

>
> Tony, you can also add
>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks Kevin.

>
> for this series, as v8 now looks good for me.
>
> Thanks Charu,
>
> Kevin
>
