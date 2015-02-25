From: Tony Lindgren <tony@atomide.com>
Subject: Re: Dead Kconfig Option OMAP4_ERRATA_I688
Date: Wed, 25 Feb 2015 09:14:51 -0800
Message-ID: <20150225171451.GQ11056@atomide.com>
References: <CABv5NL-bnfV0BoH+G=nX+1eo6xeT_LN8dOFtSnwvdpcvjJhUFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABv5NL-bnfV0BoH+G=nX+1eo6xeT_LN8dOFtSnwvdpcvjJhUFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Hengelein <stefan.hengelein@fau.de>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, santosh shilimkar <santosh.shilimkar@oracle.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Adding Santosh to Cc on this one.

* Stefan Hengelein <stefan.hengelein@fau.de> [150225 09:13]:
> During the research for my masters thesis i came across the
> OMAP4_ERRATA_I688 option and realized, it is never possible to enable
> this option.
> 
> The a62a6e98 commit added the "&& !ARCH_MULTIPLATFORM" dependency to
> disable this option for multiplatforms. However, because of enclosing
> dependencies, this option isn't available for non-MULTIPLATFORM
> configurations either.

Yes there is no clean way currently to enable this errata for
multiplatform.
 
> CONFIG_OMAP4_ERRATA_I688 is defined in the menu "TI OMAP/AM/DM/DRA
> Family" which depends on ARCH_MULTI_V6 || ARCH_MULTI_V7. (in
> arch/arm/mach-omap2/Kconfig)
> 
> ARCH_MULTI_V6 and ARCH_MULTI_V7 however are defined in the menu
> "Multiple platform selection" which depends on ARCH_MULTIPLATFORM (in
> arch/arm/Kconfig)
> 
> Which is a contradiction.
> 
> There are no selects on OMAP4_ERRATA_I688, which would ignore
> dependencies, either.
> 
> The question is:
> Was disabling this option for non-MULTIPLATFORM configurations also intentional?
> 
> i have added a minimal example of the problem.

>From what I remember the plan was to try to come up with a
multiplatform friendly way of doing this errata. Santosh,
any suggestions here? Should we just remove the code as it
seems nobody has complained about it for a few years now?

Regards,

Tony
