From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 21:18:07 +0530
Message-ID: <CAJe_Zhdnc8TOY8hDiuZfjto9fTWnT8piGpjczApzfLVMnCcE7w@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51656 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2F1PsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 11:48:09 -0400
Received: by lbbgm6 with SMTP id gm6so3263483lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 08:48:08 -0700 (PDT)
In-Reply-To: <1340897244.5037.140.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andy Green <andy.green@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 20:57, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Thu, 2012-06-28 at 20:44 +0530, Jassi Brar wrote:

>> it has, some user action should enable it while 'making the device
>> ready for new display'.
>> IOW, how do you envision an OMAP4 based tablet with HDMI port react to
>> display connections ?
>
> I guess this was covered in my mail about the phone's HDMI. If the
> tablet is unlocked, and I plug in a HDMI cable, I expect the device to
> do something. Either clone the display, or perhaps ask me what I want to
> do.
>
> So yes, HPD would be always enabled, when the tablet is active
> (unlocked).
>
OK, somehow I was under impression you didn't wanna spare even the 5V+ floating.
Though there could also be some option in settings to enable 5/HPD
only when the user is about the connect a display... so that the
activate window is even narrowed down. Anyway... I am glad we are in
sync.

>> > By the way, when the device is in system suspend, we surely won't detect
>> > the HPD even if we kept the HPD always enabled. So there we'll miss the
>> > HPD interrupt anyway, and the EDID cache would be invalid.
>> >
>> If omapdss already handles the possibility of display changed during
>> suspend, I think we should be good :)
>
> Hmm I'm not sure I understand what you mean. I was referring to your
> patch, which invalidated the EDID cache only on HPD interrupt when the
> cable is unplugged. And we'd miss that interrupt when the board is in
> system suspend, even if we otherwise kept the HPD interrupt always
> enabled.
>
I meant before stale-edid, we face potential problem of omapdss
behaving badly to the displays switched during suspend ?
