From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Sun, 19 Sep 2010 20:46:44 +0100
Message-ID: <20100919194643.GB9871@sirena.org.uk>
References: <20100917121958.1dbb57af.akpm@linux-foundation.org>
	<4C93DC4E.5020506@ti.com> <201009180107.51664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009180107.51664.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Granados Dorado, Roberto" <x0095451@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 18, 2010 at 01:07:51AM +0200, Rafael J. Wysocki wrote:
> On Friday, September 17, 2010, Nishanth Menon wrote:

> > there were a few OMAP followon patches from
> > http://marc.info/?l=linux-omap&m=128152135801634&w=2
> > which will actually use this for OMAP3 platform.

> Still, the $subject patch doesn't use it.  So perhaps add it in a separate patch?

By the same argument nothing in this patch causes the code to become
used so we may as well not include it at all :)

More seriously, looking at a lot of the questions that people are
raising it might make the review a bit easier if the patch were posted
in a series along with an initial user or two to provide some context
for the expected usage.
