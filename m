From: Rebecca Schultz Zavin <rebecca@android.com>
Subject: Fwd: dss2 with dsi
Date: Wed, 15 Apr 2009 19:17:43 -0700
Message-ID: <aed62de90904151917l21419edo12df2dc3ad5c707c@mail.gmail.com>
References: <aed62de90904151916h5a218e9bgf3419ea96c3ed262@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:32693 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZDPCRs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 22:17:48 -0400
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id n3G2Hi6r010357
	for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2009 03:17:45 +0100
Received: from qw-out-1920.google.com (qwj9.prod.google.com [10.241.195.73])
	by spaceape12.eur.corp.google.com with ESMTP id n3G2HMpd024389
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 19:17:43 -0700
Received: by qw-out-1920.google.com with SMTP id 9so147294qwj.48
        for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 19:17:43 -0700 (PDT)
In-Reply-To: <aed62de90904151916h5a218e9bgf3419ea96c3ed262@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm using dss2 on a dsi panel and I've run into a few limitations in
the present implementation.=A0 I'd like to post the fixes, but I'd
appreciate some guidance, especially since I'm working without the
mipi spec so it isn't always clear to me what's a function of the
implementation vs. the spec.

1- I think the destination vc set in dsi.vc[n].dest_per should be
specifiable from either the dsi controller or the board file?=A0 Any
preference on which?=A0 Could be added to omap_ctrl or to
omap_dss_display_type.

2- The code hard codes vc0 for L4 and v1 for dispc.=A0 My controller
exepects the reverse.=A0 Again I think this should come from some struc=
t
in either the controller or the board file.=A0 Preferences?

3- The code hard codes the complexio timing values used for setting
DSIPHY_CFG0, 1 and 2.=A0 I think these values should be specified in th=
e
omap_ctrl the way rfbi_timings are.

If no one has any thoughts on this I'll just pick something and throw
some patches for Tomi's tree up, but I thought it was worth pinging on
it.

Rebecca
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
