From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: Add Corscience Tricorder board
Date: Thu, 16 Feb 2012 10:42:10 -0800
Message-ID: <20120216184210.GB18185@atomide.com>
References: <1328111949-1859-1-git-send-email-weber@corscience.de>
 <4F3D4CED.9030606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22125 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab2BPSmO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 13:42:14 -0500
Content-Disposition: inline
In-Reply-To: <4F3D4CED.9030606@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <thomas.weber.linux@googlemail.com>
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

Hi,

* Thomas Weber <thomas.weber.linux@googlemail.com> [120216 10:05]:
> Hello Tony,
> 
> do you have any comments on this?

Well we're trying to remove all the board-*.c files by
using device tree, so I suggest starting to look into
that a bit. So no new board-*.c files are not being added,
unless they're device tree based.

If this is similar to your existing board, you may
be able to add the support to your existing board
file with minimal changes?

While things are still being worked on, I can carry
board files in the omap tree testing-board branch.

Regards,

Tony
