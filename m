From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap-wakeupgen.c: Remove function for fix me
Date: Wed, 23 Jul 2014 00:43:28 -0700
Message-ID: <20140723074328.GI18374@atomide.com>
References: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Krause <xerofoify@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Nick Krause <xerofoify@gmail.com> [140722 14:12]:
> static void __init irq_pm_init(void)
> 382 {
> 383         /* FIXME: Remove this when MPU OSWR support is added */
> 384         if (!soc_is_omap54xx())
> 385                 cpu_pm_register_notifier(&irq_notifier_block);
> 386 }
> I am wondering is this omap supported now if it is can I remove it?

Does REVISIT cause issues for you with cscope? It may be easier to
replace the cscope bugging FIXME statements with just REVISIT unless
a real fix is provided.

Regards,

Tony
