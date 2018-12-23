From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Sun, 23 Dec 2018 08:15:30 -0800
Message-ID: <20181223161530.GL6707@atomide.com>
References: <20181221011752.25627-1-sre@kernel.org>
 <20181221180205.GH6707@atomide.com>
 <20181222024753.d4mge5m3x3vqfrt6@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181222024753.d4mge5m3x3vqfrt6@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [181222 02:48]:
> On Fri, Dec 21, 2018 at 10:02:05AM -0800, Tony Lindgren wrote:
> > Hmm so looks like nothing to configure for the clocks or
> > CPCAP_BIT_ST_L_TIMESLOT bits for cap for the EXT? So the
> > wl12xx audio is wired directly to cpcap EXT then and not a
> > TDM slot on the mcbsp huh?
> 
> For FM radio it's directly wired to EXT with no DAI being required.
> I think that EXT is only used by FM radio and not by bluetooth. BT
> seems to use TDM.

OK then it sounds like we just need a diff -u of the cpcap regs
from Android with cpcaprw --all before and after using a bluetooth
headset during a voice call to configure it for voice calls for the
TDM. I think snd-soc-motmd just needs the voice output specified
in the mixer in addition to the cpcap configuration.

I don't think have any bluetooth audio gear though, maybe somebody
using a headset can post the diff.

Regards,

Tony
