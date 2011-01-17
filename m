From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC+CFT] Use word operations in bitops
Date: Mon, 17 Jan 2011 11:08:57 +0100
Message-ID: <20110117100857.GS6917@pengutronix.de>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60275 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab1AQKJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 05:09:02 -0500
Content-Disposition: inline
In-Reply-To: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello Russell,

On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linux wrot=
e:
> This does need a fair amount of testing before it can be merged, so I=
'd
> like to see a number of Tested-by's against this patch.  Please also
> indicate whether you tested on LE or BE or both, which filesystems, a=
nd
> whether they were read-only mounted or read-write mounted.
You could make life a bit easier (at least for us at Pengutronix,
probably more) if you had a branch with a defined name for patches like
these.  We could add that to our daily test then.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
