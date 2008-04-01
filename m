From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
Date: Tue, 1 Apr 2008 11:16:19 -0500
Message-ID: <20080401161617.GA28624@ubuntu-workstation>
References: <20080331014640.GA14188@ubuntu-workstation> <47F14D61.5030109@indt.org.br> <20080401005137.GA22520@ubuntu-workstation> <004901c8940b$20f1fca0$438918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:25513 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbYDAQTD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2008 12:19:03 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1361471wra.1
        for <linux-omap@vger.kernel.org>; Tue, 01 Apr 2008 09:18:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <004901c8940b$20f1fca0$438918ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 01, 2008 at 08:44:47PM +0530, Madhusudhan Chikkature Rajashekar wrote:
> Hi,
> 
> I did not see any board level code to power up the second slot along with this patch.
> Where is the code that enables 1.8V to the second slot?

I am working with a custom board that isn't supported in the git repo, and I
don't have access to any other board that I could test such changes with.
These are just the chages I found were necessary to support the 1.8V-only
host, regardless of whatever board support is needed.
