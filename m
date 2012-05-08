From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function.
Date: Tue, 8 May 2012 11:43:39 +0530
Message-ID: <CAMQu2gxeqbpO71xmTF3VLABC69kK19vhquakHfqHSVPf1zhTLg@mail.gmail.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-8-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1205072314480.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:50033 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437Ab2EHGOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 02:14:02 -0400
Received: by qabg27 with SMTP id g27so258247qab.14
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 23:14:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205072314480.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, R Sricharan <r.sricharan@ti.com>

On Tue, May 8, 2012 at 10:45 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 2 May 2012, Santosh Shilimkar wrote:
>
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> Instead of statically defining seperate arrays for every OMAP4+ archs,
>> have a generic init function to populate the arrays. This avoids the
>> need for creating new array for every arch added in the future that
>> reuses the prm and cm registers read/write code.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Thanks, looks reasonable, will queue this for 3.5.
>
Great. I will drop this one from my clean-up pull request.

Regards
Santosh
