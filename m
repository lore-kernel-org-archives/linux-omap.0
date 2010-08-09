From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: [PATCH] OMAP3 PM: fix the error messages printed when the system
	suspend
Date: Mon, 9 Aug 2010 17:29:13 -0400
Message-ID: <AANLkTi=Dud9H_1TUD6egOtAUaSYzqyqsMP3=3Sj9YWjZ@mail.gmail.com>
References: <1277195484-5501-1-git-send-email-stanley.miao@windriver.com>
	<87iq5bm7ac.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43977 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756880Ab0HIV3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 17:29:15 -0400
Received: by wwf26 with SMTP id 26so2905528wwf.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 14:29:13 -0700 (PDT)
In-Reply-To: <87iq5bm7ac.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

On Tue, Jun 22, 2010 at 11:11 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Stanley.Miao" <stanley.miao@windriver.com> writes:
>
> First, the subject needs to be more descriptive:
>
> OMAP3: AM3505/3517 do not have IO wakeup capability

Functionally, what does this statement mean?  The 3503 seems to have
the EN_IO [8] bit, but I've yet to figure out what the EN_IO_CHAIN
[16] means.

Thanks,
Cliff
