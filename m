From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2] input:
 CMA3000 Accelerometer driver)
Date: Mon, 30 Aug 2010 09:28:56 -0700
Message-ID: <20100830162855.GA17325@core.coreip.homeip.net>
References: <15445.10.24.255.17.1274424777.squirrel@dbdmail.itg.ti.com>
 <20100829184904.GC26209@core.coreip.homeip.net>
 <36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Hemanth V <hemanthv@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, igor.stoppa@nokia.com, kai.svahn@nokia.com, matthias.nyman@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Mon, Aug 30, 2010 at 11:04:39AM -0500, Felipe Balbi wrote:
> Hi Dmitry,
> 
> When we tried to push N900's accelerometer driver as an
> input device you commented you didn't want sensors such
> as accelerometers, magnetometers, proximity, etc on the
> input layer because "they are not user input", although
> I didn't fully agree with you, we had to modify the drivers
> and, I believe, one of them is sitting in staging under
> the industrial i/o subsystem.
> 
> Are you now accepting sensor drivers on the input layer ?
> that will make our life a lot easier but we need some
> definition to avoid having to re-work drivers when we
> want to push them to mainline.
> 

I got persuaded that 3-axis accelerometers are most often indended to be
used as input devices so I decided I should take these in (adxl134x is
there). I still think that sensor devices in general are better suited
to IIO subsystem and I hope it will get out of staging soon.

Once it is out of staging we may think about creating a IIO-to-input
bridge (copuld be either in kernel or a userspace solution based on
uinput) to route sensors that are indeed used as HIDs.

Hope this makes sense.

-- 
Dmitry
