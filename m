From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: omap2+: omap_hwmod: Fix false lockdep warning
Date: Mon, 9 Feb 2015 14:16:35 -0800
Message-ID: <20150209221634.GD2531@atomide.com>
References: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
 <20150206141346.GP21418@twins.programming.kicks-ass.net>
 <54D4E64C.7060208@ti.com>
 <20150206183205.GS21418@twins.programming.kicks-ass.net>
 <54D5154F.8080208@ti.com> <54D86F74.7070703@ti.com>
 <alpine.DEB.2.02.1502091557450.3767@utopia.booyaka.com>
 <20150209173110.GI25235@atomide.com>
 <alpine.DEB.2.02.1502091835380.3767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1502091835380.3767@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, balbi@ti.com, mingo@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [150209 10:59]:
> On Mon, 9 Feb 2015, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [150209 08:04]:
> > > On Mon, 9 Feb 2015, Peter Ujfalusi wrote:
> > > 
> > > > On 02/06/2015 09:26 PM, Peter Ujfalusi wrote:
> > > > >> Yeah, I've never really bothered with data too much, its a debug
> > > > >> feature. So lock_class_key is 8 bytes, and strictly speaking you could
> > > > >> union them over other fields, all we really need is unique addresses, we
> > > > >> don't actually use the storage.
> > > > > 
> > > > > True. our omap2plus defconfig does not have LOCKDEP enabled so it should not
> > > > > add anything to the data when running default kernel.
> > > > > I'll test the lockdep_set_class() method you suggested on Monday (not
> > > > > tomorrow), but still as first thing.
> > > > > If it is working as expected I'll send a patch with you as author.
> > > > 
> > > > With omap2plus_defconfig my build produces (vmlinux size):
> > > > Base: 				99905522
> > > > with my series:			99908385 (base + 2863)
> > > > with Peter Zijlstra's patch:	99910625 (base + 5103)
> > > > 
> > > > The reason for this is that we will only have
> > > > struct lock_class_key { };
> > > > in case of !CONFIG_LOCKDEP. On ARM however CONFIG_LOCKDEP is enabled by
> > > > default, while the CONFIG_DEBUG_LOCKDEP is disabled.
> > > > 
> > > > So it does add more data to our default omap2plus config.
> > > > 
> > > > Tony: do you have preference on the way we fix this issue?
> > > > 
> > > > As I recall there is a plan to remove the hwmod static database and move it or
> > > > generate it from DT? Not sure when and how this will be done, but will it
> > > > affect the lockdep_set_class() way?
> > > 
> > > Well I guess we could see what Tony says, but you do realize that the 
> > > difference in sizes that you posted above is about .003% of the total 
> > > binary size, right?  
> > > 
> > > If there's one thing we can say about the last few years of ARM kernel 
> > > development, it's that those kind of size increases are utterly dwarfed by 
> > > other changes in the kernel.  So I'd say, post a patch based on PeterZ's 
> > > fix and be done with it...
> > 
> > Well the thing to consider here is what Peter U is saying about
> > having struct omap_hwmod allocated based on the data from .dts
> > files. If the fix makes the dynamic allocation harder to do later on,
> > we should probably avoid it. If it's relatively easy to do later on,
> > then I don't have a problem with it.
> 
> The future destination for that code that makes the most sense to me is 
> for it to become integrated with the OMAP Sonics & Arteris bus drivers and 
> DT data.  So I wouldn't worry too much about it; I don't think the 
> lockdep fix will affect that at all.

OK up to you guys then.

Regards,

Tony
