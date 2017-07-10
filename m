From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] regulator: cpcap: Fix standby mode
Date: Mon, 10 Jul 2017 06:48:32 -0700
Message-ID: <20170710134831.GU3730@atomide.com>
References: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
 <20170707200813.20371-2-sebastian.reichel@collabora.co.uk>
 <20170710122345.i7q2z7sbjhsthn5g@sirena.org.uk>
 <20170710134510.v3xvkvdjqxkyz5n5@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710134510.v3xvkvdjqxkyz5n5@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170710 06:45]:
> Hi,
> 
> On Mon, Jul 10, 2017 at 01:23:45PM +0100, Mark Brown wrote:
> > On Fri, Jul 07, 2017 at 10:08:12PM +0200, Sebastian Reichel wrote:
> > 
> > > While working on the audio-codec I noticed, that the
> > > low power mode of the regulators are not properly
> > > supported. This fixes the issue for vaudio.
> > 
> > In what way is it not properly supported and how does this change ensure
> > that it is properly supported?

Just to clarify this, I had inverted use of a register bit bug in my
original patch that $subject patch fixes.

Regards,

Tony
