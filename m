From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Beagleboard xM - play video file : BUG: scheduling while atomic:
 queue1:src/92/0x0000008e , then kernel panic
Date: Thu, 25 Oct 2012 19:05:22 +0200
Message-ID: <CAMP44s36Sx4UJO24ZWsmrKv5KWybuHFiqXGMmXSv4SSa7D-f_g@mail.gmail.com>
References: <7fad4160-e437-4ea3-b140-4c98a04045f4@googlegroups.com>
	<8d3b5995-b3f7-406b-9172-b3187922dc75@googlegroups.com>
	<CAMP44s2JnoYHN0a-DQCnj-mtGbZK8q7iFBDFR4MQ4L0-n7DYPw@mail.gmail.com>
	<01a2f6b7-ee81-4653-b5f3-a53def9301ca@googlegroups.com>
	<1f842c9c-41cc-415f-ac31-30c85c7f6563@googlegroups.com>
	<CAMP44s137rkBirwX5smMLUnZe6eS0qft0RzO3=vNoDxKpZE_RQ@mail.gmail.com>
	<CAJ6Av5Mhn-Me0P3asve8NX00cRKONBL4fe7Pr59r4W-gd+kY+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42507 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202Ab2JYRFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 13:05:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1806876oag.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 10:05:22 -0700 (PDT)
In-Reply-To: <CAJ6Av5Mhn-Me0P3asve8NX00cRKONBL4fe7Pr59r4W-gd+kY+Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: Selso Liberado <selso.liberado@gmail.com>, gst-dsp@googlegroups.com, linux-omap@vger.kernel.org, Omar Ramirez Luna <or.rmz1@gmail.com>

On Thu, Oct 25, 2012 at 12:49 AM, Omar Ramirez Luna
<omar.ramirez@copitl.com> wrote:

> On Wed, Oct 24, 2012 at 10:34 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>> Selso, hopefully you don't mind, but I'll forward this to the
>> linux-omap mailing list, as this seems to be an interesting kernel
>> problem in tidspbridge.
>>
>> Omar, any ideas?
>
> I don't see tidspbridge trace paths (but I don't discard something
> wrong either ;)), however I do see a framebuffer, dss, dispc trace,
> might be a good point to start checking:

Oops, you are right.

>>> CONFIG_TIDSPBRIDGE_CACHE_LINE_CHECK=y
>
> I wasn't aware that now gst-dsp supported this, might be time to update mine.

Yes, it's supported now. Took me a lot of changes to manage to do it,
but it's there.

> Anyway, right now I have lots of debugging enabled and specifically
> the one that spits "scheduling while atomic" with kernel 3.7-rc2, and
> I'm not seeing this with the fakesink decode, and the encoder to a
> file, I don't have framebuffer nor display though.

It's probably a framebuffer problem =/

-- 
Felipe Contreras
