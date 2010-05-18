From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 17/18] omap: rx51: Add supplies for the tlv320aic3x
	codec driver
Date: Tue, 18 May 2010 13:00:26 +0300
Message-ID: <20100518130026.a979ac51.jhnikula@gmail.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
	<20100505193323.21568.32626.stgit@baageli.muru.com>
	<20100506065716.GA16262@besouro.research.nokia.com>
	<20100506070018.GB16262@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100506070018.GB16262@besouro.research.nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: eduardo.valentin@nokia.com
Cc: ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 6 May 2010 10:00:18 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> > > +static struct regulator_consumer_supply rx51_vio_supplies[] = {
> > > +	/* tlv320aic3x digital supplies */
> > > +	{
> > > +		.supply		= "IOVDD",
> > > +		.dev_name	= "2-0018"
> > > +	},
> > > +	{
> > > +		.supply		= "DVDD",
> > > +		.dev_name	= "2-0018"
> > > +	},
> > > +};
> > 
> > 
> > This isn't mandatory, but I find the code more readable if you use the REGULATOR_SUPPLY macro,
> > which kinda suitable for cases like yours, where you are passing the pair supply&dev_name.
>
Yeah, I was just following how the MMC supplies were defined in this
file and it's better to convert all of these to use REGULATOR_SUPPLY
macro. I'll send conversion patch on top of this + one adding couple
supplies more I would like to get in during this merge window.

> > > +static struct regulator_init_data rx51_vio = {
> > > +	.constraints = {
> > > +		.min_uV			= 1800000,
> > > +		.max_uV			= 1800000,
> > > +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> > > +					| REGULATOR_MODE_STANDBY,
> > > +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
> > 
> > I'm not sure if we would ever change voltage level in VIO in rx51 case.
> > It could enter sleep mode. But even there it wouldn't change voltage level.
> > Except, of cource, during off mode transition. But then, the regfw wouldn't care.
> 
> Actually, one correction here, even during off mode transition I believe we need to
> keep it, otherwise some wake up source would be screwed.
> > 
What do you think about those other TWL regulators, do they have valid
mask bits so would it make sense to correct all of them at once? I'm
not expert with TWL & RX51 HW but I'm thinking if there are also other
regulators which should not change. At least many regulators have the
same min_uV and max_uV defined.


-- 
Jarkko
