From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap3: ehci: Add regulator framework
Date: Mon, 21 Dec 2009 14:17:29 +0200
Message-ID: <20091221121729.GK30969@nokia.com>
References: <19F8576C6E063C45BE387C64729E73940449F43F6A@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37128 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZLUMTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 07:19:35 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940449F43F6A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, Dec 21, 2009 at 12:35:38PM +0100, ext Gupta, Ajay Kumar wrote:
>> This looks OK from a regulator API point of view.
>
>Felipe,
>
>Any update on this patch? It=E2=80=99s already reviewed by Mark Brown.
>
>Please add this one to your queue if there are no comments on this.
>
>[1] http://marc.info/?l=3Dlinux-omap&m=3D125827476331516&w=3D2

thanks for reminding me about this one. I had lost it.

Applied now on [1]

[1] http://gitorious.org/usb/usb/commit/5ffe22e280c3dde0c844e30ccef45ab=
fcf1c3ccb

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
