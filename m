From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: arm: mach-omap2: voltage.c: Remove some unused functions
Date: Fri, 02 Jan 2015 22:22:49 +0100
Message-ID: <1495149.Vn5ZbzJ5yF@wuerfel>
References: <1420131994-31636-1-git-send-email-rickard_strandqvist@spectrumdigital.se> <3966855.LUXW4xbVYM@wuerfel> <CAKXHbyPnTzOxWBBL0eiCNOPfF=htKpFRSt+R5h8o45ERp7zi1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKXHbyPnTzOxWBBL0eiCNOPfF=htKpFRSt+R5h8o45ERp7zi1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 02 January 2015 17:02:21 Rickard Strandqvist wrote:
> 2015-01-02 10:46 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 01 January 2015 18:06:34 Rickard Strandqvist wrote:
> >
> > You have correctly spotted the only place that references
> > voltdm_for_each_pwrdm
> > and changed the comment, but you failed to notice that it no longer makes
> > sense to call voltdm_add_pwrdm or keep the voltdm->pwrdm_list pointer
> > at all, so this function, and the associated list heads can all be removed
> > as well.
> >
> >         Arnd
> >
> 
> 
> Hi Arnd
> 
> Thanks for your reply.
> 
> I see what you mean, but you are aware that voltdm_add_pwrdm() also be
> called from:
> arch/arm/mach-omap2/powerdomain.c in _pwrdm_register()

Yes, that call needs to be removed as well of course.

> I have also removde the voltdm_for_each()

Ok, sounds good. That list of course has to stay though, so removing
_voltdm_register would be bad ;-)

	Arnd
