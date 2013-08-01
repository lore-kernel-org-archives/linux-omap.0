From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 09/33] CLK: omap: add omap4 clock init file
Date: Thu, 1 Aug 2013 11:10:55 -0500
Message-ID: <CAGo_u6qze7SaCdTrqhby0guKu03DcRVchkV-qmT4uz2PgJMYHQ@mail.gmail.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
	<1374564028-11352-10-git-send-email-t-kristo@ti.com>
	<51F81516.3050302@ti.com>
	<51F924CA.6000803@ti.com>
	<51FA7341.7040303@ti.com>
	<51FA7FFB.8000309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:39859 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab3HAQK5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 12:10:57 -0400
In-Reply-To: <51FA7FFB.8000309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Aug 1, 2013 at 10:34 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>
>> I think you already dealt with (c). in the same vein, we can do (a) and
>> (b). Dont think anyone else has gone about this to the extent we are
>> attempting to do till date, so as pioneers, we might as well suggest
>> with a patch :D ?
>
>
> Yea, for c I have a patch as that is clearly required. For a/b, we can
> currently workaround. Again, I don't want to implement everything in this
> set at once, as the result would be a huge behemoth (this is complicated
> enough as is imo.)
this series will be smaller if you do it, not larger. you would just
need to introduce those parameters and not have to deal with SoC
specific "hacky drivers".
Regards,
NM
