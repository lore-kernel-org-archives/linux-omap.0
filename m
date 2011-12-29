From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Thu, 29 Dec 2011 23:25:50 +0200
Message-ID: <CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
	<20111210082741.GA32605@earth.universe>
	<CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
	<20111229183712.GB32392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42959 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab1L2VZv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Dec 2011 16:25:51 -0500
Received: by eaad14 with SMTP id d14so6187437eaa.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Dec 2011 13:25:50 -0800 (PST)
In-Reply-To: <20111229183712.GB32392@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Thu, Dec 29, 2011 at 8:37 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Dec 10, 2011 at 05:59:57PM +0200, Felipe Contreras wrote:
>
>> It was not working for me, but it seems the problem was related to
>> mdev/udev; snd_soc_tlv320aic3x has to be loaded before snd-soc-rx51.
>
> That should not be required, the modules should be loadable in any
> order.

Are you sure? I recall having a similar discussion with Rusell King,
and the conclusion is that certain modules are supposed to be loaded
by udev at boot time, and it seems snd_soc_tlv320aic3x is one of them.

-- 
Felipe Contreras
