From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv2 1/3] OMAP UART: Add omap-serial driver support.
Date: Wed, 28 Oct 2009 17:00:47 +0530
Message-ID: <d6a0f7aa0910280430l67a8f7c8j662abcd81210bf7e@mail.gmail.com>
References: <35817.192.168.10.88.1256713979.squirrel@dbdmail.itg.ti.com>
	 <1256724939.31246.69.camel@kauppi-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:65416 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbZJ1Lam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 07:30:42 -0400
Received: by qyk4 with SMTP id 4so394686qyk.33
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 04:30:47 -0700 (PDT)
In-Reply-To: <1256724939.31246.69.camel@kauppi-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> + =A0 =A0 =A0 xoff2 =3D serial_in(up, UART_XOFF2);
>> + =A0 =A0 =A0 uasr =3D serial_in(up, UART_OMAP_UASR);
>
> Where is UART_OMAP_UASR defined? I did not find it in linux-omap.

Oops.. my bad... will correct it..

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
