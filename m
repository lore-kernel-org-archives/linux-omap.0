From: Barry Song <21cnbao@gmail.com>
Subject: Re: Shouldn't DT preserve pdev name and id to allow platform_match to work?
Date: Fri, 5 Aug 2011 18:02:30 +0800
Message-ID: <CAGsJ_4x7LWRGWXsWzMG1FxZPaFYiKSUpSac2PdwH=d6vqFWRfw@mail.gmail.com>
References: <4E396361.3060307@ti.com> <CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62495 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1HEKCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 06:02:51 -0400
Received: by fxh19 with SMTP id 19so2663002fxh.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 03:02:50 -0700 (PDT)
In-Reply-To: <CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> auxdata passes platform_data and overrides the device name when there
> is no way easy way to make the driver work without it. =C2=A0It handl=
es the
> the current implementation of clocks and regulators which aren't yet
> populated from the device tree. =C2=A0It will go away when clock &
> regulator bindings are implemented.
Yes. As OF_DEV_AUXDATA_ID still requires hardware information like
0x48000100 as below, it seems it is not
consistent with the origin purpose of ARM DT.
OF_DEV_AUXDATA_ID("ti,omap-i2c", 0x48000100, "omap-i2c.1", 1, &i2c_pdat=
a)
And the information 0x48000100 is something that doesn't want to be in
kernel codes.it should be only in dts.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
