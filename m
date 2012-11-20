From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 065/493] i2c: remove use of __devexit_p
Date: Tue, 20 Nov 2012 14:46:21 +0100
Message-ID: <20121120144621.5d2c213a@endymion.delvare>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:13413 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab2KTNqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 08:46:46 -0500
In-Reply-To: <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks  <ben-linux@fluff.org>, Rudolf Marek <r.marek@assembler.cz>, Jochen Friedrich <jochen@scram.de>, Peter Korsgaard <jacmet@sunsite.dk>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, Vitaly Wool <vitalywool@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Barry Song <baohua.song@csr.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

As mentioned on the lm-sensors list for hwmon patches already, I think
it would be much clearer to not split __devexit, __devexit_p, __devinit
etc. removal into separate patches. One patch per subsystem would be
easier to review and apply. If patches grow too large then you'd rather
split in a different direction, for example drivers/i2c/muxes vs.
drivers/i2c/busses or even grouped by related bus drivers (see entries
"I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
MAINTAINERS for examples of meaningful groups.)

-- 
Jean Delvare
