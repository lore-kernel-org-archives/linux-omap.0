From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/16] rmk's patch series for fixing OMAP
Date: Thu, 9 Feb 2012 00:53:34 +0000
Message-ID: <20120209005334.GG25414@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk> <4F32DBB5.4010004@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49414 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880Ab2BIAxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:53:44 -0500
Content-Disposition: inline
In-Reply-To: <4F32DBB5.4010004@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap@vger.kernel.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Samuel Ortiz <sameo@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

On Wed, Feb 08, 2012 at 08:31:49PM +0000, Florian Tobias Schandinat wrote:
> Hi Russell,
> 
> On 02/08/2012 04:35 PM, Russell King - ARM Linux wrote:
> > commit c49d005b6cc8491fad5b24f82805be2d6bcbd3dd
> > Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Date:   Tue Jan 17 11:09:57 2012 +0200
> > 
> >     OMAPDSS: HDMI: PHY burnout fix
> >     
> >     A hardware bug in the OMAP4 HDMI PHY causes physical damage to the board
> >     if the HDMI PHY is kept powered on when the cable is not connected.
> 
> I agree this is a serious issue.
> 
> > which now has me wondering if, by trying to boot v3.3-rc2 on this board
> > during the past week, I have a destroyed HDMI interface on it.
> 
> I am not sure as I don't keep track of all OMAP changes, but you make it
> sound like a regression, is there any difference to 3.2 behavior?

I've no idea when the problem was introduced, that's not the point that
I'm making.  The point that I'm making is that the patch is dated January
17th, it was apparantly committed on the 26th, and it went into mainline
on the 8th February.

For a patch which fixes a _hardware_ _destruction_ issue, three weeks is
_FAR_ too long for it to take to get into mainline.

Moreover, only last Monday did I enable the OMAP2 DSS subsystem on the
4430 SDP platform, _including_ the HDMI code, and looking at the commit
it could be one of those platforms which is affected.

As I don't have a HDMI cable connected to the system, and I ran that
kernel overnight, and I tried opening each /dev/fb* device, what I'm now
wondering is: have I destroyed the HDMI PHY on my 4430SDP?

But that's not really the point.  The point is, for someone to sit on such
a patch for weeks is, in my opinion, as good as saying to your users "I
don't care if you bust your hardware."

However, you raise another point, a much more serious one at that.  Is
this problem also present in 3.2?  The patch seems to apply almost cleanly
to that kernel version, so I guess it is.  It fails to apply to v3.1
because of missing files, so I guess 3.1 is unaffected.

So, why isn't this patch copied to the stable people?

And why is there this seemingly lack of care for hardware destruction bugs?

Please, if it affects v3.2, PLEASE PLEASE PLEASE tell the stable people
who know nothing about this commit until I asked them this evening about
it.

> > So, a big thanks for sitting on that fix and exposing peoples hardware
> > to damage, that shows real professionalism.
> 
> Well, I am no professional to begin with, at least in the sense of getting paid
> for it. That said I'm quite happy if I manage to find a few hours every weekend
> to do the work. Given that the final thing should be tested in -next before I
> ask Linus to pull, it is completely usual (and even quite fast) if things take
> 8-13 days on my end. If this isn't fast enough for Tomi, he'd better ask Linus
> to pull directly for such issues.

For hardware destruction issues, once the problem has been identified, it
should be shouted about very loudly to get it upstream as quickly as
possible.  I'm sure Linus would've even taken it in patch form.

(You do realise that Linus does apply patches as well as pulling trees?)
