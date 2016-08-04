From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume
 balanced enable()/disable()
Date: Thu, 4 Aug 2016 22:59:29 +0200
Message-ID: <20160804225929.33a94511@aktux>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
	<FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
	<20160804142919.GG28140@atomide.com>
	<3EF398D0-6B90-46B6-83AE-EAE065A68890@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3EF398D0-6B90-46B6-83AE-EAE065A68890@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 4 Aug 2016 16:49:30 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Rationale:
> > 
> > The charger driver calls pm_runtime_get_sync(bci->transceiver->dev);
> > which should indirectly call twl4030_usb_set_mode to set the
> > POWER_CTRL_OTG_ENAB bit. This enables the prescaler hardware
> > for ADC8 (VBUS) channel. But this does not happen for reasons
> > outside the charger driver.
> > 
how should that work?
I only have seen the call trace from the musb/omap2430.c glue though
the phy subsystem (via phy_ops) to  twl4030_phy_power_on (which sets
the important bit).
And the phy subsystem has its own power refcounting system which
is brought into disorder by unbalanced calls from the musb system...

Regards,
Andreas
