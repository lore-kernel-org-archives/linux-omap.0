From: Nick Krause <xerofoify@gmail.com>
Subject: Re: Nokia N900 FB regression?
Date: Tue, 22 Jul 2014 18:02:37 -0400
Message-ID: <CAPDOMVhwSAvbkHwwdM6wkV25MpKfZ=1m_QafFfdCRZtavGuFpw@mail.gmail.com>
References: <20140722212318.GC2615@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:56376 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbaGVWCi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2014 18:02:38 -0400
Received: by mail-vc0-f172.google.com with SMTP id im17so614988vcb.3
        for <linux-omap@vger.kernel.org>; Tue, 22 Jul 2014 15:02:37 -0700 (PDT)
In-Reply-To: <20140722212318.GC2615@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

On Tue, Jul 22, 2014 at 5:23 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> Somewhere between 3.16-rc2 and rc6 (I was on holidays...) I noticed
> the framebuffer stopped working on N900 (nothing on screen).
>
> I bisected this to 9188883fd66e9809e93e06d5bbd49cf99a6cdbee (ARM: dts:
> Enable twl4030 off-idle configuration for selected omaps).
> With this commit reverted, I can see the Tux again with 3.16-rc6.
>
> Any ideas?
>
> A.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


I am new to the kernel but I can take a look into this this commit.
Cheers Nick
