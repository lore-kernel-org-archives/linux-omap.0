From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [QUERY] [AUDIO][OMAP3 EVM] arecord not working on OMAP3 EVM
Date: Fri, 21 Jan 2011 09:56:50 +0200
Message-ID: <4D393C42.1070503@nokia.com>
References: <FCCFB4CDC6E5564B9182F639FC356087035F9B2239@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:23007 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab1AUH46 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 02:56:58 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087035F9B2239@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

On 01/20/11 17:26, ext Koyamangalath, Abhilash wrote:
> Hi all
> While testing audio capture (using arecord e,g.),I'm getting only noi=
se in the (zeroed out) output buffers on the OMAP3 EVM.
> I have enabled AUXL and AUXR mic inputs through alsamixer, which acco=
rding to the schematics are connected to the "Audio In"
> connector on the board, even though the TWL4030 reg list does not all=
ow me any ways ( or so I think) to specify mic-bias for=20
> these aux inputs.

Well, it is auxiliary input (line in). You do not need bias for it.
I do not have access to OMAP3 EVM documentation, but Beagle also have
AUXL/R as input.
I guess you need to use correct cable, and correct source for the input
(stereo jack I suppose).

> With AUXL and AUXR muted - I get only silence, which seems to make se=
nse.
> Is there any basic startup setting I'm missing, maybe specific to OMA=
P3 EVM?

Beagle?

> Has anyone seen anything like this before, and could provide pointers=
?

My bet goes for the wrong cable/accessory pair.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
