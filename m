From: Tony Lindgren <tony@atomide.com>
Subject: Patches merged to split OMAP2_IO_ADDRESS
Date: Wed, 7 Oct 2009 17:25:06 -0700
Message-ID: <20091008002506.GF29320@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63264 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbZJHAZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 20:25:50 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Hi all,

I've pushed Santosh' patches to split OMAP2_IO_ADDRESS into *_L3_IO_ADDRESS
and *_L4_IO_ADDRESS so we can claim more kernel address space and support
over 512MB of memory instead of 256MB.

Of course, our goal is to convert everything except the .S files to
use ioremap() instead, but that can now be done parallel and in smaller
chunks.

Please everybody, please convert your code to use ioremap(), there are
static mappings already in place so it should work out of the box.

I also had add two quick patches to keep things compiling,
Paul can you take a look at them? I could not really test them as all
the code is not there yet. Will post them as a reply to this thread.

Regards,

Tony
