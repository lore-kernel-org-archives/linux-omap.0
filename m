From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Add OMAP4 Blaze Tablet support
Date: Mon, 11 Feb 2013 08:52:51 -0800
Message-ID: <20130211165251.GN4801@atomide.com>
References: <1360352269-14922-1-git-send-email-ruslan.bilovol@ti.com>
 <1360352269-14922-2-git-send-email-ruslan.bilovol@ti.com>
 <20130210025225.GB4801@atomide.com>
 <CAB=otbQ5kWw-tcocwT6TZGpxmCV_JS4H3xN6_CewxZpMBNErug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB=otbQ5kWw-tcocwT6TZGpxmCV_JS4H3xN6_CewxZpMBNErug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130210 13:46]:
> Hi,
> 
> On Sun, Feb 10, 2013 at 4:52 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Ruslan Bilovol <ruslan.bilovol@ti.com> [130208 11:41]:
> >> The OMAP4 Blaze Tablet is TI OMAP4 processor-based
> >> development platform in a tablet formfactor.
> >> The platform contains many of the features found in
> >> present-day handsets (such as audio, video, wireless
> >> functions and user interfaces) and in addition
> >> contains features for software development and test.
> >>
> >> This patch adds initial support for the OMAP4 Blaze
> >> Tablet development platform. Additional functionality
> >> depends on different drivers and code modifications that
> >> are not upstreamed yet so will be added later.
> >
> > Nice that you have it working, however, we're not adding
> > any more board-*.c files as we're moving things to device
> > tree based booting.
> 
> Hmm.. I though at this time we require boardfile + DT support..
> Probably lot of boardfiles confused me - any plan to delete them?
> Anyway, the whole era of boardfiles has gone.. (Where to place board-specific
> hacks now? :) )

The DT booting happens with board-generic.c, and we're
should not need board specific callback functions any
longer. That of course assumes we have a Linux generic
framework available for things that we've been doing with
the board specific callback functions. 

> > Care to try to get the basic .dts file done for this?
> > You will probably need to add CONFIG_ARM_APPENDED_DTB=y
> > and CONFIG_ARM_ATAG_DTB_COMPAT=y to omap2plus_defconfig
> > and append the .dtb file to zImage and run mkimage then
> > manually to boot it. But you should get serial and MMC
> > at least working to start with :)
> 
> Yes, this is a second part of this board' upstreaming.
> Thanks for advice and please expect DT-part only of board soon..

Thanks!

Tony
