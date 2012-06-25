From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Mon, 25 Jun 2012 12:31:00 +0200
Message-ID: <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org>
 <20120625005134.GA2342@S2101-09.ap.freescale.net> <20120625084905.GD19226@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45060 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab2FYKbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 06:31:21 -0400
Received: by yenl2 with SMTP id l2so2637190yen.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 03:31:21 -0700 (PDT)
In-Reply-To: <20120625084905.GD19226@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 25, 2012 at 10:49 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 25, 2012 at 08:51:37AM +0800, Shawn Guo wrote:
>> It seems the same patch has been there for a while.
>>
>> http://thread.gmane.org/gmane.linux.kernel/1303115
>
> Bah, why doesn't stuff like this get resent if nothing has happened for
> a while?

Indeed. At least other people that face the same issue (like me) sends
similar patches to remind you :-)

Best regards,
Javier
