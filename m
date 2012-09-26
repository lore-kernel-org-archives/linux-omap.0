From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv7 17/21] ARM: OMAP4: TWL: enable high speed mode for PMIC
 communication
Date: Wed, 26 Sep 2012 15:23:44 +0300
Message-ID: <5062F3D0.6040300@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>  <1348590833-12335-18-git-send-email-t-kristo@ti.com>  <5062E95C.6050903@ti.com> <1348661188.1956.1.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:51631 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755383Ab2IZMWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 08:22:36 -0400
Received: by obbuo13 with SMTP id uo13so457668obb.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 05:22:34 -0700 (PDT)
In-Reply-To: <1348661188.1956.1.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 09/26/2012 03:06 PM, Tero Kristo wrote:
> On Wed, 2012-09-26 at 14:39 +0300, Peter Ujfalusi wrote:
>> Hi Tero,
>>
>> On 09/25/2012 07:33 PM, Tero Kristo wrote:
>>> With the new parameters, I2C can now be put to high speed mode for
>>> better performance.
>>
>> We have twl6040 on the same bus. have you tried this with audio enab=
led?
>> twl6040 is in standard mode (up to 100 kbps) after power up...
>=20
> No, I don't have capability to try out audio. Can you give it a shot =
and
> see what happens? Otherwise we probably just have to drop this patch =
out
> for now.

Just compiled your mainline-3.6-rc5-omap-auto-ret-v7 branch with audio.
Works fine on my Blaze.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
