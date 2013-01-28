From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] cpsw: Fix interrupt storm among other things
Date: Mon, 28 Jan 2013 20:56:32 +0100
Message-ID: <20130128195632.GB6129@netboy.at.omicron.at>
References: <1359378668-26536-1-git-send-email-panto@antoniou-consulting.com>
 <20130128182451.GC2445@netboy.at.omicron.at>
 <4E26978C-0B09-4E06-8373-49F1850C08C4@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:49564 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab3A1T4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 14:56:45 -0500
Content-Disposition: inline
In-Reply-To: <4E26978C-0B09-4E06-8373-49F1850C08C4@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Matt Porter <mporter@ti.com>, Chase Maupin <chase.maupin@ti.com>, Jason Kridner <jdk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 28, 2013 at 08:40:25PM +0200, Pantelis Antoniou wrote:
> 
> Speaking of which, I'm probably the original developer of the fec driver.

BTW, as I mentioned, someone is converting fec to napi. Care to take a
look to make sure it is done right?

Thanks,
Richard
