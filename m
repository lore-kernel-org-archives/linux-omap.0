From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [pandaboard] audio initialization fails due to TWL6040
Date: Mon, 30 Dec 2013 09:35:02 +0200
Message-ID: <52C12226.6010404@ti.com>
References: <529E5EC9.10008@math.uni-bielefeld.de> <20131205185349.GH26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52667 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab3L3HfK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Dec 2013 02:35:10 -0500
In-Reply-To: <20131205185349.GH26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: linux-omap@vger.kernel.org

Hi Tony,

I have missed this mail...

On 12/05/2013 08:53 PM, Tony Lindgren wrote:
> * Tobias Jakobi <tjakobi@math.uni-bielefeld.de> [131203 14:45]:
>> And another one!
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D66451
>=20
> Maybe Peter can take a look at this one?

It has been already fixed (bug in the arch/arm/mm/dma-mapping.c)

> FYI, Peter, only slightly related to this, but can you also please
> unravel the mcbsp and sidetone .dtsi entries to be separate
> devices? I'm hoping to deprecate ti,hwmods for v3.15 and use
> the compatible property instead, so we need to have 1-to-1
> mapping of devices defined in the .dtsi files compared to the
> real hardware devices mapped in the omap_hwmod_*_data.c files.
>=20
> There's some more info regarding that in thread:
>=20
> http://www.spinics.net/lists/arm-kernel/msg288036.html

How urgent this is?
Due to a 'hw feature' around the sidetone this is not as straight forwa=
rd as
it sounds...
I can put this to my to do list.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
