From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/4] MFD: twl4030: add twl4030_codec MFD as
	a new child to the core
Date: Thu, 22 Oct 2009 14:02:08 +0300
Message-ID: <200910221402.08837.peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091022075748.GA8105@sortiz.org>
	<20091022105517.GB18862@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091022105517.GB18862@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 22 October 2009 13:55:17 ext Mark Brown wrote:
> On Thu, Oct 22, 2009 at 09:57:49AM +0200, Samuel Ortiz wrote:
> > It seems to me that this patchset is mostly an asoc one, even though all
> > of those patches depend on the MFD one. So I'd perfectly fine if they'd
> > all go through Mark's tree, and then I'd have to make sure I'm sending =
my
> > 2.6.33 merge window pull request _after_ Mark's code is in Linus tree.
> > Once it's there, I can work on merging conflicts with the few
> > twl4030-core pending patches from my tree. Mark, what do you think ?
> =

> Seems reasonable.  I'll apply them on a separate branch and merge them
> into my 2.6.33 branch so that you can merge them into your tree too and
> avoid any cross-tree issues without needing to think about how things
> get merged with Linus (though since Takashi generally merges early it'll
> probably happen naturally anyway).  Note that if you do pull this branch
> you won't be able to rebase your tree, you'd have to merge up Linus'
> tree instead (but that'd be handy anyway :) ).

I just sent the second series, I'll hope the I have not missed anything. =

I was scratching my head on which tree it should be going, but it is really=
 nice =

to see that it can be done like this.
Thank you Samuel, Mark and Tony!

-- =

P=E9ter
