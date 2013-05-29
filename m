From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2] usb: musb: fix clock naming
Date: Wed, 29 May 2013 12:06:52 +0200
Message-ID: <CAGm1_ks7Y8n1xKA=qiCCFcxgydRiyeJS08A8TPnbnEEmkJxVyg@mail.gmail.com>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com> <20130528173637.GE15794@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:51402 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230Ab3E2KHO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 06:07:14 -0400
In-Reply-To: <20130528173637.GE15794@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-usb <linux-usb@vger.kernel.org>, kishon <kishon@ti.com>, Jan Luebbe <jlu@pengutronix.de>

On Tue, May 28, 2013 at 7:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> 'ick' was changed to 'hsotgusb_ick'
>> 'fck' was changed to 'hsotgusb_fck'
>>
>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>
> NAK. Fix your clock data.

Do you mean here arch/arm/mach-omap2/cclock3xxx_data.c?

Yegor
