From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Patch 1/8] DSPBRIDGE: typedef cleanup -DSP RTOS
Date: Thu, 4 Feb 2010 02:28:19 +0200
Message-ID: <94a0d4531002031628o3a38fb28n46c800b06b742472@mail.gmail.com>
References: <19F8576C6E063C45BE387C64729E7394044A6B9671@dbde02.ent.ti.com>
	 <496565EC904933469F292DDA3F1663E602AA5737A9@dlee06.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E7394044A775BE9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f201.google.com ([209.85.223.201]:52399 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab0BDA2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:28:19 -0500
Received: by iwn39 with SMTP id 39so2332399iwn.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:28:19 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A775BE9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Feb 4, 2010 at 2:24 AM, Hebbar, Shivananda <x0hebbar@ti.com> wr=
ote:
>> Why was it changed to long and not to unsigned int as it as defined =
before
>> (u32) or int which is the tiye return by Atoi?
> I didn't understand your question here.
> =C2=A0Long and int are both signed 32 bit type.

Not on all platforms. I guess this code is not going to be used on
some 64 bit OMAP, but one can never know :P

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
