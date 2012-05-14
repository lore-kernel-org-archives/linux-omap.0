From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 01/11] OMAP2+: Add SoC specific map_io functions
Date: Mon, 14 May 2012 17:06:11 +0200
Message-ID: <4FB11F63.2010108@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com> <1316809399-19579-2-git-send-email-b-cousson@ti.com> <20120504175942.5ceb8e91@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755649Ab2ENPG1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 11:06:27 -0400
In-Reply-To: <20120504175942.5ceb8e91@skate>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: tony@atomide.com, grant.likely@secretlab.ca, khilman@ti.com, paul@pwsan.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Salut Thomas,

Sorry for the delay.

On 5/4/2012 5:59 PM, Thomas Petazzoni wrote:
> Hello Benoit,
>
> Le Fri, 23 Sep 2011 22:23:09 +0200,
> Benoit Cousson<b-cousson@ti.com>  a =C3=A9crit :
>
>> Add SoC specific map_io function to be used by the generic DT
>> board file. This is an intermediate step before having some
>> generic DT aware map_io function.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>
> Do you know if some progress has been made on having a generic DT awa=
re
> map_io function, or is the per-SoC ->map_io() function still the
> recommended way of handling SoC having different requirements of stat=
ic
> mappings at boot time?

Mmm, Maybe I'm wrong, but I'm not sure people are really pushing to=20
store that inside DT. But to be honest, I don't really know :-)

Tony might have some clue.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
