From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Fri, 8 Jan 2016 09:10:14 -0800
Message-ID: <20160108171013.GW12777@atomide.com>
References: <20160105224929.GF12777@atomide.com> <20160106174039.GA14271@earth>
 <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
 <20160107180700.GN12777@atomide.com> <568EDC8D.7070205@gmail.com>
 <20160108022619.GS12777@atomide.com> <568F4596.8020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <568F4596.8020206@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160107 21:14]:
> Hi
> 
> On  8.01.2016 04:26, Tony Lindgren wrote:
> >
> >Yes it seems there's some other issue too. Maybe you can run git bisect
> >again and carry the fix along as an extra patch?
> 
> No sane way to bisect, I don't really know what triggers the issue. Neither
> it is triggered regularly. It might happen on the first reboot or on the
> tenth, or ... And it looks like the problems happens sometimes on oops too.
> Not to say that it seems I should have fully booted userspace (so there is
> enough pressure on the ubi/mdt/nand subsystems), which is impossible with
> upstream without some n900 specific patches :(

Hmm OK. Can you check if disabling deeper idle states helps?

Just set the UART timeouts to -1. You may also want to disable off mode
with echo 0 > /sys/kernel/debug/pm_debug/enable_off_mode.

If it happens during booting, chances are idle is not even hit though.

> Maybe we can get some ideas on what and where to look from ubifs people?
> Though I don't know whom to cc, feel free to help :)
> 
> My best bet aiui, is comparing what nokia omap1 kernel does vs upstream. Or
> looking at the commit log in ubi/mtd/onenand - who knows, I might get lucky
> once again the same way as with that phonet oops in
> __netif_receive_skb_core.

Well maybe we now have error messages that actually make sense?

> >OK then it really seems like we do have another bug lurking around.
> 
> :nod:

I've sent out the pull request and Arnd pulled the fix into arm-soc
so we should have it merged for v4.4 FYI.

Regards,

Tony
