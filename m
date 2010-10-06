From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: McBSP: Fix CLKR and FSR signal muxing
Date: Wed, 6 Oct 2010 08:43:13 +0300
Message-ID: <201010060843.13631.peter.ujfalusi@nokia.com>
References: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:50251 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab0JFFnQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 01:43:16 -0400
In-Reply-To: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Tuesday 05 October 2010 15:29:33 ext Jarkko Nikula wrote:
> Fix bit clear. Now it clears all other bits than mask bit where it sh=
ould
> clear only it.
>=20
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
