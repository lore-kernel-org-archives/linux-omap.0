From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] Fixes to twl4030-madc and add BeagleBoard
 support
Date: Wed, 28 Sep 2011 11:32:31 -0700
Message-ID: <20110928183230.GD6324@atomide.com>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
 <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
 <20110822135530.GR4607@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110822135530.GR4607@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Kyle Manna <kyle@kylemanna.com>, Russell King <linux@arm.linux.org.uk>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Samuel Ortiz <sameo@linux.intel.com> [110822 06:20]:
> Hi Kyle,
> 
> On Thu, Aug 11, 2011 at 10:33:11PM -0500, Kyle Manna wrote:
> > These patches add basic functionality to the twl4030-madc driver to make
> > it work on the BeagleBoard xM.
> > 
> > Version 2 adds fixes per Grazvydas Ignotas and the check for NULL pointer patch.
> > 
> > Kyle Manna (4):
> >   mfd: twl4030-madc: copy the device pointer
> >   mfd: twl4030-madc: turn on the MADC clock
> >   mfd: twl4030-madc: check for NULL pointer
> >   arm: BeagleBoard: add support for the twl4030-madc
> Tony, are you ok with the BeagleBoard changes ?
> The MFD ones look fine to me, I'd like to apply them.

Yes sorry for the delay in replying. I acked it, maybe
you can just copy the subject to have a proper description
for the patch.

Tony
