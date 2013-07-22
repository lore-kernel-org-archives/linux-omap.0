From: Roger Quadros <rogerq@ti.com>
Subject: Re: pandaboard usb ethernet failed to connect to network
Date: Mon, 22 Jul 2013 11:20:40 +0300
Message-ID: <51ECEB58.8070406@ti.com>
References: <SNT131-W35E1FF7C785E6D1ADA69BE86E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab3GVIUn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jul 2013 04:20:43 -0400
In-Reply-To: <SNT131-W35E1FF7C785E6D1ADA69BE86E0@phx.gbl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?GB2312?B?t8Yg0Ow=?= <xufei_wh@hotmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On 07/22/2013 11:17 AM, =B7=C6 =D0=EC wrote:
> Hi all:
>=20
> I met a problem about USB Ethernet on panda board with kernel 3.10 . =
 USB Ethernet can be detected  when device tree enabled but failed to c=
onnect to network.

We don't yet support USB Host on panda with DT boot on 3.10.  It should=
 work with non-DT boot.

It will work on 3.11-rc1 with this patch on top https://lkml.org/lkml/2=
013/6/18/492

Hopefully it should work out of the box from 3.11-rc2 onwards.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
