From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: Re: [PATCH 1/2 v2] musb: Add context save and restore support
Date: Mon, 14 Dec 2009 12:49:49 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940437211088@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55515 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbZLNHT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 02:19:57 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>


>Adding support for MUSB register save and restore during system
>suspend and resume.
>
>Changes:
>=A0=A0=A0=A0=A0=A0=A0 - Added musb_save/restore_context() functions
>=A0=A0=A0=A0=A0=A0=A0 - Added platform specific musb_platform_save/res=
tore_context()
>=A0=A0=A0=A0=A0=A0=A0=A0=A0 to handle platform specific jobs.
>=A0=A0=A0=A0=A0=A0=A0 - Maintaining BlackFin compatibility by adding r=
ead/write
>=A0=A0=A0=A0=A0=A0=A0=A0=A0 functions for registers which are not avai=
lable in BlackFin
>
>Tested system suspend and resume on OMAP3EVM board.
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

> will we have another version of this patch ??

Yes, I need to resubmit this patch after fixing review comments.

-Ajay

--=20
balbi
--

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
