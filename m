From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 06/11] OMAP2+: use control module mfd
 driver in omap_type
Date: Fri, 1 Jun 2012 04:35:30 -0700
Message-ID: <20120601113530.GN12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-7-git-send-email-eduardo.valentin@ti.com>
	<4FBF80D5.2000600@ti.com>
	<CAMQu2gyjJdJZKAf+TJwQfQ2BgAXe_s-soTcs7Am6O4+yy=7cLQ@mail.gmail.com>
	<20120528112417.GF3923@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120528112417.GF3923@besouro>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Eduardo Valentin <eduardo.valentin@ti.com> [120528 04:28]:
> On Mon, May 28, 2012 at 03:32:50PM +0530, Shilimkar, Santosh wrote:
> > On Fri, May 25, 2012 at 6:23 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > >
> > > OK, not really related to that patch, but the previous cpu_is_omap24xx makes
> > > me think of that :-)
> > >
> > > What about the omap<X>_check_revision used by cpu_is_XXX?
> > >
> > > This call is the very first one to require the control module access in
> > > order to get the ID_CODE inside the control module.
> > >
> > > So far it still use that ugly hard coded phys -> virtual address macro that
> > > is sued for that.
> > >
> > Agree with Benoits comment. One way to deal with this is,
> > store the register offset with init and then just use it here.
> > 
> > That way you can get rid of all cpu_is_XXXX() from this function.
> 
> I see. I need to check how this storing would look like.
> Probably we can do the storing when the early device gets probed.

As this needs to be initialized very early I'd rather avoid dependencies
to drivers for this. Maybe that register can be read and saved when the
device gets built? It's ioremapped anyways at that point.

That is assuming we don't need to export it to drivers or constantly
read it..

Tony
