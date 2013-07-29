From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/4] serial: omap: enable PM runtime only when its fully
 configured
Date: Mon, 29 Jul 2013 08:44:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307290843090.30864@utopia.booyaka.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com> <1374487277-26099-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1374487277-26099-3-git-send-email-rnayak@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, mpfj-list@newflow.co.uk, vaibhav.bedia@ti.com, khilman@linaro.org, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

Rajendra,

On Mon, 22 Jul 2013, Rajendra Nayak wrote:

> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> If earlyprintk is enabled and current UART is console port the platform
> code can mark it as RPM_ACTIVE to sync real IP state with PM Runtime and
> avoid resuming of already active device, but now, driver initialization
> will be performed in the wrong way:

...

> CC: Tony Lindgren <tony@atomide.com>
> CC: Rajendra Nayak <rnayak@ti.com>
> CC: Felipe Balbi <balbi@ti.com>
> CC: Kevin Hilman <khilman@linaro.org>
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Did you intend to add your Signed-off-by: to this patch?  Since you're 
formally submitting it, it needs to have your Signed-off-by: for me to 
take it.  Let me know and I'll add it if needed -

- Paul
