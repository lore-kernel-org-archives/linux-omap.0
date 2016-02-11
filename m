From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Wed, 10 Feb 2016 17:08:18 -0800
Message-ID: <20160211010818.GQ19432@atomide.com>
References: <20160126140010.GA29723@amd> <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd> <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd> <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd> <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd> <20160209172403.GK19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160209172403.GK19432@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160209 09:26]:
> * Pavel Machek <pavel@ucw.cz> [160207 13:24]:
> 
> > ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
> > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> Bit 21 in cm_idlest1_core is for MCSPI4 so WLAN. Does that go
> down if do sleep 5; cat /sys/kernel/debug/pm_debug/count ?
> 
> If not, the're PM runtime missing or broken somewhere.

Just tested n900 wlan here and it's working for me with Emil's
patch from the "" thread and the PM runtime regression fix for
hsmmc I posted earlier today. Looks like n900 is hitting off
mode just fine with wlan0 configured.

It does not wake up to pings from outside from off mode though
until the system wakes up.

I'll take a look and send a patch for that separately.

Regards,

Tony
