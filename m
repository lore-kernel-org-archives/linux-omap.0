From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 10:40:36 -0700
Message-ID: <AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
References: <20100603074548.GA12104@flint.arm.linux.org.uk>
	<alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<20100603181010.GA25779@flint.arm.linux.org.uk>
	<1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org>
	<20100614083214.GA2104@pengutronix.de>
	<20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100712173228.GC9897@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Daniel Walker <dwalker@codeaurora.org>, Nicolas Pitre <nico@fluxnic.net>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Eric Miao <eric.miao@canonical.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 12, 2010 at 10:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> When you brought up the problem you seemed absolutely convinced
> that nothing except your solution was going to be acceptable.

That's not true. What's true is that you didn't seem to _understand_
my solution, so I tried to push the understanding of it.

There are always other solutions. I seriously doubt that Uwe's is a
maintainable one. That said, even a one-time "reduce the size of that
stinking pile of sh*t" is probably better than nothing.

I hope you at least do agree that the current situation is a steaming
pile of sh*t. And yes, I _will_ remove the crap, both from POWER and
ARM, unless I see some serious tries at fixing it.

               Linus
