From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 00/13] ARM: OMAP: DMTIMER fixes
Date: Mon, 12 Nov 2012 15:38:48 -0600
Message-ID: <50A16C68.9020004@ti.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com> <20121112203440.GL6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36791 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731Ab2KLViy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 16:38:54 -0500
In-Reply-To: <20121112203440.GL6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/12/2012 02:34 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [121112 10:22]:
>> This series includes several fixes for the OMAP DMTIMER driver. This is
>> based upon Tony Lindgren's current master branch [1].
> 
> You should be able to use omap-for-v3.8/dt as the base now with
> the cleanup merged there. The master branch is just a merge of the
> various topic branches, and can't be used as a base for pull requests.

Ok, great will base on top of that branch.

Cheers
Jon
