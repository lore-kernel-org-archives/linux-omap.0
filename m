From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] serial: 8250: omap: Fix idling of clocks for unused
 uarts
Date: Fri, 4 May 2018 10:58:48 -0700
Message-ID: <20180504175848.GE98604@atomide.com>
References: <20180504173103.73881-1-tony@atomide.com>
 <20180504173931.GD98604@atomide.com>
 <20180504174826.b7hls2c6v7gukdgl@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504174826.b7hls2c6v7gukdgl@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180504 17:50]:
> On 2018-05-04 10:39:31 [-0700], Tony Lindgren wrote:
> > Uhh sorry I managed to commit also a patch I was testing while
> > updating patch comments.. Will send out v3 shortly, this can be
> > ignored.
> 
> I assumed you were helping out to sneak a patch in.

Heheh, at least it proves I did have it applied before I replied
with my Boot-tested-for-few-times-by :)

Tony
