From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() variants
Date: Wed, 27 Aug 2014 12:16:38 -0500
Message-ID: <CAGo_u6pZiyJ8574YUXvg_Pz_P=LDeot-kFh7NQJBUqgwsR+Fmw@mail.gmail.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com>
	<1406523237-6905-2-git-send-email-lokeshvutla@ti.com>
	<alpine.DEB.2.02.1407280529320.24161@utopia.booyaka.com>
	<53D5E0F4.3080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:49002 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935287AbaH0RQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2014 13:16:39 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so654613iec.22
        for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2014 10:16:39 -0700 (PDT)
In-Reply-To: <53D5E0F4.3080607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 28, 2014 at 12:34 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> On Monday 28 July 2014 10:59 AM, Paul Walmsley wrote:
>> On Mon, 28 Jul 2014, Lokesh Vutla wrote:
>>
>>> From: Rajendra Nayak <rnayak@ti.com>
>>>
>>> Use the corresponding compatibles to identify the devices.
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> Acked-by: Nishanth Menon <nm@ti.com>
>>> Tested-by: Nishanth Menon <nm@ti.com>
>>
>> Thanks, queued for (hopefully) early v3.17-rc.
> Thanks Paul.
>
Paul, Tony,

we are at 3.17-rc2 today, unfortunately..
http://slexy.org/view/s20MbRgipa dra72-evm is still broken due to
this. Needs:
https://patchwork.kernel.org/patch/4632161/ and
https://patchwork.kernel.org/patch/4632171/

What can we do to help speed this along?
-- 
---
Regards,
Nishanth Menon
