From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport power
 functions
Date: Thu, 17 Jan 2013 11:40:53 +0100
Message-ID: <50F7D535.6030205@ti.com>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>  <50F7C4A7.5060202@ti.com> <20130117093417.GH10814@arwen.pp.htv.fi>  <50F7CA82.4050509@ti.com> <20130117100510.GI10814@arwen.pp.htv.fi>  <20130117100919.GJ10814@arwen.pp.htv.fi> <1358418917.6252.31.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358418917.6252.31.camel@cumari.coelho.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/17/2013 11:35 AM, Luciano Coelho wrote:
> This out-of-tree code doesn't explain why we need to do the
> enable/disable in the board file.  We just need to do things a bit
> differently in the driver.  I'll start cleaning all this stuff up for
> -next pretty soon.
> 
> For now, ie. 3.7 (stable) and 3.8, do we agree in taking this patch so
> that TI-ST at least works on Panda? Simply reverting the gpio removal
> patch doesn't help, because we also need to handle the UART2 muxing
> (which my patch does as well).

I don't see better way to fix this either. In any case, I give you my:

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
