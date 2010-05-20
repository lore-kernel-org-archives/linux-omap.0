From: Nishanth Menon <nm@ti.com>
Subject: Re: Future of resource framework?
Date: Thu, 20 May 2010 18:23:20 -0500
Message-ID: <4BF5C468.208@ti.com>
References: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40995 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755008Ab0ETXXX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 19:23:23 -0400
In-Reply-To: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Mike Chan had written, on 05/20/2010 05:37 PM, the following:
> I'm not sure if this has been discussed, yet but since it seems that
> the resource framework will not be making it upstream, I am curious
http://marc.info/?l=linux-omap&m=127206504624556&w=2 (we are getting to 
the one month expiry date btw..)

> what are the replacements under consideration. I am starting to see
> similar issues on other platforms (msm / tegra) so more generic
> (non-omap) solution might be something to consider.

I know of one by Sanjeev Premi:
[1] http://marc.info/?l=linux-omap&m=125716806431649&w=2
it should be rather trivial to adapt it to opp layer and make it work.

-- 
Regards,
Nishanth Menon
