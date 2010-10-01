From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 7/8] OMAP4: Keyboard board support
Date: Fri, 1 Oct 2010 16:14:17 -0700
Message-ID: <20101001231417.GI3117@atomide.com>
References: <1285824973-25550-1-git-send-email-x0066660@ti.com>
 <20100930064055.GG5260@core.coreip.homeip.net>
 <20101001225127.GE3117@atomide.com>
 <87wrq14ipg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wrq14ipg.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Abraham Arce <x0066660@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [101001 15:57]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [100929 23:32]:
> >> HI Abraham,
> >> 
> >> On Thu, Sep 30, 2010 at 12:36:13AM -0500, Abraham Arce wrote:
> >> > From: Syed Rafiuddin <rafiuddin.syed@ti.com>
> >> > 
> >> > Keyboard support for SDP OMAP4430
> >> > 
> >> 
> >> I think this would benefit from "const" sprinkled on it.
> >> 
> >> BTW, I picked up patches 2, 3, 4, 5, 8 (all touching drivers/input).
> >
> > Thanks, I'll take 1, 6 & 7.
> 
> Dmitry,
> 
> Can you please drop patch 8 (the pm runtime one.)  As pointed out by
> Charu,  with the proposed platform changes, this cannot work
> correctly with runtime PM.
> 
> Tony, I also propose we don't merge the platform code yet either until
> Abraham can respond to the platform-specific issues and runtime PM
> issues.
> 
> I'm fine with Dmitry merging the rest of the driver changes though.

OK, I'll drop 1, 6 & 7.

Merging the rest of the driver changes sounds good to me too,
that way there's no longer a build dependecy on the plat/omap4-keypad.h ;)

Tony
