From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Fri, 8 Jan 2016 07:13:58 +0200
Message-ID: <568F4596.8020206@gmail.com>
References: <20160105041356.GE12777@atomide.com> <20160105084947.GG22661@pali>
 <20160105224929.GF12777@atomide.com> <20160106174039.GA14271@earth>
 <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
 <20160107180700.GN12777@atomide.com> <568EDC8D.7070205@gmail.com>
 <20160108022619.GS12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160108022619.GS12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi

On  8.01.2016 04:26, Tony Lindgren wrote:
>
> Yes it seems there's some other issue too. Maybe you can run git bisect
> again and carry the fix along as an extra patch?
>

No sane way to bisect, I don't really know what triggers the issue. 
Neither it is triggered regularly. It might happen on the first reboot 
or on the tenth, or ... And it looks like the problems happens sometimes 
on oops too. Not to say that it seems I should have fully booted 
userspace (so there is enough pressure on the ubi/mdt/nand subsystems), 
which is impossible with upstream without some n900 specific patches :(

Maybe we can get some ideas on what and where to look from ubifs people? 
Though I don't know whom to cc, feel free to help :)

My best bet aiui, is comparing what nokia omap1 kernel does vs upstream. 
Or looking at the commit log in ubi/mtd/onenand - who knows, I might get 
lucky once again the same way as with that phonet oops in 
__netif_receive_skb_core.

>
> OK then it really seems like we do have another bug lurking around.

:nod:

> Maybe you can figure out an easier way to reproduce it?
>

I doubt, but who knows.

>> The problem is that between NOLO and kernel there is u-boot. And even if I
>> am almost sure it doesn't touch onenand configs, I can't be absolutely sure.
>> So those timings are not 100% reliable IMO, though close to that.
>
> Hmm yes I'm only booting with u-boot here as my device sits in my rack.
>

I booted the device via flasher with initrd from the so-called rescueos 
(https://n900.quitesimple.org/rescueOS/rescueOS-1.2/) - it provides 
shell with tons of useful tools if your device is in bootloop etc. CS0 
registers were the same as with u-boot, so it is not that one.

>
> OK will push it out then.
>

Thanks,
Ivo
