From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Tue, 2 Jun 2015 10:58:45 -0700
Message-ID: <20150602175845.GB11297@dtor-ws>
References: <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
 <20150601152111.GA14015@amd>
 <20150601174730.GA30024@dtor-ws>
 <20150601212226.GH23777@lukather>
 <20150601213213.GB14395@dtor-ws>
 <20150602094447.GW23777@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35694 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759550AbbFBR6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 13:58:50 -0400
Content-Disposition: inline
In-Reply-To: <20150602094447.GW23777@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

On Tue, Jun 02, 2015 at 11:44:47AM +0200, Maxime Ripard wrote:
> On Mon, Jun 01, 2015 at 02:32:13PM -0700, Dmitry Torokhov wrote:
> > On Mon, Jun 01, 2015 at 11:22:26PM +0200, Maxime Ripard wrote:
> > > Hi Dmitry,
> > > 
> > > On Mon, Jun 01, 2015 at 10:47:30AM -0700, Dmitry Torokhov wrote:
> > > > On Mon, Jun 01, 2015 at 05:21:11PM +0200, Pavel Machek wrote:
> > > > > 
> > > > > 
> > > > > > > > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> > > > > > > > 
> > > > > > > > You were very welcome to review this patch at the time and/or suggest
> > > > > > > > a fix that pleases everyone.
> > > > > > > 
> > > > > > > You should be the one that should suggest fixes, as you broke it in
> > > > > > > the first place. But clearly you don't understand that.
> > > > > > 
> > > > > > You actually never asked for a fix, and went head first calling this
> > > > > > patch "bad" and asking for nothing but reverting it.
> > > > > 
> > > > > Date: Fri, 29 May 2015 21:08:16 +0200
> > > > > Subject: 4.1 touchscreen regression on n900 -- pinpointed [was Re:
> > > > > linux-n900
> > > > > ...
> > > > > Maxime, can you suggest a fix?
> > > > 
> > > > How about we do something like below (it needs a small edt-ft5x06 fixup
> > > > that I'll send separately). Not tested.
> > > > 
> > > > Thanks.
> > > > 
> > > > -- 
> > > > Dmitry
> > > > 
> > > > 
> > > > Input: improve parsing OF parameters for touchscreens
> > > > 
> > > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > 
> > > > When applying touchscreen parameters specified in device tree let's make
> > > > sure we keep whatever setup was done by the driver and not reset the
> > > > missing values to zero.
> > > > 
> > > > Reported-by: Pavel Machek <pavel@ucw.cz>
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >  drivers/input/touchscreen/edt-ft5x06.c     |    2 -
> > > >  drivers/input/touchscreen/of_touchscreen.c |   67 ++++++++++++++++++----------
> > > >  drivers/input/touchscreen/tsc2005.c        |    2 -
> > > >  include/linux/input/touchscreen.h          |    5 +-
> > > >  4 files changed, 48 insertions(+), 28 deletions(-)
> > > > 
> > > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > > > index 29d179a..394b1de 100644
> > > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > > @@ -1041,7 +1041,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> > > >  			     0, tsdata->num_y * 64 - 1, 0, 0);
> > > >  
> > > >  	if (!pdata)
> > > > -		touchscreen_parse_of_params(input);
> > > > +		touchscreen_parse_of_params(input, true);
> > > >  
> > > >  	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIRECT);
> > > >  	if (error) {
> > > > diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
> > > > index b82b520..c132624 100644
> > > > --- a/drivers/input/touchscreen/of_touchscreen.c
> > > > +++ b/drivers/input/touchscreen/of_touchscreen.c
> > > > @@ -14,14 +14,22 @@
> > > >  #include <linux/input/mt.h>
> > > >  #include <linux/input/touchscreen.h>
> > > >  
> > > > -static u32 of_get_optional_u32(struct device_node *np,
> > > > -			       const char *property)
> > > > +static bool touchscreen_get_property_u32(struct device_node *np,
> > > > +					 const char *property,
> > > > +					 unsigned int default_value,
> > > > +					 unsigned int *value)
> > > >  {
> > > >  	u32 val = 0;
> > > > +	int error;
> > > >  
> > > > -	of_property_read_u32(np, property, &val);
> > > > +	error = of_property_read_u32(np, property, &val);
> > > > +	if (error) {
> > > > +		*value = default_value;
> > > > +		return false;
> > > > +	}
> > > >  
> > > > -	return val;
> > > > +	*value = val;
> > > > +	return true;
> > > 
> > > This looks good.
> > > 
> > > However, of_property_read_u32 already does the right thing here by not
> > > update val if the property is not found.
> > 
> > I know but it is not documented anywhere (as far as I know) so I'd
> > rather not rely on the implementation detail that might change in the
> > future. This is not a hot path so extra assignment should not hurt.
> 
> It is actually: http://lxr.free-electrons.com/source/drivers/of/base.c#L1231

OK, fair enough. But not for ACPI properties (and I think we should
convert the parser to device_property_read_xxx() so it is usable
everywhere).

Thanks.

-- 
Dmitry
