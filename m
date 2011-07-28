From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: musb crash on suspend
Date: Thu, 28 Jul 2011 17:32:14 -0400
Message-ID: <CAOd_LFyqTk8F_nVBo2w+dhLgormMY85nczHCoewAbEN95Fnqpg@mail.gmail.com>
References: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com>
	<CAFm6cryzdBT0XF7w3PzGU=BZ0h_T3gF6ogN8ijqv8hd50DE7Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47333 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab1G1VcQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 17:32:16 -0400
Received: by gyh3 with SMTP id 3so2151780gyh.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 14:32:15 -0700 (PDT)
In-Reply-To: <CAFm6cryzdBT0XF7w3PzGU=BZ0h_T3gF6ogN8ijqv8hd50DE7Gw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Haslam, Axel" <axelhaslam@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Jul 28, 2011 at 5:12 PM, Haslam, Axel <axelhaslam@ti.com> wrote=
:
> Cliff,
> Im not sure if you have are seeing the same issue, but maybe somethin=
g
> like this may help:
> commit 39b7060345141b3ed2567fc6bc104ccab545fc0e
> Author: Axel Haslam <axelhaslam@ti.com>
> Date: =A0 Thu Jun 2 16:35:44 2011 -0500
> =A0 =A0 MUSB: Dont save context, if driver is suspended by runtime
> =A0 =A0 Doing a save context on the suspend handler when
> =A0 =A0 the clock are cut by runtime_pm, will cause
> =A0 =A0 data aborts.

That seems to have fixed it.  Thank you very much!

Cliff

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
http://bec-systems.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
