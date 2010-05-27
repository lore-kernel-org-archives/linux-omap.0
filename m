From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 15:27:50 +0300
Message-ID: <4BFE6546.9070300@nokia.com>
References: <20100526151945.1b3813ac@schatten.dmk.lab>	<Pine.LNX.4.44L0.1005261033440.1961-100000@iolanthe.rowland.org> <20100527125605.2855f980@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527125605.2855f980@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Florian Mickler <florian@mickler.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Linux@smtp1.linux-foundation.org" <Linux@smtp1.linux-foundation.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

ext Florian Mickler wrote:

>
> Converting a driver to using any constraint-API would require analysing
> what makes a driver refuse suspending in the old suspend handler and
> then specify any "no suspend" (or whatever) constraint before those
> conditions arise and clearing of the constraints when it is no longer critical.  
> (Much work.)
>   

That's not really true.
Nothing prevents using from the beginning a sane approach where drivers 
are required to specify constraints.

The way it has been done for the N900 was to let driver developers 
specify _very_ conservative constraints, during the conversion phase.

Then each driver has been optimized.

If you have as requirement for driver developers that their driver must 
be working properly when compiled as module, it is possible to test the 
system with a minimalistic kernel which enters the lowest power state as 
soon as possible, plus only those modules that are being optimized.

This allows also to identify parasitic drivers, which fail to apply the 
proper constraint and instead rely on some other driver to keep the 
system alive.

igor
