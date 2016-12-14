From: Tony Lindgren <tony@atomide.com>
Subject: Re: partial bluetooth success on n900 [was Re: bluetooth/uart
 timeout handling]
Date: Wed, 14 Dec 2016 08:02:47 -0800
Message-ID: <20161214160246.GA4920@atomide.com>
References: <20161016002454.ul5rdqwubvkct4pf@earth>
 <20161018224259.jrwbaal27irzjqyo@earth>
 <20161019092506.GA1461@amd>
 <201612141321.30181@pali>
 <20161214125323.GA4951@amd>
 <20161214133158.mwvs574l4otbc7hf@earth>
 <20161214151056.GX4920@atomide.com>
 <20161214155208.ocs4vw77expduefr@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161214155208.ocs4vw77expduefr@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [161214 07:52]:
> On Wed, Dec 14, 2016 at 07:10:56AM -0800, Tony Lindgren wrote:
> > Maybe send it so we can merge it as a fix during the early -rc
> > cycle?
> 
> Sorry if I was not clear enough: mainline does *not* contain
> incorrect DT information. My bluetooth RFC patches did. So
> this can go into the kernel once the driver is there and
> the binding got accepted.

Oh OK good to hear.

> Alternatively I can prepare a patch, which just adds the
> cts/rts pinmux for the bluetooth UART, but it's not very
> useful on its own.

OK sounds like no rush until other pieces are ready.

Regards,

Tony
