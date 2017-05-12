From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Fri, 12 May 2017 10:21:35 -0700
Message-ID: <20170512172134.GI3489@atomide.com>
References: <20170511191005.GG7154@uda0271908>
 <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com>
 <20170511200220.GH7154@uda0271908>
 <20170511202306.GY3489@atomide.com>
 <20170511204406.GI7154@uda0271908>
 <20170511210628.GA3489@atomide.com>
 <20170512134042.GK7154@uda0271908>
 <20170512145849.GE3489@atomide.com>
 <20170512152144.GA651@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512152144.GA651@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu@ti.com> [170512 08:24]:
> On Fri, May 12, 2017 at 07:58:49AM -0700, Tony Lindgren wrote:
> > OK. No better ideas except I think we should probably have a separate
> > timer for keeping VBUS on after state changes eventually.
> 
> Currently with the patch below, VBUS is constantly on for host-only
> mode, and this is what we want. Why we need a separate timer? No one
> cuts VBUs now for host-only mode.

Oh I was just thinking what we might want to do in the future if
we want to cut off VBUS when no devices are connected. If we have
a USB modem for example it might first enumerate as some boot device,
then nothing for 20 seconds while it's booting, and then we have a
different device enumerating after the modem has booted. During this
period we want to keep VBUS on and will go through multiple
OTG_STATE_A_WAIT_BCON states. So we can't really control VBUS using
the OTG_STATE_WHATEVER alone.

Regards,

Tony
