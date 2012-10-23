From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 23 Oct 2012 21:23:03 +0200
Message-ID: <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
	<alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
	<alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
	<CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
	<CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
	<alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54691 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875Ab2JWTXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 15:23:04 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5848353iea.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 12:23:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: balbi@ti.com, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Tue, Oct 23, 2012 at 9:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 22 Oct 2012, Jean Pihet wrote:
>
>> On Mon, Oct 22, 2012 at 6:12 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>>
>> > Do you have CPU_IDLE enabled?
>> FYI the issue is not present with CPU_IDLE enabled.
>
> Hmm, how can you tell?  I thought you weren't able to reproduce it with
> CPU_IDLE disabled either?
I could not reproduce the issue, with and without CPU_IDLE enabled.
What puzzles me is that the PM QoS code only has influence on the
states chosen by cpuidle, so the change should not have any impact
with CPU_IDLE enabled. I reallt need to reproduce the issue.
Let me try with the same setup as yours (bootloader images,
omap2pus_defconfig, angstrom roots).

Regards,
Jean

>
>
> - Paul
