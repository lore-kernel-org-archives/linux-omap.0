From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/7] ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4
 only builds.
Date: Tue, 8 May 2012 11:39:41 +0530
Message-ID: <CAMQu2gytRtL1p1jbnMM0rcem4crQycr0Y5DY4V_Ar5hCTh9ZBA@mail.gmail.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1205072309190.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:35323 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437Ab2EHGKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 02:10:03 -0400
Received: by qcsk26 with SMTP id k26so107273qcs.26
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 23:10:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205072309190.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Tue, May 8, 2012 at 10:39 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 2 May 2012, Santosh Shilimkar wrote:
>
>> Since OMAP4 code base now makes use of OMAP4 specific PRCM functions,
>> cm2xxx_3xxx.c need not be compiled for OMAP4 only builds.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
> Will remove the stub functions in a separate patch.
>
ok
