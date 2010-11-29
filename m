From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 0/6] Split powerdomain framework into plat specific/independent
Date: Mon, 29 Nov 2010 14:54:03 +0530
Message-ID: <143bada6d48a3e781534e8972a68ef71@mail.gmail.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1011281731090.2515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51808 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908Ab0K2J3s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 04:29:48 -0500
Received: by qyk12 with SMTP id 12so4347534qyk.12
        for <linux-omap@vger.kernel.org>; Mon, 29 Nov 2010 01:29:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011281731090.2515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, November 29, 2010 6:04 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com;
khilman@deeprootsystems.com
> Subject: Re: [PATCH 0/6] Split powerdomain framework into plat
specific/independent
>
> Hi Rajendra,
>
> As you've seen, I just did another review pass on these.  All of the
> review comments are pretty minor, although some of them will require
> moving some of the functions to different files, mostly due to OMAP3
> functions being present in an OMAP2xxx file.

Thanks for the review. I'll do the necessary changes and post
another version of the series soon.

Regards,
Rajendra

>
> Once those changes are made and the series reposted, I think these will
be
> good to merge.
>
> regards
>
> - Paul
