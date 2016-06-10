From: Bin Liu <b-liu@ti.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Fri, 10 Jun 2016 12:37:12 -0500
Message-ID: <20160610173712.GC28283@uda0271908>
References: <201601091616.04193@pali>
 <86213272.dICX26rd7d@saturn>
 <20160610155940.GB28283@uda0271908>
 <2592499.y1ehgT9o2a@saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2592499.y1ehgT9o2a@saturn>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg Reisenweber <joerg@openmoko.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jun 10, 2016 at 06:15:26PM +0200, joerg Reisenweber wrote:
> On Fri 10 June 2016 10:59:40 Bin Liu wrote:
> > The musb ug says the testmde is not used in normal operation, so my
> > opinion is force_host should not be used for hacking n900 host mode if
> > this is for real product development or support.
> 
> You're aware N900 OS aka maemo is a) FOSS, and b) EOL at least from Nokia's 
> POV? So there's neither "product development" nor any _'official'_ support 
> involved.
> And c) we (community) already _did_ use it since it was the only chance to 
> make hostmode sort of work for N900, it's not like we could redesign N900 
> hardware to support regular hostmode, we need to work with what RL gave us. 

Well, misunderstanding does happening as Nishanth warned me offline :(

> It evades me why you discourage resp reject this established solution. 

Not sure how you concluded I reject this. Instead I am taking patches.
The only thing I did was warning that if you use force_host testmode in
normal operation in your 'products', you would get liability problem.

> Just Nokia not supporting hostmode evidently doesn't mean we can't get 
> anything done, and I don't see why we should refrain from doing so.

Regards,
-Bin.
