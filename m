From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv8 5/5] OMAP: I2C: Remove the SYSC register definition
Date: Fri, 16 Dec 2011 01:41:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160140540.12660@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-6-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33754 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab1LPIld (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 03:41:33 -0500
In-Reply-To: <1323773758-6375-6-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, ben-linux@fluff.org

Hi 

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> The SYSC register should not accessed in the driver removing the
> define from the driver.
> Also clean up the syscstate from the omap_i2c_dev struct.
> 
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

Same for this patch - it either needs to be acked by Ben with a note that 
it's okay for us to merge through the OMAP tree, or needs to be merged by 
Ben during the 3.4 merge window, after patches 1-3 have reached the 
mainline tree.


- Paul
