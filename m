From: Tony Lindgren <tony@atomide.com>
Subject: Re: Linus HEAD build break
Date: Fri, 6 Nov 2015 11:03:51 -0800
Message-ID: <20151106190351.GC3218@atomide.com>
References: <871tc31atk.fsf@saruman.tx.rr.com>
 <87y4ebyznc.fsf@saruman.tx.rr.com>
 <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
 <87vb9fyyvn.fsf@saruman.tx.rr.com>
 <20151106145351.GA3218@atomide.com> <20151106153412.GA525@earth>
 <20151106160930.GB525@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151106160930.GB525@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Belisko Marek <marek.belisko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [151106 08:09]:
> Hi,
> 
> On Fri, Nov 06, 2015 at 04:34:12PM +0100, Sebastian Reichel wrote:
> > On Fri, Nov 06, 2015 at 06:53:52AM -0800, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [151106 06:41]:
> > > > Belisko Marek <marek.belisko@gmail.com> writes:
> > > > > On Fri, Nov 6, 2015 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> > > > >> Felipe Balbi <balbi@ti.com> writes:
> > > > >>> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
> > > > >>> subnode") breaks build on current linus/master (which current sits in
> > > > >>
> > > > >> this commit cannot be found in next. How come it's in linus/master ?
> > > > > I did post fix but Tony seems doesn't merge it:
> > > > > https://lkml.org/lkml/2015/10/13/816
> > > > 
> > > > looking at that thread, I have no idea how come the old version was
> > > > merged in the first place. Tony was clear that it broke build and yet
> > > > this patch has made its way to mainline and it didn't even go through
> > > > linux-next, which makes the problem worse.
> > > > 
> > > > Now we have a bisection point where the tree (well, some DTS files)
> > > > won't even build. This is quite messy.
> > > 
> > > Yes didn't I drop the patch and pointed out it breaks the build?
> > > 
> > > Guys, please stop doing this. Do not merge driver code that has
> > > not been sitting in linux next at least a week. And for the dts
> > > changes, please make sure you have proper acks.
> > > 
> > > And now we have yet another merge window where things unexpectedly
> > > break during the merge window because of untested driver changes.
> > > 
> > > Please repost the fix and I'll ack it and you guys send a new pull
> > > request to fix it ASAP explaining how it happened.
> > 
> > mh for some reason I accidently added it to my next branch. I'm not
> > sure why, since I did not intend to queue it at all. Sorry for the
> > mess.
> > 
> > I wonder why it has not been in next, though. Checking my next tree,
> > it should have been there since end of September.
> 
> I missed Stephen's messages about the build failure [0] and he
> switched to using a checkout from 20150925, which is directly before
> the patch. As a result this patch and all following patches have not
> been tested in linux-next :(
> 
> I will send a revert to you guys in a few minutes, so that I can get
> your ACK for sending it as pull request to Torvalds.

Sounds good to me.

Thanks

Tony

> [0] https://lkml.org/lkml/2015/9/28/844
