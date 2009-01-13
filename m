From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 08/12] DSS: support for Beagle Board
Date: Tue, 13 Jan 2009 03:14:03 -0800
Message-ID: <200901130314.03906.david-b@pacbell.net>
References: <20090112114718.1003.23643.stgit@tubuntu> <20090112114811.1003.38871.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:29549 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752063AbZAMLOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 06:14:07 -0500
In-Reply-To: <20090112114811.1003.38871.stgit@tubuntu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Monday 12 January 2009, Tomi Valkeinen wrote:
> =A0arch/arm/configs/dss_omap3_beagle_defconfig | 1437 +++++++++++++++=
++++++++++++

This is a complete replacement.  The patch would be a lot
more comprehensible if changed the standard config to just
add support for this board's video options (DVI and S-Video).

Also it'd be good to have a brief textual summary of what
each board's default video config is; maybe one of those
little multicolumn charts as in your first patch, with a
one sentence summary.  (In the board-*.c file.)

Note that after this merges, some work will be needed to
make the regulator framework handle the power switching.
Such logic should move out of board files (except for
setting up "S-Video is supplied using the twl VDAC").
It's not quite time for that yet; heads-up, that's all.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
