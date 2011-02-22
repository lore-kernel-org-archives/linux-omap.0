From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v3 00/13] OMAP: McBSP: hwmod adaptation  and runtime conversion
Date: Tue, 22 Feb 2011 09:31:29 +0200
Message-ID: <4D636651.30904@nokia.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:43398 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab1BVHbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 02:31:41 -0500
In-Reply-To: <1298038948-19871-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, p-basak2@ti.com, charu@ti.com, shubhrajyoti@ti.com

On 02/18/11 16:22, ext Kishon Vijay Abraham I wrote:
> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime  =
APIs.
>=20
> Created on top of linux OMAP master (linux-omap-2.6 :master)
>=20
> Did digital loopback testing on OMAP4430, OMAP3430, OMAP2430 and OMAP
> 1710 SDP boards.
> Tested audio on 3430 SDP board (by me) and N810 (by Jarkko Nikula).
> Tested PM with audio and verified the patch series does not cause reg=
ression.
> PM testing comprises of suspend/resume between consecutive audio play=
back.
> Support for suspend/resume in the middle of audio playback will be do=
ne by
> audio guys on top of this patch series.
>=20
> Patch series requires the following patch to be present
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134

I don't see further issues with this series.
Since my ack is already in place on the patches, the only thing I can
say is:
Good work, thank you!

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
