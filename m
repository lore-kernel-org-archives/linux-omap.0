From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4 v2] ASoC: TWL4030: Driver
	registration	via twl4030_codec MFD
Date: Fri, 23 Oct 2009 13:59:31 +0100
Message-ID: <20091023125930.GA8198@sirena.org.uk>
References: <1256207208-25010-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256207208-25010-5-git-send-email-peter.ujfalusi@nokia.com>
	<20091022165643.GA28051@rakim.wolfsonmicro.main>
	<200910230827.55141.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200910230827.55141.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 23, 2009 at 08:27:55AM +0300, Peter Ujfalusi wrote:

> Hmm, what do you mean by that?
> I have checked it, and selecting the machine driver will enables the MFD_CORE 
> and TWL4030_CODEC in .config, also disabling the machine driver will also 
> disable the MFD_CORE and the TWL4030_CODEC.

> Can you go into details?

Kconfig has never guaranteed to pay any attention to dependencies of
things that were enabled as a result of a select statement - they would
be silently ignored.  I've done some tests and it does seem that this is
doing what would be expected at the minute but looking at the Kconfig
changelogs I can't see anything that makes this an intentional change.
