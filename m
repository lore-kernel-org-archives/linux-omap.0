From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2] input:
 CMA3000 Accelerometer driver)
Date: Mon, 30 Aug 2010 13:44:12 -0700
Message-ID: <20100830204412.GA28711@core.coreip.homeip.net>
References: <15445.10.24.255.17.1274424777.squirrel@dbdmail.itg.ti.com>
 <20100829184904.GC26209@core.coreip.homeip.net>
 <36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
 <20100830214025.2f9677a1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100830214025.2f9677a1@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Felipe Balbi <me@felipebalbi.com>, Hemanth V <hemanthv@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, igor.stoppa@nokia.com, kai.svahn@nokia.com, matthias.nyman@nokia.com
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 30, 2010 at 09:40:25PM +0100, Alan Cox wrote:
> On Mon, 30 Aug 2010 11:04:39 -0500
> Felipe Balbi <me@felipebalbi.com> wrote:
> 
> > Hi Dmitry,
> > 
> > When we tried to push N900's accelerometer driver as an
> > input device you commented you didn't want sensors such
> > as accelerometers, magnetometers, proximity, etc on the
> > input layer because "they are not user input", although
> > I didn't fully agree with you, we had to modify the drivers
> > and, I believe, one of them is sitting in staging under
> > the industrial i/o subsystem.
> > 
> > Are you now accepting sensor drivers on the input layer ?
> > that will make our life a lot easier but we need some
> > definition to avoid having to re-work drivers when we
> > want to push them to mainline.
> 
> I would certainly vote for them being input when they are sometimes used
> that way - compasses for example do get used by applications (like
> compass programs, some of the real cool visualisation tools and things
> like live/game mixed gaming environments) and accelerometers are gaming
> inputs.

But do you believe that input should be the "primary residence" for the
devices when they are only _sometimes_ used as input devices? Or it
would make sense to employ a converter from XXX to input (either purely
in-kernel or userspace over uinput)?

Thanks.

-- 
Dmitry
