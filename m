From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 21:50:58 +0530
Message-ID: <CAJe_ZhceO8TabHVZZ7BLqYE-EAhtSJxzwWv8eA7KfffSK_dxXQ@mail.gmail.com>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	<1340869729.5037.7.camel@deskari>
	<CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	<1340878461.5037.30.camel@deskari>
	<CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	<CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	<1340881815.5037.53.camel@deskari>
	<4FEC47FA.1040801@linaro.org>
	<CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
	<1340890278.5037.91.camel@deskari>
	<CAJe_ZheBbj3qoECDokcxHsB4UOx354G5t_MfYiZ3UEm9xK=tqw@mail.gmail.com>
	<1340897244.5037.140.camel@deskari>
	<CAJe_Zhdnc8TOY8hDiuZfjto9fTWnT8piGpjczApzfLVMnCcE7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40764 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261Ab2F1QVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 12:21:00 -0400
Received: by lbbgm6 with SMTP id gm6so3300261lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 09:20:58 -0700 (PDT)
In-Reply-To: <CAJe_Zhdnc8TOY8hDiuZfjto9fTWnT8piGpjczApzfLVMnCcE7w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andy Green <andy.green@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 21:18, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 28 June 2012 20:57, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

>>> > By the way, when the device is in system suspend, we surely won't detect
>>> > the HPD even if we kept the HPD always enabled. So there we'll miss the
>>> > HPD interrupt anyway, and the EDID cache would be invalid.
>>> >
>>> If omapdss already handles the possibility of display changed during
>>> suspend, I think we should be good :)
>>
>> Hmm I'm not sure I understand what you mean. I was referring to your
>> patch, which invalidated the EDID cache only on HPD interrupt when the
>> cable is unplugged. And we'd miss that interrupt when the board is in
>> system suspend, even if we otherwise kept the HPD interrupt always
>> enabled.
>>
> I meant before stale-edid, we face potential problem of omapdss
> behaving badly to the displays switched during suspend ?
>
OK, I think I get now what you mean. We do need to invalidate
edid-cache in the suspend path, irrespective of how omapdss behaves.

Thanks.
