From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Date: Wed, 7 Feb 2018 14:32:20 -0600
Message-ID: <20180207203220.GB3992@uda0271908>
References: <20180127083403.928-1-andreas@kemnade.info>
 <20180206184725.GD21573@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180206184725.GD21573@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 06, 2018 at 10:47:25AM -0800, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [180127 08:34]:
> > On dm3730 there are enumeration problems after resume.
> > Investigation led to the cause that the MUSB_POWER_SOFTCONN
> > bit is not set. If it was set before suspend (because it
> > was enabled via musb_pullup()), it is set in
> > musb_restore_context() so the pullup is enabled. But then
> > musb_start() is called which overwrites MUSB_POWER and
> > therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> > enabled and the device is not enumerated.
> 
> I just gave this patch a quick try and things seem to behave
> for me from PM point of view:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks for testing it.

Regards,
-Bin.
