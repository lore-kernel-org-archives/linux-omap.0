From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 05/12] arm: omap3: am35x: Add PWROFF feature
Date: Wed, 11 Apr 2012 16:11:39 -0700
Message-ID: <20120411231139.GH31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-6-git-send-email-mgreer@animalcreek.com>
 <87iph5q43n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87iph5q43n.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 11, 2012 at 03:46:20PM -0700, Kevin Hilman wrote:
> Hi Mark,
> 
> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> > Typical OMAP3 SoCs have four power domain states: ON,
> > INACTIVE, RETENTION, and OFF.  The am35x family of SoCs
> > has only two states: ON and INACTIVE.  To distinguish which
> > set of states the current device has, add the 'OMAP3_HAS_PWROFF'
> > feature.  When that feature/bit is set, the device supports the
> > RETENTION and OFF states; otherwise, it doesn't.
> >
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> Paul has mentioned this already, but the same applies here: We shouldn't
> be using SoC-global feature flag for this.   We already have per-pwrdm
> flags that indicate what states a given powerdomain suports (see .pwrsts
> field.)
> 
> Wherever we have blind writes to next powerstates that assume support
> for RET/OFF is present, those should probably use a helper function from
> the powerdomain code that checks if that state is even supported.

Okay, thanks Kevin.

> Jean's work on functional powerstates will probably help here if you
> really need to support INACTIVE.  However, Paul may be right in that you
> might just start with supporing ON only, and validate that module-level
> wakups acutally work.

Yeah, I'm going to do that as soon as I catch up the emails.  I thinking
more & more that Paul is right and that we should just scrap the INACTIVE
state and leave everything ON.

Mark
--
