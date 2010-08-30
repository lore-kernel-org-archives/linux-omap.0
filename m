From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Sensors and the input layer (was Re: [RFC] [PATCH V2 1/2]
 input: CMA3000 Accelerometer driver)
Date: Mon, 30 Aug 2010 21:40:25 +0100
Message-ID: <20100830214025.2f9677a1@lxorguk.ukuu.org.uk>
References: <15445.10.24.255.17.1274424777.squirrel@dbdmail.itg.ti.com>
	<20100829184904.GC26209@core.coreip.homeip.net>
	<36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <36abcb34cfbf34724d9a581a75b53e76@secure211.sgcpanel.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hemanth V <hemanthv@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, igor.stoppa@nokia.com, kai.svahn@nokia.com, matthias.nyman@nokia.com
List-Id: linux-omap@vger.kernel.org

On Mon, 30 Aug 2010 11:04:39 -0500
Felipe Balbi <me@felipebalbi.com> wrote:

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

I would certainly vote for them being input when they are sometimes used
that way - compasses for example do get used by applications (like
compass programs, some of the real cool visualisation tools and things
like live/game mixed gaming environments) and accelerometers are gaming
inputs. Proximity is also input for some stuff although usually of much
more interest to the GUI manager than the GUI apps.

ALS is more of a dual purpose thing -light levels are input features to
the GUI on PDAs, although on many embedded devices they are most
definitely part of the IIO subsystem.



