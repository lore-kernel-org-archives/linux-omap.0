From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Mon, 30 Jul 2012 16:51:02 +0200
Message-ID: <CABxcv=mDr1nuPR+QvQEnPcg8ROnj-7W=Q3xWVunTVB0L1sQbCw@mail.gmail.com>
References: <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com>
	<5012CC98.60206@ti.com>
	<20120727204447.GA10024@mudshark.cambridge.arm.com>
	<20120727210637.GA16377@n2100.arm.linux.org.uk>
	<20120727214024.GA10249@mudshark.cambridge.arm.com>
	<20120728100831.GC7405@n2100.arm.linux.org.uk>
	<20120728121103.GA11370@mudshark.cambridge.arm.com>
	<CABxcv=mVKt8+gYK6kHydmG3SnDZgjMbJuEcUBx_z5sumNY_SQw@mail.gmail.com>
	<20120729213125.GD7405@n2100.arm.linux.org.uk>
	<CABxcv=mSEEUbvMWS+JzjuPOWq9J7kNzvSyQRZibUXzNXstuV3A@mail.gmail.com>
	<20120730143550.GF7405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61904 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab2G3OvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 10:51:03 -0400
Received: by obbuo13 with SMTP id uo13so9069134obb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 07:51:02 -0700 (PDT)
In-Reply-To: <20120730143550.GF7405@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>, Jon Hunter <jon-hunter@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 30, 2012 at 4:35 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 30, 2012 at 11:22:51AM +0200, Javier Martinez Canillas wrote:
>> Yes, I forgot it, sorry for that.
>>
>> Please let me know if I need to resubmit the patch cc'ing stable.
>
> I can just add it to the commit.

Perfect, thanks a lot and sorry for missing that.

Best regards,
Javier
