From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: Convert DuoVero Parlor to use IOPAD macro
Date: Mon, 19 May 2014 15:15:41 -0700
Message-ID: <20140519221541.GI11945@atomide.com>
References: <1400328420-28384-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49094 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750894AbaESWPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 18:15:46 -0400
Content-Disposition: inline
In-Reply-To: <1400328420-28384-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, florian.vaussard@epfl.ch

* Joachim Eastwood <manabian@gmail.com> [140517 05:08]:
> Conversion done by following awk script.
> /0x[0-9a-f]{1,3} \(PIN/ {
> 	offset = sprintf("OMAP4_IOPAD(0x%03x, ", strtonum($1) + 64)
> 	sub(/0x[0-9a-f]{1,3} \(/, offset, $0)
> 	print $0
> 	next
> }
> { print $0 }
> 
> Cc: florian.vaussard@epfl.ch
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> 
> Hi,
> 
> Checked md5sum before and after patch and the resulting dtb is the same. So
> this should be safe.

OK thanks applying into omap-for-v3.16/dt.

Regards,

Tony
