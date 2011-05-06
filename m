From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH] OMAP PM: remove OMAP_PM_NONE config option
Date: Fri, 6 May 2011 20:43:39 +0200
Message-ID: <BANLkTimgrpKq_SrD=U9rzXspKv8eOcsv0w@mail.gmail.com>
References: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1105061016070.30136@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64012 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501Ab1EFSnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 14:43:40 -0400
Received: by qyg14 with SMTP id 14so2798442qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 11:43:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1105061016070.30136@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

Hi Paul,

On Fri, May 6, 2011 at 6:16 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Salut Jean
>
> On Fri, 6 May 2011, Jean Pihet wrote:
>
>> The current code base is not linking with the OMAP_PM_NONE
>> option set.
>> Since the option OMAP_PM_NOOP provides a no-op/debug layer,
>> OMAP_PM_NONE can be removed.
>> OMAP_PM_NOOP is enabled by default by Kconfig.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> I'm okay with this but could you please base it on v2.6.39-rc6 so I can
> merge it here?
I checked the patch against the master branch of both Tony's and
Linus's trees, it applies and compiles OK.
Is that OK to you?

Regards,
Jean

>
> thanks
>
>
> - Paul
>
