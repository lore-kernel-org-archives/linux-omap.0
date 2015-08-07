From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 07/13] twl4030_charger: distinguish between USB current
 and 'AC' current
Date: Fri, 7 Aug 2015 13:45:25 +1000
Message-ID: <20150807134525.251528ab@home.neil.brown.name>
References: <20150730001113.4012.18086.stgit@noble>
	<20150730001124.4012.48552.stgit@noble>
	<20150807031116.GH4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807031116.GH4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 6 Aug 2015 20:11:16 -0700 Tony Lindgren <tony@atomide.com>
wrote:

> * NeilBrown <neil@brown.name> [150729 17:28]:
> > --- a/drivers/power/twl4030_charger.c
> > +++ b/drivers/power/twl4030_charger.c
> >  static int twl4030_charger_update_current(struct twl4030_bci *bci)
> >  {
> >  	int status;
> > +	int cur;
> >  	unsigned reg, cur_reg;
> >  	u8 bcictl1, oldreg, fullreg;
> >  	bool cgain = false;
> >  	u8 boot_bci;
> >  
> > +	/*
> > +	 * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
> > +	 * and AC is enabled, set current for 'ac'
> > +	 */
> > +	if (twl4030_get_madc_conversion(11) > 4500) {
> > +		cur = bci->ac_cur;
> > +		bci->ac_is_active = true;
> > +	} else {
> > +		cur = bci->usb_cur;
> > +		bci->ac_is_active = false;
> > +	}
> > +
> >  	/* First, check thresholds and see if cgain is needed */
> >  	if (bci->ichg_eoc >= 200000)
> >  		cgain = true;
> 
> Neil, you need a stub or something for twl4030_get_madc_conversion
> if madc is not selected. Now at least omap2plus_defconfig and
> ARM allmodconfig fails in Linux next.
> 
> Regards,
> 
> Tony

Thanks, I did get notified about that by Fengguang's test robot, but
it's still on my list....

I guess making CHARGER_TWL4030 auto-select TWL4030_MADC would not be
acceptable?  That would pull in IIO (it didn't use to...).

If this OK?

Thanks,
NeilBrown


From: NeilBrown <neil@brown.name>
Date: Fri, 7 Aug 2015 13:44:37 +1000
Subject: [PATCH] twl4030_charger: fix compile error when TWL4030_MADC not
 available.

We can only use the madc to check for 'ac' availability
if the madc has been compiled in.
If not: assume always using USB.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: NeilBrown <neil@brown.name>

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index c7432f532a83..265fd236f4c0 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -91,6 +91,21 @@
 #define TWL4030_MSTATEC_COMPLETE1	0x0b
 #define TWL4030_MSTATEC_COMPLETE4	0x0e
 
+#if IS_ENABLED(CONFIG_TWL4030_MADC)
+/*
+ * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
+ * then AC is available.
+ */
+static inline int ac_available(void)
+{
+	return twl4030_get_madc_conversion(11) > 4500;
+}
+#else
+static inline int ac_available(void)
+{
+	return 0;
+}
+#endif
 static bool allow_usb;
 module_param(allow_usb, bool, 0644);
 MODULE_PARM_DESC(allow_usb, "Allow USB charge drawing default current");
@@ -263,7 +278,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 	 * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
 	 * and AC is enabled, set current for 'ac'
 	 */
-	if (twl4030_get_madc_conversion(11) > 4500) {
+	if (ac_available()) {
 		cur = bci->ac_cur;
 		bci->ac_is_active = true;
 	} else {
