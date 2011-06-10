From: =?iso-8859-1?q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: HELP:How to power down TWL5030 Voice/Bluetooth sidetone PGA?
Date: Fri, 10 Jun 2011 10:48:45 +0300
Message-ID: <201106101048.45966.peter.ujfalusi@ti.com>
References: <BANLkTik0mX5wSYNdBwhjxuaKa6908fmazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57752 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1FJHs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 03:48:58 -0400
In-Reply-To: <BANLkTik0mX5wSYNdBwhjxuaKa6908fmazQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: onlyfever <onlyfever@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

On Thursday 09 June 2011 16:40:15 onlyfever wrote:
> Hello,
> I want to power down Voice/Bluetooth sidetone PGA of TWL5030.
> I set the VSTPGA Register/BTSTPGA Register to 0x00,but it seems that
> the Voice/Bluetooth sidetone PGA still work,
> and even set VSTPGA/BTSTPGA to Mute,there still have sidetone come ou=
t.
>=20
> How can I power down Voice/Bluetooth sidetone PGA?
> I don't need sidetone.

Are you sure, that the sidetone is added by the VSTPGA/BTSTPGA?
Could you check, if you accidentally left either the analog loopbacks e=
nabled=20
(or digital loopbacks)?
Check for these:
Right1/2 Analog Loopback, Left1/2 Analog Loopback, Voice Analog Loopbac=
k,
Left/Right/Voice Digital Loopback

Could you describe your scenario (uplink, downlink routing, etc)?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
