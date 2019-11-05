From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 15:11:25 +0200
Message-ID: <20191105131125.GP32742@smile.fi.intel.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "marek.behun@nic.cz" <marek.behun@nic.cz>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "jonathanh@nvidia.com" <jonathan>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 05, 2019 at 12:54:55PM +0000, Vaittinen, Matti wrote:
> On Tue, 2019-11-05 at 14:20 +0200, Andy Shevchenko wrote:
> > On Tue, Nov 05, 2019 at 12:09:10PM +0200, Matti Vaittinen wrote:
> > > The patch series adds definitions for GPIO line directions.
> > > 
> > > For occasional GPIO contributor like me it is always a pain to
> > > remember
> > > whether 1 or 0 was used for GPIO direction INPUT/OUTPUT. Judging
> > > the
> > > fact that I removed few comments like:
> > > 
> > > /* Return 0 if output, 1 if input */
> > > /* This means "out" */
> > > return 1; /* input */
> > > return 0; /* output */
> > > 
> > > it seems at least some others may find it hard to remember too.
> > > Adding
> > > defines for these values helps us who really have good - but short
> > > duration - memory :]
> > > 
> > > Please also see the last patch. It adds warning prints to be
> > > emitted
> > > from gpiolib if other than defined values are used. This patch can
> > > be
> > > dropped out if there is a reason for that to still be allowed.
> > > 
> > > This idea comes from RFC series for ROHM BD71828 PMIC and was
> > > initially
> > > discussed with Linus Walleij here:
> > > https://lore.kernel.org/lkml/c06725c3dd34118a324907137758d8b85b3d4043.camel@fi.rohmeurope.com/
> > > but as this has no dependencies to BD71828 work (which probably
> > > takes a
> > > while) I decided to make it independent series.
> > > 
> > > Patches are compile-tested only. I have no HW to really test them.
> > > Thus I'd
> > > appreciate carefull review. This work is mainly about converting
> > > zeros
> > > and ones to the new defines but it wouldn't be first time I get it
> > > wrong
> > > in one of the patches :)
> > 
> > For all patches I have been Cc'ed to, NAK.
> > 
> > I don't see the advantages now since all known hardware uses the
> > single bit to
> > describe direction (even for Intel where we have separate gating for
> > in and out
> > buffers the direction we basically rely on the bit that enables out
> > buffer).
> > 
> > So, that said the direction is always 1 bit and basically 0/1 value. 
> 
> Yes. At least for now. And this patch didn't change that although it
> makes it possible to do so if required.
> 
> > Which one
> > is in and which one is out just a matter of an agreement we did.
> 
> This one is exactly the problem patch series was created for. Which one
> is IN and which is OUT is indeed a matter of an agreement - but this
> agreement should be clearly visible, well defined and same for all.
> 
> It's *annoying* to try finding out whether it was 1 or 0 one should
> return from get_direction callback for OUTPUT. This is probably the
> reason we have comments like
> 
> return 1; /* input */
> 
> there.
> 
> As this is global agreement for all GPIO framework users - not
> something that can be agreed per driver basis - we should have GPIO
> framework wide definitions for this. We can just add definitions for
> new drivers to benefit - but I think adding them also for existing
> drivers improves readability significantly (see below).
> 
> > I would also like to see bloat-o-meter statistics before and after
> > your patch.
> > My guts tell me that the result will be not in the favour of yours
> > solution.
> 
> Can you please tell me what type of stats you hope to see? 

bloat-o-meter. It's a script that compares two object files to see which
functions got fatter, and which are slimmer. You may find it in the kernel tree
sources (scripts/ folder).

> I can try
> generating what you are after. The cover letter contained typical +/-
> change stats from git and summary:
> 
> 62 files changed, 228 insertions(+), 104 deletions(-)
> 
> It sure shows that amount of lines was increased (roughly 2 lines more
> / changed file)

Which is making unneeded churn.

> - but I guess that was expected as I don't like
> ternary.

And I like them, so, what to do?

-- 
With Best Regards,
Andy Shevchenko
