From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2 0/4] Fixes to twl4030-madc and add BeagleBoard support
Date: Tue, 4 Oct 2011 12:28:11 +0200
Message-ID: <20111004102811.GW4118@sortiz-mobl>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
	<1313119995-15382-1-git-send-email-kyle@kylemanna.com>
	<20110822135530.GR4607@sortiz-mobl>
	<20110928183230.GD6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110928183230.GD6324@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Kyle Manna <kyle@kylemanna.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wed, Sep 28, 2011 at 11:32:31AM -0700, Tony Lindgren wrote:
> * Samuel Ortiz <sameo@linux.intel.com> [110822 06:20]:
> > Hi Kyle,
> > 
> > On Thu, Aug 11, 2011 at 10:33:11PM -0500, Kyle Manna wrote:
> > > These patches add basic functionality to the twl4030-madc driver to make
> > > it work on the BeagleBoard xM.
> > > 
> > > Version 2 adds fixes per Grazvydas Ignotas and the check for NULL pointer patch.
> > > 
> > > Kyle Manna (4):
> > >   mfd: twl4030-madc: copy the device pointer
> > >   mfd: twl4030-madc: turn on the MADC clock
> > >   mfd: twl4030-madc: check for NULL pointer
> > >   arm: BeagleBoard: add support for the twl4030-madc
> > Tony, are you ok with the BeagleBoard changes ?
> > The MFD ones look fine to me, I'd like to apply them.
> 
> Yes sorry for the delay in replying. I acked it, maybe
> you can just copy the subject to have a proper description
> for the patch.
I actually pushed the 3 MFD patches already.
I think you can safely take the beagle one through your tree.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
