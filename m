From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: g_ether broken on musb
Date: Fri, 8 Oct 2010 10:12:52 +0800
Message-ID: <AANLkTintN9anKx1JVGVjusyEX9Q9cr-Bo_oiNdkvwa_m@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
	<AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com>
	<AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65244 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0JHCMy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 22:12:54 -0400
In-Reply-To: <AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

2010/10/8 Grazvydas Ignotas <notasas@gmail.com>:
>>> Looks like the transfers get mixed somehow? Curiously after replugg=
ing
>>> the cable several times it starts working properly, however the
>>> problem comes back reliably after each reboot.
>>
>> Please apply the patch below against -next tree to see if
>> your issue can be fixed:
>>
>> =A0 =A0 =A0 http://marc.info/?l=3Dlinux-usb&m=3D128576494214316&w=3D=
2
>>
>
> Doesn't seem to help:

I have tried patch-v2.6.36-rc6-next-20101006 on my beagle B5, seems
no such problem.

Are your musb working at fullspeed?  I know musb at fullspeed has bee
broken for some time.

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
