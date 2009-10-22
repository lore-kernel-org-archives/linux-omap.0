From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] MFD: twl4030: add twl4030_codec MFD as
 a new child to the core
Date: Thu, 22 Oct 2009 11:55:17 +0100
Message-ID: <20091022105517.GB18862@rakim.wolfsonmicro.main>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
	<20091021231311.GF17796@sortiz.org>
	<200910220904.32676.peter.ujfalusi@nokia.com>
	<20091022075748.GA8105@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091022075748.GA8105@sortiz.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 22, 2009 at 09:57:49AM +0200, Samuel Ortiz wrote:

> It seems to me that this patchset is mostly an asoc one, even though all of
> those patches depend on the MFD one. So I'd perfectly fine if they'd all go
> through Mark's tree, and then I'd have to make sure I'm sending my 2.6.33
> merge window pull request _after_ Mark's code is in Linus tree. Once it's
> there, I can work on merging conflicts with the few twl4030-core pending
> patches from my tree. Mark, what do you think ?

Seems reasonable.  I'll apply them on a separate branch and merge them
into my 2.6.33 branch so that you can merge them into your tree too and
avoid any cross-tree issues without needing to think about how things
get merged with Linus (though since Takashi generally merges early it'll
probably happen naturally anyway).  Note that if you do pull this branch
you won't be able to rebase your tree, you'd have to merge up Linus'
tree instead (but that'd be handy anyway :) ).
