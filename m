From: Peter Rosin <peda@axentia.se>
Subject: RE: OMAP 4430 SDP: rather sick with recent kernels
Date: Thu, 18 Dec 2014 11:48:31 +0000
Message-ID: <0625abeb83cd4ed88fdb38754b6a3086@EMAIL.axentia.se>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk> <5491F0B6.4090904@ti.com>
 <20141218101618.GJ11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141218101618.GJ11502@n2100.arm.linux.org.uk>
Content-Language: sv-SE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jyri Sarha <jsarha@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Russel King wrote:
*snip*
> Now, we have this call to snd_soc_of_parse_audio_routing(), which
> allocates some memory, copies the old routes into it, and then adds
> to them from DT.  That explains why the pointer and number of routes
> are different - there's 19 routes in omap4-sdp.dts - 17 + 19 = 36.
> So that doesn't work - but importantly, it does point towards a
> possible culpret - snd_soc_of_parse_audio_routing().
> 
> This is obvious when you stop and think about what it's doing, this is
> truely where this bug lies, and it /is/ in generic ASoC code.
> 
> The problem is that this function doesn't consider the implications of
> deferred probing.  Let's see what happens if we defer, and re-do the
> ABE initialisation, including calling this function:
> 
> 17 + 19 = 36. - first probe
> 17 + 19 + 19 = 55. - second probe
> 
> Oh - that works in terms of the number, and it would also explain why
> the table has been screwed - because the second time we memcpy(), we're
> memcpy()ing from data which was allocated via devm_kzalloc(), and thus
> would have been freed after the first failed probe.
> 
> Mark - this is a core ASoC problem.

Sorry about this, I wasn't even aware of deferred probing when I wrote
f8781db8aeb1. From my point of view, it is certainly possible to solve this
in the card driver which needs to add card dapm routes instead. So, a
revert is fine by me, if no better solution comes up.

Cheers,
Peter
