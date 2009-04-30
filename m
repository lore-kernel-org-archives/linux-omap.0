From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] onenand init: Pass configuration data from
	board-*.c files
Date: Thu, 30 Apr 2009 07:01:37 -0700
Message-ID: <20090430140136.GB12986@atomide.com>
References: <20090429214900.13138.54584.stgit@localhost> <20090429215037.13138.62993.stgit@localhost> <49F93CDE.3000105@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56533 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307AbZD3OBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 10:01:45 -0400
Content-Disposition: inline
In-Reply-To: <49F93CDE.3000105@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "dedekind@infradead.org" <dedekind@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Adrian Hunter <adrian.hunter@nokia.com> [090429 22:52]:
> Tony Lindgren wrote:
>> Pass configuration data from board-*.c files.
>>
>> Also remove support for the OMAP_TAG_PARTITION tag.
>> If the partition info is passed, it should be passed from
>> cmdline, and probably should be done in a generic way
>> in the drivers/mtd.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>
> NAK
>
> This would break all our flashing infrastructure.

The OMAP_TAG_PARTITION and others will have to go,
the omap tags have been rejected several times by RMK.

The right solution is to follow Linux standards and pass
the options from the cmdline.

Tony
