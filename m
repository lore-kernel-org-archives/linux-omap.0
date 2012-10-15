From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial
 stuff)
Date: Mon, 15 Oct 2012 09:37:30 +0200
Message-ID: <507BBD3A.4050706@ti.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk> <20121012162452.GD30339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55300 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab2JOHhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 03:37:41 -0400
In-Reply-To: <20121012162452.GD30339@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Afzal Mohammed <afzal@ti.com>

On 10/12/2012 06:24 PM, Tony Lindgren wrote:
>> twl6040-codec twl6040-codec: ASoC: Failed to create Capture debugfs =
file
>=20
> Peter, can you take a look please?

Patch to fix this has been already sent:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-September/055=
684.html

The same issue has been also fixed for twl4030:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-September/055=
683.html

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
