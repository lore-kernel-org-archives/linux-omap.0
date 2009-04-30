From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 4/4] onenand init: Pass configuration data from board-*.c
 files
Date: Thu, 30 Apr 2009 08:53:34 +0300
Message-ID: <49F93CDE.3000105@nokia.com>
References: <20090429214900.13138.54584.stgit@localhost> <20090429215037.13138.62993.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58893 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbZD3Fwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 01:52:44 -0400
In-Reply-To: <20090429215037.13138.62993.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "dedekind@infradead.org" <dedekind@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren wrote:
> Pass configuration data from board-*.c files.
> 
> Also remove support for the OMAP_TAG_PARTITION tag.
> If the partition info is passed, it should be passed from
> cmdline, and probably should be done in a generic way
> in the drivers/mtd.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

NAK

This would break all our flashing infrastructure.
