From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Sat, 10 Dec 2011 17:59:57 +0200
Message-ID: <CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
	<20111210082741.GA32605@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40136 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab1LJP76 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Dec 2011 10:59:58 -0500
Received: by dajs34 with SMTP id s34so557354daj.19
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 07:59:58 -0800 (PST)
In-Reply-To: <20111210082741.GA32605@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Sat, Dec 10, 2011 at 10:27 AM, Sebastian Reichel <sre@debian.org> wrote:
> Using RX51 audio as module works on 3.1 mainline kernel after loading
> the following modules:
>
> $ modprobe snd-soc-rx51
> $ modprobe snd-soc-omap

It was not working for me, but it seems the problem was related to
mdev/udev; snd_soc_tlv320aic3x has to be loaded before snd-soc-rx51.

Cheers.

-- 
Felipe Contreras
