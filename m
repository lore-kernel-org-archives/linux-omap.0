From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: Drop bogus wkup domain oswr setting
Date: Wed, 16 Oct 2019 07:40:53 -0700
Message-ID: <20191016144053.GC5610@atomide.com>
References: <20191010001224.41826-1-tony@atomide.com>
 <20191010001224.41826-3-tony@atomide.com>
 <20191013150744.GD13278@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191013150744.GD13278@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191013 15:08]:
> Hi!
> 
> > The wkup domain is always on and does not have logic off setting. This
> > got accidentally added by commit f74297dd9354 ("ARM: OMAP2+: Make sure
> > LOGICRETSTATE bits are not cleared") but is harmless.
> > 
> > Cc: Merlijn Wajer <merlijn@wizzup.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/pm44xx.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -137,8 +137,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
> >  	 * smsc911x at least if per hits retention during idle.
> >  	 */
> >  	if (!strncmp(pwrdm->name, "core", 4) ||
> > -	    !strncmp(pwrdm->name, "l4per", 5) ||
> > -	    !strncmp(pwrdm->name, "wkup", 4))
> > +	    !strncmp(pwrdm->name, "l4per", 5))
> >  		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
> 
> This is rather theoretical, but if the powerdomain is called
> "corelation-not-causation", do you still want the if() to trigger?

No need to if no writable register bits exists if I understand
your theoretical comment right :)

Regards,

Tony
