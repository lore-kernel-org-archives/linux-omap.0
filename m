From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Thu, 11 Jul 2013 17:35:58 +0300
Message-ID: <51DEC2CE.70400@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com>
 <51DEA7F1.1050902@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51DEA7F1.1050902@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Roese <sr@denx.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/11/2013 03:41 PM, Stefan Roese wrote:
> On 07/11/2013 12:24 PM, Roger Quadros wrote:
>> My u-boot script is below and boot log is attached.
> 
> BTW: I noticed a git ID (8e1cacd) in your kernel that I can't identify.
> Do you have any patches locally applied to the kernel.org version that
> might be helpful with this USB issue I'm seeing?

Yes I had tested it on a more recent kernel with some local patches applied
that I've recently sent for review.

But to cross check with your setup I've retested it with commit d2b4a646 
with the 2 below patches on top

https://lkml.org/lkml/2013/6/20/327
https://lkml.org/lkml/2013/6/20/339

I've tried it again with the ELDK 5.3 root but still can't get it to fail.

I think we should match our u-boot as well. Could you please let me know
your u-boot commit and uEnv.txt?

My network setup is pretty simple, beagle-xm is connected directly to my laptop's
ethernet port. No network switch in between.

When you get the problem do you cold boot the board or warm boot it?
I've been always cold booting it.

cheers,
-roger
