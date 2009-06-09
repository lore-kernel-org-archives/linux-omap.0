From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] Convert cbus driver code to use platform APIs
	consistently
Date: Tue, 9 Jun 2009 03:20:09 -0700
Message-ID: <20090609102008.GB2617@atomide.com>
References: <20090522193359.17514ptwyl8kdbls@lidskialf.net> <20090522231826.12833dwwkvi7rv0g@lidskialf.net> <20090523023901.33341jpwcx6nd70g@lidskialf.net> <20090523014717.GB9283@atomide.com> <20090523121108.14776dli2aeyapkw@lidskialf.net> <20090523123040.16971ty5wndy6mow@lidskialf.net> <20090523132812.14461t6dlahg2ew0@lidskialf.net> <20090523142542.10985fjvcwu3k9s0@lidskialf.net> <20090601231839.GD22956@atomide.com> <20090608205554.8257711w03d8isi2@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49204 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760777AbZFIKUJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 06:20:09 -0400
Content-Disposition: inline
In-Reply-To: <20090608205554.8257711w03d8isi2@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-omap@vger.kernel.org, ladis@linux-mips.org

* Andrew de Quincey <adq_dvb@lidskialf.net> [090608 12:56]:
> Recent changes in the drivers/base/platform.c exposed an inconsistency  
> in the cbus drivers; they weren't matching platform_divers with  
> platform_devices, which causes all sorts of structure casting issues  
> within the base platform code since it assumes this.
>
> Signed-off-by: Andrew de Quincey <adq@lidskialf.net>

The patch seems to be missing from the mail?

Tony
