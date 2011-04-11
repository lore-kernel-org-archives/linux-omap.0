From: Vladimir Pantelic <vladoman@gmail.com>
Subject: Re: HELP:dspbridge:how to configure GPT timer
Date: Mon, 11 Apr 2011 18:57:07 +0200
Message-ID: <4DA332E3.7000400@gmail.com>
References: <BANLkTin49cr76MXFUv6CZSs_-4v6=wL0Uw@mail.gmail.com> <BANLkTikzsrbi8EytVzm9ZA2djtrjnAAcmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46220 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab1DKQ5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2011 12:57:11 -0400
Received: by fxm17 with SMTP id 17so3715571fxm.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 09:57:10 -0700 (PDT)
In-Reply-To: <BANLkTikzsrbi8EytVzm9ZA2djtrjnAAcmQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: onlyfever <onlyfever@gmail.com>, linux-omap@vger.kernel.org

Ramirez Luna, Omar wrote:
> Hi,
>
> On Sat, Apr 9, 2011 at 7:38 AM, onlyfever<onlyfever@gmail.com>  wrote:
>>  Hi all!
>>  currently dsp make use of gpt 5, 6, 7 or 8.
>>  I'm using gpt 8 for something else.
>>  Is it possible to configure dsp-bridge to use other gpt timer?
>>  I want to change gpt 8 to gpt 9,or gpt 7.
>>  Please give me some advice.
>
> GPT8 is used for avsync on the dsp side, unfortunately there is no way
> to change this without dsp sources and the latter are not publicly
> available :/

Ah, didn't know that :( It's certainly not in use here for
anything dsp related and 720p codecs running fine...
