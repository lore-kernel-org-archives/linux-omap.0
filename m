From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 12:30:46 +0100
Message-ID: <AANLkTikUkA=Uwd+UGStdiuV_LCBLZaKo4KRp2bj_UwH3@mail.gmail.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
	<21f7524db02d0a4c2a9f71587937d200@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42816 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab0KVLar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 06:30:47 -0500
Received: by qyk11 with SMTP id 11so97548qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:30:46 -0800 (PST)
In-Reply-To: <21f7524db02d0a4c2a9f71587937d200@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Mon, Nov 22, 2010 at 11:53 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jean Pihet
>> Sent: Monday, November 22, 2010 4:15 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Jean Pihet; Kevin Hilman
>> Subject: [PATCH] OMAP3: disable idle early in the suspend sequence
>>
>> Some bad interaction between the idle and the suspend paths has been
>> noticed: the idle code is called during the suspend enter and exit
>> sequences. This could cause corruption or lock-up of resources.
>
> Can you elaborate more on what kind of issues were seen?

Trying to get the PRCM registers dump after a suspend/resume does not
show the correct registers values, cf. Kevin's patch at
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commitdiff;h=9fc4891d4a21d2b644a463d62c77ef97da55f091.

Digging a bit further I found out that the idle routine is called >50
times while the suspend/resume sequence still is on-going. The root
cause is because disable_hlt is called from omap3_pm_prepare which
runs after omap3_pm_begin (and the same issue in the resume sequence).
This leaves a time window for idle to kick-in while the suspend
sequence is busy saving/restoring the system state. This is a
potential bug that just waits to show up soon or later, especially if
more code is added in the suspend prepare and finish functions.

Does the changelog need an update?

Regards,
Jean
