From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 4/4] DTS: ARM: OMAP3-N900: Add lis3lv02d support
Date: Wed, 20 May 2015 10:21:22 -0700
Message-ID: <20150520172121.GA10274@atomide.com>
References: <1427467186-9360-1-git-send-email-sre@kernel.org>
 <1427467186-9360-5-git-send-email-sre@kernel.org>
 <20150514224012.GA1835@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514224012.GA1835@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [150514 15:41]:
> Hi Tony,
> 
> On Fri, Mar 27, 2015 at 03:39:46PM +0100, Sebastian Reichel wrote:
> > This adds support for the N900's accelerometer to
> > the Nokia N900 DTS file.
> > 
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> > Quote from Tony:
> > 
> > This at least currently does not conflict with anything I have
> > queued, so I suggest you try to get Greg to take the whole set:
> > 
> > http://article.gmane.org/gmane.linux.ports.arm.omap/125020
> 
> It seems Greg did not see this message (this patch did not make it
> into 4.1-rc and the driver changes did), so could you queue this
> patch for 4.2?

Hmm seems to be there as commit 1ac4e6fee41d6.

Tony
