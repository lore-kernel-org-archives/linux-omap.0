From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Thu, 16 Apr 2015 21:00:48 -0500
Message-ID: <20150417020048.GA27174@deathray>
References: <20150415140945.GA30787@deathray>
 <552EB152.7050306@ti.com>
 <20150415194707.GA11007@deathray>
 <CAPtuhTggHctp5ArGPEuKn2GuPzb-WnKv2_CzPrHzq8hwOR5Aqw@mail.gmail.com>
 <20150415205136.GA3399@deathray>
 <552F3B60.8050703@ti.com>
 <20150416161756.GA27590@deathray>
 <55301D7F.30708@gmail.com>
 <20150416220918.GA6057@deathray>
 <55304486.5020404@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55304486.5020404-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 01:23:50AM +0200, Sebastian Hesselbarth wrote:
> On 17.04.2015 00:09, Michael Welling wrote:
> >On Thu, Apr 16, 2015 at 10:37:19PM +0200, Sebastian Hesselbarth wrote:
> >>On 16.04.2015 18:17, Michael Welling wrote:
> >>>On Thu, Apr 16, 2015 at 07:32:32AM +0300, Tero Kristo wrote:
> >>>>On 04/15/2015 11:51 PM, Michael Welling wrote:
> >>>>>On Wed, Apr 15, 2015 at 01:45:53PM -0700, Mike Turquette wrote:
> >>>>>>On Wed, Apr 15, 2015 at 12:47 PM, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org> wrote:
> >>[...]
> >>>>>>>There is still an issue with the si5351.
> >>>>>>>
> >>>>>>>I had to comment out the clk_put here for the frequency to show up:
> >>>>>>>http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1133
> >>>>>>>
> >>>>>>>Ideas?
> >>>>>>
> >>>>>>What is the most recent upstream commit that you are based on?
> >>>>>
> >>>>>I am working from 4.0.0-rc7.
> >>>>>
> >>>>>7b43b47373d40d557cd7e1a84a0bd8ebc4d745ab
> >>>>
> >>>>Hmm, I wonder why si5351 calls clk_put immediately after of_clk_get
> >>>>in the first place, as far as I understand this destroys the clock
> >>>>handle, which is still being used later in the code.
> >>>
> >>>Not sure how this ever worked. This has been in the code since the
> >>>initial commit.
> >>
> >>The reason it worked before may be related with recent rework of
> >>clk_put() itself and clk cookies instead of pointers. I lost track on
> >>the recent clk subsystem changes here, sorry.
> >>
> >>However, droping the clk immediately surely isn't right.
> >>The thing is, we can remove the clk_put() just because there is no
> >>_remove() for that driver. I remember that back in the days the driver
> >>was mainlined, clk removal wasn't too easy.
> >>
> >>FWIW, as soon as _remove() support will be added by someone, we'll have
> >>to rethink passing struct clk* by platform_data or at least
> >>double-check if we ever used [of_]clk_get() to obtain it.
> >>
> >>Mind to send a patch removing the clk_put() on !IS_ERR and add a proper
> >>error path instead? While of_clk_get() is the only calls that need
> >>cleanup on error in si5351_dt_parse() we should probably move that
> >>calls to the end of this function. Otherwise we'd also have to cleanup
> >>on every of_parse_foo() failure.
> >
> >What would be the proper error path?
> >What cleanup is required?
> 
> A proper error path would be to release any claimed resource
> on any error. If you look at the code, the only resources that
> need to be released are the two clocks in question.

So for every error return in the probe function and in the of si5351_dt_parse
it needs to clk_put first right?

See attached patch to see if we are on the same page.

> 
> >It should be noted that there are more deep rooted issues with the driver
> >that I have noticed. For one the driver behaves differently if the debugging
> >is on and when it is off.
> 
> I guess you mean #define DEBUG in the driver?

Yes.

> 
> >Here is what the kernel reports with debugging off:
> 
> Do you have any measurement equipment to check what is actually set?

Yes, I have an oscilloscope here at my desk.
The reported numbers do not always correspond to the actual output in some
cases.

The ms2 output has appeared to stop working all together sometime whilest
testing. I may have to solder a new chip on there.

Could misconfiguration damage the chip?

> 
> >root@som3517-som200:~# cat /sys/kernel/debug/clk/clk_summary
> >    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> >----------------------------------------------------------------------------------------
> >  ref27                                    0            0    27000000          0 0
> >     xtal                                  0            0    27000000          0 0
> >        pllb                               0            0   599999994          0 0
> >           ms0                             0            0    12499999          0 0
> >              clk0                         0            0    12499999          0 0
> >        plla                               0            0   599999994          0 0
> >           ms2                             0            0     8219178          0 0
> >              clk2                         0            0     8219178          0 0
> >           ms1                             0            0    94117646          0 0
> >              clk1                         0            0    94117646          0 0
> >
> >Here is what the kernel reports with debugging on:
> >    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> >----------------------------------------------------------------------------------------
> >  ref27                                    0            0    27000000          0 0
> >     xtal                                  0            0    27000000          0 0
> >        pllb                               0            0   884736000          0 0
> >           ms0                             0            0    18432000          0 0
> >              clk0                         0            0    18432000          0 0
> 
> Is this what you expect for clk0?

Yes.

> 
> >        plla                               0            0   897023997          0 0
> >           ms2                             0            0    12287999          0 0
> >              clk2                         0            0    12287999          0 0
> 
> ditto for clk2?

Yes.

> 
> >           ms1                             0            0   140709646          0 0
> >              clk1                         0            0   140709646          0 0
> 
> This is wrong, I agree. Looks like round_rate()/recalc_rate() of msynth
> or clkout is broken with respect to non-pll-master clocks.
> 
> I had a quick look at drivers/clk.c too, there has been a lot of churn
> in clk API since I last booted my device using si5351.
> 
> Is there any way to try out a less recent kernel, let's say two or
> three releases before 4.0?

Could you provide a specific version that you think has the best chances of
working?

> 
> We should just confirm that there has been an issue with it before
> already.
> 
> I have no clue about the debug on/off issue at the moment.
> 
> >Note this is with the following devicetree entry:
> >         si5351: clock-generator {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >                 #clock-cells = <1>;
> >                 compatible = "silabs,si5351a-msop";
> >                 reg = <0x60>;
> >                 status = "okay";
> >
> >                 /* connect xtal input to 27MHz reference */
> >                 clocks = <&ref27>;
> >
> >                 /* connect xtal input as source of pll0 and pll1 */
> >                 silabs,pll-source = <0 0>, <1 0>;
> >
> >                 clkout0: clkout0 {
> >                         reg = <0>;
> >                         silabs,drive-strength = <8>;
> >                         silabs,multisynth-source = <1>;
> >                         silabs,clock-source = <0>;
> >                         silabs,pll-master;
> >                         clock-frequency = <18432000>;
> >                  };
> >
> >                 clkout1: clkout1 {
> >                         reg = <1>;
> >                         silabs,drive-strength = <8>;
> >                         silabs,multisynth-source = <0>;
> >                         silabs,clock-source = <0>;
> >                         clock-frequency = <8000000>;
> >                 };
> >
> >                 clkout2: clkout2 {
> >                         reg = <2>;
> >                         silabs,drive-strength = <8>;
> >                         silabs,multisynth-source = <0>;
> >                         silabs,clock-source = <0>;
> >                         silabs,pll-master;
> >                         clock-frequency = <12288000>;
> >                 };
> >         };
> >
> >I am losing hope that this driver is stable enough to even use in production.
> 
> Who said it is stable for production use? The driver is written from
> scratch based on _very_ limited information of the datasheet an appnote.
> Also, I only have a single setup with si5351, that is no way enough to
> test every combination.

Well it is not in staging and I am sure it took much work to get it working
for you.

> 
> I never heard serious complaints before, so either you help improving
> this driver or better ask SiLabs for a table-based driver for your
> specific setup.

I have routines to program the chip from U-Boot and Linux userspace using
the table method. I was hoping that a mainline driver could replace these
hackish utilities.

> 
> Sebastian

--NzB8fVQJ5HfG6fxh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="clk-si5351.patch"

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 3b2a66f..e0da91d 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1120,6 +1120,7 @@ static int si5351_dt_parse(struct i2c_client *client,
 	const __be32 *p;
 	int num = 0;
 	u32 val;
+	int ret;
 
 	if (np == NULL)
 		return 0;
@@ -1129,11 +1130,21 @@ static int si5351_dt_parse(struct i2c_client *client,
 		return -ENOMEM;
 
 	pdata->clk_xtal = of_clk_get(np, 0);
-	if (!IS_ERR(pdata->clk_xtal))
-		clk_put(pdata->clk_xtal);
-	pdata->clk_clkin = of_clk_get(np, 1);
-	if (!IS_ERR(pdata->clk_clkin))
-		clk_put(pdata->clk_clkin);
+	if (IS_ERR(pdata->clk_xtal)) {
+		dev_err(&client->dev,
+			"xtal clock not speficied\n");
+		return -ENODEV;
+	}
+
+	if (variant == SI5351_VARIANT_C) {
+		pdata->clk_clkin = of_clk_get(np, 1);
+		if (IS_ERR(pdata->clk_clkin)) {
+			dev_err(&client->dev,
+				"clkin clock not speficied\n");
+			ret = -ENODEV;
+			goto err_put_clk_of;
+		}
+	}
 
 	/*
 	 * property silabs,pll-source : <num src>, [<..>]
@@ -1143,14 +1154,16 @@ static int si5351_dt_parse(struct i2c_client *client,
 		if (num >= 2) {
 			dev_err(&client->dev,
 				"invalid pll %d on pll-source prop\n", num);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk_of;
 		}
 
 		p = of_prop_next_u32(prop, p, &val);
 		if (!p) {
 			dev_err(&client->dev,
 				"missing pll-source for pll %d\n", num);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk_of;
 		}
 
 		switch (val) {
@@ -1162,14 +1175,16 @@ static int si5351_dt_parse(struct i2c_client *client,
 				dev_err(&client->dev,
 					"invalid parent %d for pll %d\n",
 					val, num);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_clk_of;
 			}
 			pdata->pll_src[num] = SI5351_PLL_SRC_CLKIN;
 			break;
 		default:
 			dev_err(&client->dev,
 				 "invalid parent %d for pll %d\n", val, num);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk_of;
 		}
 	}
 
@@ -1178,13 +1193,15 @@ static int si5351_dt_parse(struct i2c_client *client,
 		if (of_property_read_u32(child, "reg", &num)) {
 			dev_err(&client->dev, "missing reg property of %s\n",
 				child->name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk_of;
 		}
 
 		if (num >= 8 ||
 		    (variant == SI5351_VARIANT_A3 && num >= 3)) {
 			dev_err(&client->dev, "invalid clkout %d\n", num);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk_of;
 		}
 
 		if (!of_property_read_u32(child, "silabs,multisynth-source",
@@ -1202,7 +1219,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 				dev_err(&client->dev,
 					"invalid parent %d for multisynth %d\n",
 					val, num);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_clk_of;
 			}
 		}
 
@@ -1225,7 +1243,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 					dev_err(&client->dev,
 						"invalid parent %d for clkout %d\n",
 						val, num);
-					return -EINVAL;
+					ret = -EINVAL;
+					goto err_put_clk_of;
 				}
 				pdata->clkout[num].clkout_src =
 					SI5351_CLKOUT_SRC_CLKIN;
@@ -1234,7 +1253,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 				dev_err(&client->dev,
 					"invalid parent %d for clkout %d\n",
 					val, num);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_clk_of;
 			}
 		}
 
@@ -1251,7 +1271,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 				dev_err(&client->dev,
 					"invalid drive strength %d for clkout %d\n",
 					val, num);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_clk_of;
 			}
 		}
 
@@ -1278,7 +1299,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 				dev_err(&client->dev,
 					"invalid disable state %d for clkout %d\n",
 					val, num);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_clk_of;
 			}
 		}
 
@@ -1291,9 +1313,18 @@ static int si5351_dt_parse(struct i2c_client *client,
 	client->dev.platform_data = pdata;
 
 	return 0;
+
+err_put_clk_of:
+	if (!IS_ERR(pdata->clk_xtal))
+		clk_put(pdata->clk_xtal);
+	if (IS_ERR(pdata->clk_clkin))
+		clk_put(pdata->clk_clkin);
+
+	return ret;
 }
 #else
-static int si5351_dt_parse(struct i2c_client *client, enum si5351_variant variant)
+static int si5351_dt_parse(struct i2c_client *client,
+		enum si5351_variant variant)
 {
 	return 0;
 }
@@ -1322,7 +1353,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	drvdata = devm_kzalloc(&client->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (drvdata == NULL) {
 		dev_err(&client->dev, "unable to allocate driver data\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_put_clk;
 	}
 
 	i2c_set_clientdata(client, drvdata);
@@ -1334,7 +1366,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	drvdata->regmap = devm_regmap_init_i2c(client, &si5351_regmap_config);
 	if (IS_ERR(drvdata->regmap)) {
 		dev_err(&client->dev, "failed to allocate register map\n");
-		return PTR_ERR(drvdata->regmap);
+		ret = PTR_ERR(drvdata->regmap);
+		goto err_put_clk;
 	}
 
 	/* Disable interrupts */
@@ -1351,7 +1384,7 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"failed to reparent pll %d to %d\n",
 				n, pdata->pll_src[n]);
-			return ret;
+			goto err_put_clk;
 		}
 	}
 
@@ -1362,7 +1395,7 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"failed to reparent multisynth %d to %d\n",
 				n, pdata->clkout[n].multisynth_src);
-			return ret;
+			goto err_put_clk;
 		}
 
 		ret = _si5351_clkout_reparent(drvdata, n,
@@ -1371,7 +1404,7 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"failed to reparent clkout %d to %d\n",
 				n, pdata->clkout[n].clkout_src);
-			return ret;
+			goto err_put_clk;
 		}
 
 		ret = _si5351_clkout_set_drive_strength(drvdata, n,
@@ -1380,7 +1413,7 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"failed set drive strength of clkout%d to %d\n",
 				n, pdata->clkout[n].drive);
-			return ret;
+			goto err_put_clk;
 		}
 
 		ret = _si5351_clkout_set_disable_state(drvdata, n,
@@ -1389,7 +1422,7 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"failed set disable state of clkout%d to %d\n",
 				n, pdata->clkout[n].disable_state);
-			return ret;
+			goto err_put_clk;
 		}
 	}
 
@@ -1398,16 +1431,16 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	init.name = si5351_input_names[0];
 	init.ops = &si5351_xtal_ops;
 	init.flags = 0;
-	if (!IS_ERR(drvdata->pxtal)) {
-		drvdata->pxtal_name = __clk_get_name(drvdata->pxtal);
-		init.parent_names = &drvdata->pxtal_name;
-		init.num_parents = 1;
-	}
+	drvdata->pxtal_name = __clk_get_name(drvdata->pxtal);
+	init.parent_names = &drvdata->pxtal_name;
+	init.num_parents = 1;
+
 	drvdata->xtal.init = &init;
 	clk = devm_clk_register(&client->dev, &drvdata->xtal);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		return PTR_ERR(clk);
+		ret = PTR_ERR(clk);
+		goto err_put_clk;
 	}
 
 	/* register clkin input clock gate */
@@ -1415,17 +1448,17 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		memset(&init, 0, sizeof(init));
 		init.name = si5351_input_names[1];
 		init.ops = &si5351_clkin_ops;
-		if (!IS_ERR(drvdata->pclkin)) {
-			drvdata->pclkin_name = __clk_get_name(drvdata->pclkin);
-			init.parent_names = &drvdata->pclkin_name;
-			init.num_parents = 1;
-		}
+		drvdata->pclkin_name = __clk_get_name(drvdata->pclkin);
+		init.parent_names = &drvdata->pclkin_name;
+		init.num_parents = 1;
+
 		drvdata->clkin.init = &init;
 		clk = devm_clk_register(&client->dev, &drvdata->clkin);
 		if (IS_ERR(clk)) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			return PTR_ERR(clk);
+			ret = PTR_ERR(clk);
+			goto err_put_clk;
 		}
 	}
 
@@ -1447,7 +1480,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	clk = devm_clk_register(&client->dev, &drvdata->pll[0].hw);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_clk;
 	}
 
 	/* register PLLB or VXCO (Si5351B) */
@@ -1471,7 +1505,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	clk = devm_clk_register(&client->dev, &drvdata->pll[1].hw);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_clk;
 	}
 
 	/* register clk multisync and clk out divider */
@@ -1492,8 +1527,10 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		num_clocks * sizeof(*drvdata->onecell.clks), GFP_KERNEL);
 
 	if (WARN_ON(!drvdata->msynth || !drvdata->clkout ||
-		    !drvdata->onecell.clks))
-		return -ENOMEM;
+		    !drvdata->onecell.clks)) {
+		ret = -ENOMEM;
+		goto err_put_clk;
+	}
 
 	for (n = 0; n < num_clocks; n++) {
 		drvdata->msynth[n].num = n;
@@ -1511,7 +1548,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		if (IS_ERR(clk)) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk;
 		}
 	}
 
@@ -1538,7 +1576,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		if (IS_ERR(clk)) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk;
 		}
 		drvdata->onecell.clks[n] = clk;
 
@@ -1557,9 +1596,31 @@ static int si5351_i2c_probe(struct i2c_client *client,
 				  &drvdata->onecell);
 	if (ret) {
 		dev_err(&client->dev, "unable to add clk provider\n");
-		return ret;
+		goto err_put_clk;
+	}
+
+	return 0;
+
+err_put_clk:
+	if (pdata) {
+		if (!IS_ERR(pdata->clk_xtal))
+			clk_put(pdata->clk_xtal);
+		if (!IS_ERR(pdata->clk_clkin))
+			clk_put(pdata->clk_clkin);
 	}
 
+	return ret;
+}
+
+int si5351_i2c_remove(struct i2c_client *client)
+{
+	struct si5351_driver_data *drvdata = i2c_get_clientdata(client);
+
+	of_clk_del_provider(client->dev.of_node);
+	clk_put(drvdata->pxtal);
+	if (drvdata->variant == SI5351_VARIANT_C)
+		clk_put(drvdata->pclkin);
+
 	return 0;
 }
 
@@ -1578,6 +1639,7 @@ static struct i2c_driver si5351_driver = {
 		.of_match_table = of_match_ptr(si5351_dt_ids),
 	},
 	.probe = si5351_i2c_probe,
+	.remove = si5351_i2c_remove,
 	.id_table = si5351_i2c_ids,
 };
 module_i2c_driver(si5351_driver);

--NzB8fVQJ5HfG6fxh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
