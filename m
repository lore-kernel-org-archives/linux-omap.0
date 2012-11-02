From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: discrepancy while save and restore of debounce registers
Date: Fri, 2 Nov 2012 09:44:26 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EABE28B@DBDE01.ent.ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EAA9A7C@DBDE01.ent.ti.com>
 <507F1F21.8040206@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EAAA89B@DBDE01.ent.ti.com>
 <50802B00.6090907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50802B00.6090907@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 18, 2012 at 21:44:56, Hunter, Jon wrote:
> Hi Gururaja,
> 
> On 10/18/2012 12:31 AM, Hebbar, Gururaja wrote:
> > Jon,
> > 
> > On Thu, Oct 18, 2012 at 02:42:01, Hunter, Jon wrote:
> 
> [snip]
> 
> >>> My doubt/questions are
> >>> 1. Why should debounce registers be updated only when it's accessed previously?
> >>
> >> If debounce is not being used by any of the gpios, then there is no need
> >> to restore them as there are no bits set. So this makes sense and saves
> >> a couple register writes.
> > 
> > What I want to know is that other than saving register writes, is there any
> > other important stuff that specifies this requirement.
> 
> From a HW perspective, none that I can see.
> 
> From a SW perspective, yes, as I mentioned if you restore these
> registers without first initialising the context variables where these
> registers are stored, then you may be restoring unknown values to the
> registers and that is bad.
> 
> >>> 2. What is the relation between updating debounce registers and crash seen on
> >>> others registers? 
> >>
> >> This I am not sure about. I gave this a quick try on my omap3430 beagle
> >> board, but I did not see any side-effects from doing this. However, if
> >> you are always restoring the debounce context regardless of whether
> >> debounce is being used, then you could be writing bad values to the
> >> debounce registers as the context variables bank->context.debouce and
> >> bank->context.debouce_en may not initialised. So that is bad. However,
> >> that said I am still not sure how this could cause a crash.
> >>
> >> Can you share more details on ...
> > 
> > Sorry for missing below details in first post.
> > 
> >> 1. The OMAP platform you are using?
> > 
> > I was trying this on TI AM335x platform (repo below). On AM335x EVM board
> > 
> > http://arago-project.org/git/projects/?p=linux-am33x.git;a=shortlog;
> > h=refs/heads/v3.2-staging
> > 
> >> 2. What linux distro/environment you are using?
> > 
> > Arago AM335x PSP release (linux 3.2 + am335x patch-set)
> > 
> >> 3. If there are any specific steps to reproduce this 100% of the time?
> > 
> > On top of this tree, try suspend/resume using "echo mem > /syspower/state"
> 
> I have a beagle-bone but unfortunately, suspend does not appear to be
> supported in the mainline kernel yet so I am unable to test this on the
> am335x on the mainline.

You can try the suspend/resume on BB from Arago tree which I mentioned above

> 
> Have you compared the gpio driver from your v3.2 branch with the current
> mainline to see how different this code is? Ideally, it would be good to
> test on the mainline kernel for another data point to see if this is
> local to your branch.

The mainline kernel omap GPIO driver has changed a lot from current arago
tree (which is at v3.2). Upon comparing is when I found out about the
register access check done before restoring.

> 
> Cheers
> Jon
> 
> 
> 


Regards, 
Gururaja
