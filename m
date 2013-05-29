From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2] usb: musb: fix clock naming
Date: Wed, 29 May 2013 11:51:54 +0200
Message-ID: <CAGm1_kt2UzOf1o6yGVaifqJpU0hySdW+gzsdSw_qsO9vG_UZ1w@mail.gmail.com>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
 <20130528173637.GE15794@arwen.pp.htv.fi> <1369820164.6673.55.camel@polaris.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:40639 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965107Ab3E2JwQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 05:52:16 -0400
In-Reply-To: <1369820164.6673.55.camel@polaris.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-usb <linux-usb@vger.kernel.org>, kishon@ti.com

On Wed, May 29, 2013 at 11:36 AM, Jan L=C3=BCbbe <jlu@pengutronix.de> w=
rote:
> On Tue, 2013-05-28 at 20:36 +0300, Felipe Balbi wrote:
>> On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists@googlemail.com=
 wrote:
>> > From: Yegor Yefremov <yegorslists@googlemail.com>
>> >
>> > 'ick' was changed to 'hsotgusb_ick'
>> > 'fck' was changed to 'hsotgusb_fck'
>> >
>> > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> NAK. Fix your clock data.
>
> Yegor, I'm not sure how my signed-off-by got here. It seems that you
> picked the patch up from this thread:
> http://marc.info/?l=3Dlinux-omap&m=3D134390141101734
>
> Note that my mail contains no signed-off-by and the change is describ=
ed
> as a work around.

I'll remove your SoB, when I post the next version. I just added it,
because you provided the fix. Will contact you next time first. Have
you worked on this SoC lately? Any pending patches?

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
