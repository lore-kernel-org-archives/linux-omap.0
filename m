From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/5] misc serdev: new serdev based driver for Wi2Wi
 w2sg00x4 GPS module
Date: Mon, 18 Dec 2017 15:48:16 +0100
Message-ID: <20171218144816.GA31130@kroah.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <01C0DAA8-A2E5-4E42-8726-80937541E231@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01C0DAA8-A2E5-4E42-8726-80937541E231@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, "Andrew F. Davis" <afd@ti.com>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 18, 2017 at 09:52:07AM +0100, H. Nikolaus Schaller wrote:
> Hi,
> unfortunately I had lost to include Andrew Davis' address who had provided
> very valuable comments for v5. Sorry, Andrew!
> 
> There has only been one more comment by Andreas Färber in the past 14 days.
> 
> So how to proceed? Who is taking care of deciding/merging towards linux-next?

I already have the serdev patches in my tty tree, right?  If I have no
objections, I can take the rest through that tree as well...

thanks,

greg k-h
