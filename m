From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: [linux-pm] [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 19:45:43 +0300
Message-ID: <20100917164543.GI20325@esdhcp04044.research.nokia.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100917153643.GC29739@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nishanth Menon <nm@ti.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, "Valentin Eduardo (Nokia-MS/Helsinki)" <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Thara Gopinath <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Roberto Granados Dorado <x0095451@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@vger.kernel.org>, Romit Dasgupta <ro.mit@ti.com>, "Kristo Tero (Nokia-MS/Tampere)" <Tero.Kristo@nokia.com>, Andrew Morton <akpm@lin>
List-Id: linux-omap@vger.kernel.org

On 17/09/10 17:36 +0200, ext Mark Brown wrote:
> On Thu, Sep 16, 2010 at 08:29:33PM -0500, Nishanth Menon wrote:
> 
> > +struct opp_def {
> > +	unsigned long freq;
> > +	unsigned long u_volt;
> > +
> > +	bool enabled;
> > +};
> 
> It might be clearer to use some term other than enabled in the code -
> when reading I wasn't immediately sure if enabled meant that it was
> available to be selected or if it was the active operating point.  How
  ^^^^^^^^^
> about 'allowed' (though I'm not 100% happy with that)?

I think your query contains its own answer.

Phil
