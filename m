From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/2] hwspinlock/omap: enable module before reading
 SYSSTATUS register
Date: Sun, 27 Jul 2014 13:50:35 +0300
Message-ID: <CAK=WgbbthPvZ5exv9tTc5hTpFgM6sd0BHWkqRpZqJp8-9Am9uA@mail.gmail.com>
References: <1404342060-2919-1-git-send-email-s-anna@ti.com>
 <1404342060-2919-2-git-send-email-s-anna@ti.com> <CAK=Wgba3OOgZG_smj5=raE+ZXZ-F0ksn4pcGeDc1JDE34Q-wFg@mail.gmail.com>
 <53D122A1.4040204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:51020 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbaG0Ku4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Jul 2014 06:50:56 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so2515709igq.1
        for <linux-omap@vger.kernel.org>; Sun, 27 Jul 2014 03:50:55 -0700 (PDT)
In-Reply-To: <53D122A1.4040204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Jul 24, 2014 at 6:13 PM, Suman Anna <s-anna@ti.com> wrote:
>> Is there a specific reason for using the put_sync variant here? If
>> not, let's just use the regular put().
>
> There was no particular reason, you can change it.

Thanks for confirming. I've applied both patches to remoteproc's
for-next branch.

Thanks,
Ohad.
