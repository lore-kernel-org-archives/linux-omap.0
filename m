From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Date: Mon, 19 Mar 2018 15:05:55 +0100
Message-ID: <20180319140555.GN18359@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <E7ECBBB8-2E88-4F04-AFC3-659332E84CF6@goldelico.com>
 <20180118061314.GG3286@localhost>
 <8B2641B8-E86B-425C-9E79-E9C41E4E623C@goldelico.com>
 <461DBB7C-5FF7-4723-9518-C9A5E7E5610D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <461DBB7C-5FF7-4723-9518-C9A5E7E5610D@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, kernel@pyra-handheld.com, Andreas Kemnade <andreas@kemnade.info>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>Linu
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 07, 2018 at 04:53:12PM +0100, H. Nikolaus Schaller wrote:

> If I look for example at the camera module drivers provided by
> drivers/media/i2c, most of them could be easily power-controlled from
> user-space by i2c-tools and 1-2 gpios through /sys/class/gpio and
> a big set of scripts.
> 
> Still they have a place in the kernel and cameras are powered on
> if the device is opened and powered down if it is closed.
> 
> So I am still trying to understand the rationale and logic (if one exists)
> behind having them in kernel but rejecting our driver which does the
> same for a different class of devices.

For media we have a framework in place; for gps we do not (yet).

Johan
