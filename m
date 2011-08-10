From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Build failure: bisected: v3.1-rc1 with config ARCH_OMAP &&
 !ARCH_OMAP4 fails with linker error
Date: Wed, 10 Aug 2011 03:34:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108100333520.12674@utopia.booyaka.com>
References: <1312819724.14483.29.camel@morsingpad> <alpine.DEB.2.00.1108081435340.4764@utopia.booyaka.com> <20110809131453.GR1866@atomide.com> <alpine.DEB.2.00.1108092102580.12674@utopia.booyaka.com> <alpine.DEB.2.00.1108100045270.12674@utopia.booyaka.com>
 <20110810092139.GD1939@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110810092139.GD1939@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Daniel Morsing <daniel.morsing@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 10 Aug 2011, Tony Lindgren wrote:

> Thanks yes that does the trick. I'd like to queue this immediately so we
> have more time to look at the other fixes if you don't mind.

That's fine, feel free to send this first.  Will try to have the rest of 
my 3.1-rc fixes ready to go in a few days.

> I noticed some checkpatch warnings, updated patch below. Does that look
> OK to you?

Fine by me.

- Paul
