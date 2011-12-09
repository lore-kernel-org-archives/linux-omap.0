From: Omar Ramirez Luna <or.rmz1@gmail.com>
Subject: Re: In-band Error seen by IVA_SS at address 0
Date: Thu, 8 Dec 2011 20:01:51 -0600
Message-ID: <CAPTm=KH9+BqnPoVqpP_bdj=G66-Z-KZ0XwD7QzQDud+X6OaMug@mail.gmail.com>
References: <CAMP44s2nRzCXJdv3iHjSk0H_pkhb2DtXZ8cQJ61t6o0Ff=vc=Q@mail.gmail.com>
	<CAMP44s0B1GLsiduFJZs5QpJuWoMz7P7pLGxofLgeZGzg6aDYmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47800 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1LICBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 21:01:51 -0500
Received: by mail-gy0-f174.google.com with SMTP id z2so2116671ghb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 18:01:51 -0800 (PST)
In-Reply-To: <CAMP44s0B1GLsiduFJZs5QpJuWoMz7P7pLGxofLgeZGzg6aDYmw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Dec 8, 2011 at 12:50 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Dec 8, 2011 at 8:43 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I get this while loading the bridgedriver:
>
> Agh, Gmail garbled that.
> http://pastie.org/pastes/2987239/text

Missed this email, when replying from irc, so, just for the record:

This is caused because the dsp firmware tries wdt register when that
clock is not powered on. It doesn't affect functionally but does look
nasty, I'll post a fix for that hope you can review it.

As for: ERR: clock id 2 already disabled

Seems like the module was removed after the dsp went to hibernation,
when the gpt6 was already disabled, no functional issue but it does
look misleading, I'll see what can I do about it.

Thanks for the report,

Regards,

Omar
