From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 0/10] OPP layer and additional cleanups.
Date: Mon, 11 Jan 2010 10:36:31 +0530
Message-ID: <4B4AB1D7.8030100@ti.com>
References: <1262266140.20175.176.camel@boson> <4B42609B.7050403@ti.com> <4B459A23.9030709@ti.com> <4B4603A3.4030608@ti.com> <4B46DA7F.8080808@ti.com> <4B474C74.9020407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33143 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab0AKFGm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 00:06:42 -0500
In-Reply-To: <4B474C74.9020407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> 
> lets make the list implementation as a seperate series and discuss this. 
> I am guessing that there could be wrapper apis which would could 
> optimize the implementation while maintaining the overall APIs allowing 
> other dependent users to continue. I will reserve my comments till we 
> see the series on this.
> 
Based on the  OPP nano-summit!! we had last Friday I will post two sets of
patches to start with

1. Miscellaneous changes that was part of the earlier patch.
2. Patch that will remove maintaining pointers to the beginning of the array
(OPP array).


Thanks,
-Romit


