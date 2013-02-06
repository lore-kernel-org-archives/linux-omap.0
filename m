From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: OMAP2: MUSB: Specify omap4 has mailbox
Date: Wed, 6 Feb 2013 10:57:13 +0000
Message-ID: <20130206105713.GF17852@n2100.arm.linux.org.uk>
References: <1360130294-5976-1-git-send-email-kishon@ti.com> <1360130294-5976-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360130294-5976-4-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, eballetbo@gmail.com, javier@dowhile0.org, b-cousson@ti.com, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 06, 2013 at 11:28:11AM +0530, Kishon Vijay Abraham I wrote:
> Added has_mailbox to the musb platform data to specify that omap uses
> an external mailbox (in control module) to communicate with the musb
> core during device connect and disconnect.

So, I've been through your five patches looking for any other users of
"has_mailbox" and I can find none.  You introduce this in this patch,
and you set it.  But I don't see anything that uses it.

Write only variables are not useful.
