From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] mfd: twl4030-power: Add support for board specific
 configuration
Date: Mon, 28 Apr 2014 08:36:20 -0700
Message-ID: <20140428153620.GJ20807@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-3-git-send-email-tony@atomide.com>
 <20140428114726.GW21279@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140428114726.GW21279@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [140428 04:47]:
> > With the recommended twl4030 configuration added, we can now add
> > board specific changes as modifications to the recommended
> > configuration.
> > 
> > Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
> >  include/linux/i2c/twl.h     |  1 +
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> > index 89a8528..89c6b1a 100644
> > --- a/drivers/mfd/twl4030-power.c
> > +++ b/drivers/mfd/twl4030-power.c
> > @@ -511,13 +511,34 @@ twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
> >  	return 0;
> >  }
> >  
> > +static void twl4030_patch_rconfig(struct twl4030_resconfig *common,
> > +				  struct twl4030_resconfig *board)
> > +{
> > +	while (common->resource) {
> > +		struct twl4030_resconfig *b = board;
> > +
> > +		while (b->resource) {
> > +			if (b->resource == common->resource) {
> > +				*common = *b;
> > +				break;
> > +			}
> > +			b++;
> > +		}
> > +		common++;
> > +	}
> > +}
> 
> Forgive my ignorance, as I don't know how 'common' is setup, but we
> appear to move to the next 'common' reference them immediately
> dereference it without checking to see if it actually exists. Same
> with 'b'. What happens if we reach the end of the array? NULL
> dereference or does the final element always have a NULLed resource
> attribute?

Yes there's always a NULL entry at the end of the list always in
this case, and the configured lists are always static in the driver.

Regards,

Tony
