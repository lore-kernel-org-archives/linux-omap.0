From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4 v2] MFD: twl4030: add twl4030_codec MFD
 as a new child to the core
Date: Sun, 25 Oct 2009 17:18:39 +0000
Message-ID: <20091025171838.GA5141@sirena.org.uk>
References: <1256207208-25010-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256207208-25010-2-git-send-email-peter.ujfalusi@nokia.com>
	<20091023140703.GA3718@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091023140703.GA3718@sortiz.org>
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
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 23, 2009 at 04:07:05PM +0200, Samuel Ortiz wrote:

> As agreed, Mark is taking this one. So:
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Applied all, if there's a merge problem with the MFD code then there's a
twl4030-mfd branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

which I'm happy for you to merge if it makes life easier.  Due to other
changes the patches end up depending on (just textually I think) there's
a big raft of other stuff in there too, sadly.
