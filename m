From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: Re: [RFC PATCHv5 0/7] HSI framework and drivers
Date: Wed, 15 Jun 2011 12:27:03 +0300
Message-ID: <1308130023-20667-1-git-send-email-Andras.Domokos@nokia.com>
References: <1307713124-3946-1-git-send-email-carlos.chinea@nokia.com>, <20110614103548.3b336dac@lxorguk.ukuu.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:62628 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab1FOJ1q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 05:27:46 -0400
In-Reply-To: <20110614103548.3b336dac@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sre@debian.org, linus.walleij@linaro.org, govindraj.ti@gmail.com, pawel.szyszuk@stericsson.com, sjur.brandeland@stericsson.com, peter_henn@gmx.de, Carlos Chinea <carlos.chinea@nokia.com>, Andras Domokos <Andras.Domokos@nokia.com>

Hi,

On 01/-10/-28163 09:59 PM, ext Alan Cox wrote:
> On Fri, 10 Jun 2011 16:38:37 +0300
> Carlos Chinea <carlos.chinea@nokia.com> wrote:
>
>> Hi !
>>
>> Here you have the fifth round of the HSI framework patches.
>
> Looks good to me - only other oddity I found is to build hsi_char on x86
> you need slab.h before kmemleak.h or the build errors

We checked with Carlos why hsi_char was building for the ARM
architecture in our environment.
We found the reason, it was a kernel configuration issue after all, we
didn't have CONFIG_DEBUG_KMEMLEAK option enabled in our .config file,
that's why the oddity you have mentioned didn't show up in our case. But
once the kernel option was turned on, we started seeing the compilation
errors.

We'll fix the problem based on your comments.

Thank you!

Regards,
Andras
