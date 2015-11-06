From: Tony Lindgren <tony@atomide.com>
Subject: Re: Linus HEAD build break
Date: Fri, 6 Nov 2015 06:53:52 -0800
Message-ID: <20151106145351.GA3218@atomide.com>
References: <871tc31atk.fsf@saruman.tx.rr.com>
 <87y4ebyznc.fsf@saruman.tx.rr.com>
 <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
 <87vb9fyyvn.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87vb9fyyvn.fsf@saruman.tx.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [151106 06:41]:
> 
> Hi,
> 
> Belisko Marek <marek.belisko@gmail.com> writes:
> > Hi,
> >
> > On Fri, Nov 6, 2015 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> >>
> >> Hi again,
> >>
> >> Felipe Balbi <balbi@ti.com> writes:
> >>> Hi Marek,
> >>>
> >>> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
> >>> subnode") breaks build on current linus/master (which current sits in
> >>
> >> this commit cannot be found in next. How come it's in linus/master ?
> > I did post fix but Tony seems doesn't merge it:
> > https://lkml.org/lkml/2015/10/13/816
> 
> looking at that thread, I have no idea how come the old version was
> merged in the first place. Tony was clear that it broke build and yet
> this patch has made its way to mainline and it didn't even go through
> linux-next, which makes the problem worse.
> 
> Now we have a bisection point where the tree (well, some DTS files)
> won't even build. This is quite messy.

Yes didn't I drop the patch and pointed out it breaks the build?

Guys, please stop doing this. Do not merge driver code that has
not been sitting in linux next at least a week. And for the dts
changes, please make sure you have proper acks.

And now we have yet another merge window where things unexpectedly
break during the merge window because of untested driver changes.

Please repost the fix and I'll ack it and you guys send a new pull
request to fix it ASAP explaining how it happened.

Regards,

Tony
