From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/21] Revert "OMAP3+: PM: SR: add suspend/resume handlers"
Date: Wed, 25 Jan 2012 10:49:42 -0800
Message-ID: <87zkdbehx5.fsf@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
	<1327504583-13408-6-git-send-email-j-pihet@ti.com>
	<4F2041B1.6060907@ti.com>
	<CAORVsuWu-pzTWzYp2=gqqPzRJQ1eBLu=12uNyEbVSZp407WUnA@mail.gmail.com>
	<4F204916.7050504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:58050 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab2AYStp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 13:49:45 -0500
Received: by mail-vw0-f54.google.com with SMTP id fa15so2899976vbb.27
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 10:49:44 -0800 (PST)
In-Reply-To: <4F204916.7050504@ti.com> (Benoit Cousson's message of "Wed, 25
	Jan 2012 19:25:26 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 1/25/2012 7:13 PM, Jean Pihet wrote:

[...]

>>>
>>> I guess that path #3 and #5 should just be removed.
>> I am ok with both options (keeping or removing the 2 commits), please
>> let me know what you prefer.
>
> I guess that removing both is the only acceptable solution
> anyway. 

Yes, please remove them both.

Kevin
