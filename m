From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v7 00/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Thu, 25 Nov 2010 10:01:46 +0530
Message-ID: <AANLkTi=wXjf9m-RTxnzTjP0H8EpjtG1529a6Ch2zbt6Z@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <87lj4i2nb2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59219 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751343Ab0KYEc1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 23:32:27 -0500
Received: by mail-iw0-f173.google.com with SMTP id 41so609961iwn.18
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 20:32:27 -0800 (PST)
In-Reply-To: <87lj4i2nb2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

Kevin,

On Thu, Nov 25, 2010 at 07:10, Kevin Hilman <khilman@deeprootsystems.co=
m> wrote:
> "Varadarajan, Charulatha" <charu@ti.com> writes:
>
>> Implement OMAP GPIO module in platform device model. OMAP2+ specific=
 GPIO
>> module uses hwmod FW.
>>
>> Tested on OMAP2430, OMAP44430, OMAP3430 SDP boards, OMAP4430 Blaze b=
oard
>> and zoom3 board. Verified that this patch series does not break the =
OMAP1
>> build.
>>
>> Version History:
>> ---------------
>> v7 Series:
>> - Use gpio iclks as main_clk in OMAP3 & OMAP4
>> - Implement GPIO as a platform device (use hwmod FW for OMAP2+)
>> =A0and the implementation is similar to current GPIO code. Does not
>> =A0modify the gpio suspend/ resume/ prepare for odle and resume afte=
r
>> =A0idle code and these modifications would be done in a separate pat=
ch
>> =A0series. This was suggested by Kevin in another internal email thr=
ead.
>
> OK, I'm ready to merge this series, and we can deal with the runtime =
PM
> conversion in another series as that's where the tricky part lies.

Thanks.

>
> However, I'd like one more rebase/retest due to some other dependenci=
es.
> Can you rebase/retest using my current pm-core branch?

Sure I will do that.

> That includes
> several dependencies that are also targetted for 2.6.38:
>
> - misc. PM fixes
> - i2c hwmod + runtime PM conversion (my pm-hwmod-i2c branch)
> - several board file changes/updates (Tony's devel-board branch)
> - hwmod core fixes (Paul's hwmod_a_2.6.38 branch)
> - wdt hwmod cleanups (Paul's wdt_2.6.38 branch)
>
> Also, can you collect the acks from Beno=EEt and update your changelo=
gs to
> include them. =A0Thanks.

Sure.

>
> Please be sure your board file changes are updated for the board file
> changes in the devel-board branch.

Okay. But if it is different, should I send only the board files change=
s on
devel-board  branch as a separate patch mentioning the dependencies on
my patch series?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
