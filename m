From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [spi-devel-general] [PATCH 1/3] [SPI] [OMAP] Add OMAP spi100k
	driver
Date: Sun, 6 Dec 2009 22:36:01 -0800
Message-ID: <6cb013310912062236p1914a979i76f846e00ee5c32@mail.gmail.com>
References: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
	<1260161299-17656-2-git-send-email-darkstar6262@gmail.com>
	<1b68c6790912062133kdc901dcnbb043ce14fc1049@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:56090 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbZLGGgO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 01:36:14 -0500
Received: by pxi14 with SMTP id 14so1433067pxi.22
        for <linux-omap@vger.kernel.org>; Sun, 06 Dec 2009 22:36:21 -0800 (PST)
In-Reply-To: <1b68c6790912062133kdc901dcnbb043ce14fc1049@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Sun, Dec 6, 2009 at 9:33 PM, jassi brar <jassisinghbrar@gmail.com> w=
rote:

> setting master->cleanup =3D NULL shud do
>
> how about dropping it altogether?
>
> no need for cleanup callback if u have nothing to do in _close.
>
> no need of {}
>
> =C2=A0the status shud default to -EINPROGRESS, not success.
>
> In remove you might want to wait for mssg queue to be flushed?
>

All good points.  I'll make my corrections and resubmit.

Thanks
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
