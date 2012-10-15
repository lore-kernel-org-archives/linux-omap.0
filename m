From: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Subject: RE: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Mon, 15 Oct 2012 12:16:42 +0300
Message-ID: <1350292602.17145.63.camel@kj-X230>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	 <87ipag90om.fsf@deeprootsystems.com>
	 <902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
	 ,<87d30n7o9q.fsf@deeprootsystems.com>
	 <902E09E6452B0E43903E4F2D568737AB2C8C9F@DNCE04.ent.ti.com>
	 <1350282068.17145.42.camel@kj-X230>
Reply-To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eXXQ7ZcXQ42Yf2gsIGGC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350282068.17145.42.camel@kj-X230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Cc: "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "Kankroliwala, Huzefa" <huzefank-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--=-eXXQ7ZcXQ42Yf2gsIGGC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

ma, 2012-10-15 kello 09:21 +0300, Kalle Jokiniemi kirjoitti:
> Hi,
> 
> pe, 2012-10-12 kello 14:46 +0000, Strashko, Grygorii kirjoitti:
> > Hi Kevin,
> > 
> > yep, [1] is the same fix - thanks. 
> > 
> > Hi Kalle,
> > 
> > i've applied these changes and PM runtime fix on top of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git (omap2plus_defconfig)
> > Could you check it with your use case, pls? (just to be sure that idea is right)
> 
> Odd, it's not working. I'll add some debug prints to see what happens
> there.

Well, seems after enabling irq 23 in the resume_noirq, someone does
i2c_xfer and there is consequent flood of i2c_xfers and interrupts.

Not sure now how these IRQ numbers get mapped these days, my debug print
says it's irq number 72 (UART1 from TRM) that is flooding (although it's
printed from the i2c-omap isr function, so it's still I2C bus irq...).

The irq enabling (in resume_noirq) is still slightly progressing after
the flooding starts, but my watchdog kicks in before we get to the
finish.

Attached my debug prints patch and log. I used also "no_console_suspend"
boot option.

- Kalle

> 
> - Kalle
> 
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index a0e49f6..cb09e20 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -586,6 +586,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >         if (IS_ERR_VALUE(r))
> >                 goto out;
> >  
> > +       /* We have the bus, enable IRQ */
> > +       enable_irq(dev->irq);
> > +
> >         r = omap_i2c_wait_for_bb(dev);
> >         if (r < 0)
> >                 goto out;
> > @@ -606,6 +609,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >                 r = num;
> >  
> >         omap_i2c_wait_for_bb(dev);
> > +       disable_irq(dev->irq);
> >  out:
> >         pm_runtime_put(dev->dev);
> >         return r;
> > @@ -1060,6 +1064,9 @@ omap_i2c_probe(struct platform_device *pdev)
> >                                                                    omap_i2c_isr;
> >         r = request_irq(dev->irq, isr, IRQF_NO_SUSPEND, pdev->name, dev);
> >  
> > +       /* We enable IRQ only when request for I2C from master */
> > +        disable_irq(dev->irq);
> > +
> >         if (r) {
> >                 dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
> >                 goto err_unuse_clocks;
> > @@ -1182,7 +1189,23 @@ static int omap_i2c_runtime_resume(struct device *dev)
> >  }
> >  #endif /* CONFIG_PM_RUNTIME */
> >  
> > +static int omap_i2c_suspend(struct device *dev)
> > +{
> > +       int ret;
> > +
> > +       /*
> > +        *  Enable I2C device, so it will be accessible during
> > +        * later stages of suspending when device Runtime PM is disabled.
> > +        * I2C device will be turned off at "noirq" suspend stage.
> > +        */
> > +       ret = pm_runtime_resume(dev);
> > +       if (ret < 0)
> > +               return ret;
> > +       return 0;
> > +}
> > +
> >  static struct dev_pm_ops omap_i2c_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(omap_i2c_suspend, NULL)
> >         SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
> >                            omap_i2c_runtime_resume, NULL)
> >  };
> > 
> > - Grygorii
> > ________________________________________
> > From: Kevin Hilman [khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org]
> > Sent: Friday, October 12, 2012 5:34 PM
> > To: Strashko, Grygorii
> > Cc: Kalle Jokiniemi; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Datta, Shubhrajyoti; Kankroliwala, Huzefa
> > Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
> > 
> > "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> > 
> > > Hi All,
> > >
> > > Sorry, for the late reply.
> > > + CC Huzefa Kankroliwala - who is I2C driver owner on Android Kernel 3.4.
> > 
> > Hi Grygorii, thanks for reviewing.  I was hoping you would have some
> > ideas here as this was sounding familiar to something you had
> > mentioned elsewhere.
> > 
> > > Regarding this patch -  from my point of view, it fixes corner case and not an issue in general.
> > > Let take a look on resume sequence:
> > >    - platform resume
> > >    - syscore resume
> > >    - resume_noirq
> > >    - enable IRQs - resume_device_irqs()
> > >      |- at this point IRQ handler will be invoked if IRQ state is IRQS_PENDING.
> > >      |- so, the I2C device IRQ handler may be called at time when I2C adapter IRQ is still disabled and, as result, the I2C device IRQ-handler may fail. (I2C device and I2C adapter may use different physical IRQ lines)
> > >    - resume_late
> > >      |- enable I2C bus IRQ
> > >
> > > Possibly, the better way is to enable/disable I2C bus IRQ when needed - in our case in omap_i2c_xfer().
> > > We use such approach in Android kernel 3.4
> > > (http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=1445a4d3b587c164bd30d108b61760aaaa07365e)
> > 
> > I agree, that should work and cover the cases where I2C is used by other
> > processors also.  Shubhrajyoti already posted something similar[1] but
> > it needed some rework (comments from Russell and myself.)
> > 
> > Huzefa, Shubhrajyoti, who can rework this idea for the upstream and/or
> > follow up with the earlier patch[1]?
> > 
> > Wolfram, I guess for now lets hold off on $SUBJECT patch.  Seems we can
> > come up with a broader solution.  Thanks.
> > 
> > Kevin
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/124427.html
> 


--=-eXXQ7ZcXQ42Yf2gsIGGC
Content-Disposition: attachment; filename="suspend_log.txt"
Content-Type: text/plain; name="suspend_log.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[root@localhost power]# dmesg -n7 
[root@localhost power]# echo mem > state 
[   58.817657] PM: Syncing filesystems ... done.
[   59.741119] Freezing user space processes ... (elapsed 0.03 seconds) done.
[   59.780731] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   59.824432] omap_i2c_xfer: Enabled irq 72
[   59.828704] omap_i2c_isr: irq 72, runtime_suspended = 0
[   59.834320] omap_i2c_isr: irq 72, runtime_suspended = 0
[   59.839965] omap_i2c_xfer: Disabled irq 72
[   59.854125] PM: suspend of devices complete after 37.658 msecs
[   59.864990] PM: late suspend of devices complete after 4.577 msecs
[   59.879272] PM: noirq suspend of devices complete after 7.659 msecs
[   62.176025] Powerdomain (per_pwrdm) didn't enter target state 1
[   62.182250] Powerdomain (core_pwrdm) didn't enter target state 1
[   62.188537] Could not enter target state in pm_suspend
[   62.194183] resume_irqs: resuming irq 0
[   62.198211] resume_irqs: resuming irq 1
[   62.202239] resume_irqs: resuming irq 2
[   62.206268] resume_irqs: resuming irq 3
[   62.210296] resume_irqs: resuming irq 4
[   62.214294] resume_irqs: resuming irq 5
[   62.218322] resume_irqs: resuming irq 6
[   62.222351] resume_irqs: resuming irq 7
[   62.226379] resume_irqs: resuming irq 8
[   62.230407] resume_irqs: resuming irq 9
[   62.234405] resume_irqs: resuming irq 10
[   62.238525] resume_irqs: resuming irq 11
[   62.242645] resume_irqs: resuming irq 12
[   62.246765] resume_irqs: resuming irq 13
[   62.250854] resume_irqs: resuming irq 14
[   62.254974] resume_irqs: resuming irq 15
[   62.259094] resume_irqs: resuming irq 16
[   62.263214] resume_irqs: resuming irq 17
[   62.267333] resume_irqs: resuming irq 18
[   62.271423] resume_irqs: resuming irq 19
[   62.275543] resume_irqs: resuming irq 20
[   62.279663] resume_irqs: resuming irq 21
[   62.283782] resume_irqs: resuming irq 22
[   62.287872] resume_irqs: resuming irq 23
[   62.291992] resume_irqs: resuming irq 24
[   62.296112] resume_irqs: resuming irq 25
[   62.300231] resume_irqs: resuming irq 26
[   62.304351] resume_irqs: resuming irq 27
[   62.308441] resume_irqs: resuming irq 28
[   62.312561] resume_irqs: resuming irq 29
[   62.316680] resume_irqs: resuming irq 30
[   62.320800] resume_irqs: resuming irq 31
[   62.324890] resume_irqs: resuming irq 32
[   62.329010] resume_irqs: resuming irq 33
[   62.333129] resume_irqs: resuming irq 34
[   62.337249] resume_irqs: resuming irq 35
[   62.341369] resume_irqs: resuming irq 36
[   62.345458] resume_irqs: resuming irq 37
[   62.349578] resume_irqs: resuming irq 38
[   62.353698] resume_irqs: resuming irq 39
[   62.357818] resume_irqs: resuming irq 40
[   62.361907] resume_irqs: resuming irq 41
[   62.366027] resume_irqs: resuming irq 42
[   62.370147] resume_irqs: resuming irq 43
[   62.374267] resume_irqs: resuming irq 44
[   62.378387] resume_irqs: resuming irq 45
[   62.382476] resume_irqs: resuming irq 46
[   62.386596] resume_irqs: resuming irq 47
[   62.390716] resume_irqs: resuming irq 48
[   62.394836] resume_irqs: resuming irq 49
[   62.398925] resume_irqs: resuming irq 50
[   62.403045] resume_irqs: resuming irq 51
[   62.407165] resume_irqs: resuming irq 52
[   62.411285] resume_irqs: resuming irq 53
[   62.415405] resume_irqs: resuming irq 54
[   62.419494] resume_irqs: resuming irq 55
[   62.423614] resume_irqs: resuming irq 56
[   62.427734] resume_irqs: resuming irq 57
[   62.431854] resume_irqs: resuming irq 58
[   62.435943] resume_irqs: resuming irq 59
[   62.440063] resume_irqs: resuming irq 60
[   62.444183] resume_irqs: resuming irq 61
[   62.448303] resume_irqs: resuming irq 62
[   62.452423] resume_irqs: resuming irq 63
[   62.456512] resume_irqs: resuming irq 64
[   62.460632] resume_irqs: resuming irq 65
[   62.464752] resume_irqs: resuming irq 66
[   62.468872] resume_irqs: resuming irq 67
[   62.472961] resume_irqs: resuming irq 68
[   62.477081] resume_irqs: resuming irq 69
[   62.481201] resume_irqs: resuming irq 70
[   62.485321] resume_irqs: resuming irq 71
[   62.489410] resume_irqs: resuming irq 72
[   62.493530] resume_irqs: resuming irq 73
[   62.497650] resume_irqs: resuming irq 74
[   62.501770] resume_irqs: resuming irq 75
[   62.505889] resume_irqs: resuming irq 76
[   62.509979] resume_irqs: resuming irq 77
[   62.514099] resume_irqs: resuming irq 78
[   62.518218] resume_irqs: resuming irq 79
[   62.522338] resume_irqs: resuming irq 80
[   62.526458] resume_irqs: resuming irq 81
[   62.530548] resume_irqs: resuming irq 82
[   62.534667] resume_irqs: resuming irq 83
[   62.538787] resume_irqs: resuming irq 84
[   62.542907] resume_irqs: resuming irq 85
[   62.547027] resume_irqs: resuming irq 86
[   62.551116] resume_irqs: resuming irq 87
[   62.555236] resume_irqs: resuming irq 88
[   62.559356] resume_irqs: resuming irq 89
[   62.563476] resume_irqs: resuming irq 90
[   62.567565] resume_irqs: resuming irq 91
[   62.571685] resume_irqs: resuming irq 92
[   62.575805] resume_irqs: resuming irq 93
[   62.579925] resume_irqs: resuming irq 94
[   62.584014] resume_irqs: resuming irq 95
[   62.588134] resume_irqs: resuming irq 96
[   62.592254] resume_irqs: resuming irq 97
[   62.596374] resume_irqs: resuming irq 98
[   62.600494] resume_irqs: resuming irq 99
[   62.604583] resume_irqs: resuming irq 100
[   62.608795] resume_irqs: resuming irq 101
[   62.613006] resume_irqs: resuming irq 102
[   62.617218] resume_irqs: resuming irq 103
[   62.621398] resume_irqs: resuming irq 104
[   62.625610] resume_irqs: resuming irq 105
[   62.629821] resume_irqs: resuming irq 106
[   62.634033] resume_irqs: resuming irq 107
[   62.638214] resume_irqs: resuming irq 108
[   62.642425] resume_irqs: resuming irq 109
[   62.646636] resume_irqs: resuming irq 110
[   62.650848] resume_irqs: resuming irq 111
[   62.655029] resume_irqs: resuming irq 112
[   62.659240] resume_irqs: resuming irq 113
[   62.663452] resume_irqs: resuming irq 114
[   62.667663] resume_irqs: resuming irq 115
[   62.671874] resume_irqs: resuming irq 116
[   62.676055] resume_irqs: resuming irq 117
[   62.680267] resume_irqs: resuming irq 118
[   62.684478] resume_irqs: resuming irq 119
[   62.688690] resume_irqs: resuming irq 120
[   62.692871] resume_irqs: resuming irq 121
[   62.697082] resume_irqs: resuming irq 122
[   62.701293] resume_irqs: resuming irq 123
[   62.705505] resume_irqs: resuming irq 124
[   62.709686] resume_irqs: resuming irq 125
[   62.713897] resume_irqs: resuming irq 126
[   62.718109] resume_irqs: resuming irq 127
[   62.722290] resume_irqs: resuming irq 128
[   62.726501] resume_irqs: resuming irq 129
[   62.730712] resume_irqs: resuming irq 130
[   62.734924] resume_irqs: resuming irq 131
[   62.739135] resume_irqs: resuming irq 132
[   62.743316] resume_irqs: resuming irq 133
[   62.747528] resume_irqs: resuming irq 134
[   62.751739] resume_irqs: resuming irq 135
[   62.755950] resume_irqs: resuming irq 136
[   62.760131] resume_irqs: resuming irq 137
[   62.764343] resume_irqs: resuming irq 138
[   62.768554] resume_irqs: resuming irq 139
[   62.772766] resume_irqs: resuming irq 140
[   62.776947] resume_irqs: resuming irq 141
[   62.781158] resume_irqs: resuming irq 142
[   62.785369] resume_irqs: resuming irq 143
[   62.789581] resume_irqs: resuming irq 144
[   62.793762] resume_irqs: resuming irq 145
[   62.797973] resume_irqs: resuming irq 146
[   62.802185] resume_irqs: resuming irq 147
[   62.806396] resume_irqs: resuming irq 148
[   62.810577] resume_irqs: resuming irq 149
[   62.814788] resume_irqs: resuming irq 150
[   62.819000] resume_irqs: resuming irq 151
[   62.823211] resume_irqs: resuming irq 152
[   62.827392] resume_irqs: resuming irq 153
[   62.831604] resume_irqs: resuming irq 154
[   62.835815] resume_irqs: resuming irq 155
[   62.840026] resume_irqs: resuming irq 156
[   62.844207] resume_irqs: resuming irq 157
[   62.848419] resume_irqs: resuming irq 158
[   62.852630] resume_irqs: resuming irq 159
[   62.856842] resume_irqs: resuming irq 160
[   62.861022] resume_irqs: resuming irq 161
[   62.865234] resume_irqs: resuming irq 162
[   62.869445] resume_irqs: resuming irq 163
[   62.873657] resume_irqs: resuming irq 164
[   62.877838] resume_irqs: resuming irq 165
[   62.882049] resume_irqs: resuming irq 166
[   62.886260] resume_irqs: resuming irq 167
[   62.890472] resume_irqs: resuming irq 168
[   62.894683] resume_irqs: resuming irq 169
[   62.898864] resume_irqs: resuming irq 170
[   62.903076] resume_irqs: resuming irq 171
[   62.907287] resume_irqs: resuming irq 172
[   62.911499] resume_irqs: resuming irq 173
[   62.915679] resume_irqs: resuming irq 174
[   62.919891] resume_irqs: resuming irq 175
[   62.924102] resume_irqs: resuming irq 176
[   62.928314] resume_irqs: resuming irq 177
[   62.932495] resume_irqs: resuming irq 178
[   62.936706] resume_irqs: resuming irq 179
[   62.940917] resume_irqs: resuming irq 180
[   62.945129] resume_irqs: resuming irq 181
[   62.949310] resume_irqs: resuming irq 182
[   62.953521] resume_irqs: resuming irq 183
[   62.957733] resume_irqs: resuming irq 184
[   62.961944] resume_irqs: resuming irq 185
[   62.966125] resume_irqs: resuming irq 186
[   62.970336] resume_irqs: resuming irq 187
[   62.974548] resume_irqs: resuming irq 188
[   62.978759] resume_irqs: resuming irq 189
[   62.982940] resume_irqs: resuming irq 190
[   62.987152] resume_irqs: resuming irq 191
[   62.991363] resume_irqs: resuming irq 192
[   62.995574] resume_irqs: resuming irq 193
[   62.999755] resume_irqs: resuming irq 194
[   63.003967] resume_irqs: resuming irq 195
[   63.008178] resume_irqs: resuming irq 196
[   63.012390] resume_irqs: resuming irq 197
[   63.016601] resume_irqs: resuming irq 198
[   63.020782] resume_irqs: resuming irq 199
[   63.024993] resume_irqs: resuming irq 200
[   63.029205] resume_irqs: resuming irq 201
[   63.033416] resume_irqs: resuming irq 202
[   63.037597] resume_irqs: resuming irq 203
[   63.041809] resume_irqs: resuming irq 204
[   63.046020] resume_irqs: resuming irq 205
[   63.050231] resume_irqs: resuming irq 206
[   63.054412] resume_irqs: resuming irq 207
[   63.058624] resume_irqs: resuming irq 208
[   63.062835] resume_irqs: resuming irq 209
[   63.067047] resume_irqs: resuming irq 210
[   63.071228] resume_irqs: resuming irq 211
[   63.075439] resume_irqs: resuming irq 212
[   63.079650] resume_irqs: resuming irq 213
[   63.083862] resume_irqs: resuming irq 214
[   63.088043] resume_irqs: resuming irq 215
[   63.092254] resume_irqs: resuming irq 216
[   63.096466] resume_irqs: resuming irq 217
[   63.100677] resume_irqs: resuming irq 218
[   63.104858] resume_irqs: resuming irq 219
[   63.109069] resume_irqs: resuming irq 220
[   63.113281] resume_irqs: resuming irq 221
[   63.117492] resume_irqs: resuming irq 222
[   63.121673] resume_irqs: resuming irq 223
[   63.125885] resume_irqs: resuming irq 224
[   63.130096] resume_irqs: resuming irq 225
[   63.134307] resume_irqs: resuming irq 226
[   63.138488] resume_irqs: resuming irq 227
[   63.142700] resume_irqs: resuming irq 228
[   63.146911] resume_irqs: resuming irq 229
[   63.151123] resume_irqs: resuming irq 230
[   63.155303] resume_irqs: resuming irq 231
[   63.159515] resume_irqs: resuming irq 232
[   63.163726] resume_irqs: resuming irq 233
[   63.167938] resume_irqs: resuming irq 234
[   63.172149] resume_irqs: resuming irq 235
[   63.176330] resume_irqs: resuming irq 236
[   63.180541] resume_irqs: resuming irq 237
[   63.184753] resume_irqs: resuming irq 238
[   63.188964] resume_irqs: resuming irq 239
[   63.193145] resume_irqs: resuming irq 240
[   63.197357] resume_irqs: resuming irq 241
[   63.201568] resume_irqs: resuming irq 242
[   63.205780] resume_irqs: resuming irq 243
[   63.209960] resume_irqs: resuming irq 244
[   63.214172] resume_irqs: resuming irq 245
[   63.218383] resume_irqs: resuming irq 246
[   63.222595] resume_irqs: resuming irq 247
[   63.226776] resume_irqs: resuming irq 248
[   63.230987] resume_irqs: resuming irq 249
[   63.235198] resume_irqs: resuming irq 250
[   63.239410] resume_irqs: resuming irq 251
[   63.243591] resume_irqs: resuming irq 252
[   63.247802] resume_irqs: resuming irq 253
[   63.252014] resume_irqs: resuming irq 254
[   63.256225] resume_irqs: resuming irq 255
[   63.260437] resume_irqs: resuming irq 256
[   63.264617] resume_irqs: resuming irq 257
[   63.268829] resume_irqs: resuming irq 258
[   63.273040] resume_irqs: resuming irq 259
[   63.277252] resume_irqs: resuming irq 260
[   63.281433] resume_irqs: resuming irq 261
[   63.285644] resume_irqs: resuming irq 262
[   63.289855] resume_irqs: resuming irq 263
[   63.294067] resume_irqs: resuming irq 264
[   63.298248] resume_irqs: resuming irq 265
[   63.302459] resume_irqs: resuming irq 266
[   63.306671] resume_irqs: resuming irq 267
[   63.310882] resume_irqs: resuming irq 268
[   63.315063] resume_irqs: resuming irq 269
[   63.319274] resume_irqs: resuming irq 270
[   63.323486] resume_irqs: resuming irq 271
[   63.327697] resume_irqs: resuming irq 272
[   63.331878] resume_irqs: resuming irq 273
[   63.336090] resume_irqs: resuming irq 274
[   63.340301] resume_irqs: resuming irq 275
[   63.344512] resume_irqs: resuming irq 276
[   63.348693] resume_irqs: resuming irq 277
[   63.352905] resume_irqs: resuming irq 278
[   63.357116] resume_irqs: resuming irq 279
[   63.361328] resume_irqs: resuming irq 280
[   63.365509] resume_irqs: resuming irq 281
[   63.369720] resume_irqs: resuming irq 282
[   63.373931] resume_irqs: resuming irq 283
[   63.378143] resume_irqs: resuming irq 284
[   63.382324] resume_irqs: resuming irq 285
[   63.386535] resume_irqs: resuming irq 286
[   63.390747] resume_irqs: resuming irq 287
[   63.394958] resume_irqs: resuming irq 288
[   63.399169] resume_irqs: resuming irq 289
[   63.403350] resume_irqs: resuming irq 290
[   63.407562] resume_irqs: resuming irq 291
[   63.411773] resume_irqs: resuming irq 292
[   63.415954] resume_irqs: resuming irq 293
[   63.420166] resume_irqs: resuming irq 294
[   63.424377] resume_irqs: resuming irq 295
[   63.428588] resume_irqs: resuming irq 296
[   63.432800] resume_irqs: resuming irq 297
[   63.436981] resume_irqs: resuming irq 298
[   63.441192] resume_irqs: resuming irq 299
[   63.445404] resume_irqs: resuming irq 300
[   63.449615] resume_irqs: resuming irq 301
[   63.453796] resume_irqs: resuming irq 302
[   63.458007] resume_irqs: resuming irq 303
[   63.462219] resume_irqs: resuming irq 304
[   63.466430] resume_irqs: resuming irq 305
[   63.470611] resume_irqs: resuming irq 306
[   63.474822] resume_irqs: resuming irq 307
[   63.479034] resume_irqs: resuming irq 308
[   63.483245] resume_irqs: resuming irq 309
[   63.487426] resume_irqs: resuming irq 310
[   63.491638] resume_irqs: resuming irq 311
[   63.495849] resume_irqs: resuming irq 312
[   63.500061] resume_irqs: resuming irq 313
[   63.504272] resume_irqs: resuming irq 314
[   63.508453] resume_irqs: resuming irq 315
[   63.512664] resume_irqs: resuming irq 316
[   63.516876] resume_irqs: resuming irq 317
[   63.521087] resume_irqs: resuming irq 318
[   63.525268] resume_irqs: resuming irq 319
[   63.529479] resume_irqs: resuming irq 320
[   63.533691] resume_irqs: resuming irq 321
[   63.537902] resume_irqs: resuming irq 322
[   63.542083] resume_irqs: resuming irq 323
[   63.546295] resume_irqs: resuming irq 324
[   63.550506] resume_irqs: resuming irq 325
[   63.554718] resume_irqs: resuming irq 326
[   63.558898] resume_irqs: resuming irq 327
[   63.563110] resume_irqs: resuming irq 328
[   63.567321] resume_irqs: resuming irq 329
[   63.571533] resume_irqs: resuming irq 330
[   63.575714] resume_irqs: resuming irq 331
[   63.579925] resume_irqs: resuming irq 332
[   63.584136] resume_irqs: resuming irq 333
[   63.588348] resume_irqs: resuming irq 334
[   63.592529] resume_irqs: resuming irq 335
[   63.596740] resume_irqs: resuming irq 336
[   63.600952] resume_irqs: resuming irq 337
[   63.605163] resume_irqs: resuming irq 338
[   63.609374] resume_irqs: resuming irq 339
[   63.613555] resume_irqs: resuming irq 340
[   63.617767] resume_irqs: resuming irq 341
[   63.621978] resume_irqs: resuming irq 342
[   63.626190] resume_irqs: resuming irq 343
[   63.630371] resume_irqs: resuming irq 344
[   63.634582] resume_irqs: resuming irq 345
[   63.638793] resume_irqs: resuming irq 346
[   63.643005] resume_irqs: resuming irq 347
[   63.647186] resume_irqs: resuming irq 348
[   63.651397] resume_irqs: resuming irq 349
[   63.655609] resume_irqs: resuming irq 350
[   63.659820] resume_irqs: resuming irq 351
[   63.664001] resume_irqs: resuming irq 352
[   63.668212] resume_irqs: resuming irq 353
[   63.672424] resume_irqs: resuming irq 354
[   63.676635] resume_irqs: resuming irq 355
[   63.680847] resume_irqs: resuming irq 356
[   63.685028] resume_irqs: resuming irq 357
[   63.689239] resume_irqs: resuming irq 358
[   63.693450] resume_irqs: resuming irq 359
[   63.697662] resume_irqs: resuming irq 360
[   63.701843] resume_irqs: resuming irq 361
[   63.706054] resume_irqs: resuming irq 362
[   63.710266] resume_irqs: resuming irq 363
[   63.714477] resume_irqs: resuming irq 364
[   63.718658] resume_irqs: resuming irq 365
[   63.722869] resume_irqs: resuming irq 366
[   63.727081] resume_irqs: resuming irq 367
[   63.731292] resume_irqs: resuming irq 368
[   63.735473] resume_irqs: resuming irq 369
[   63.739685] resume_irqs: resuming irq 370
[   63.743896] resume_irqs: resuming irq 371
[   63.752044] PM: noirq resume of devices complete after 3.082 msecs
[   63.758697] before allowing irqs
[   63.762115] resume_irqs: resuming irq 0
[   63.766265] resume_irqs: resuming irq 1
[   63.770294] resume_irqs: resuming irq 2
[   63.774444] resume_irqs: resuming irq 3
[   63.778503] resume_irqs: resuming irq 4
[   63.782623] resume_irqs: resuming irq 5
[   63.786682] resume_irqs: resuming irq 6
[   63.790802] resume_irqs: resuming irq 7
[   63.794860] resume_irqs: resuming irq 8
[   63.798980] resume_irqs: resuming irq 9
[   63.803039] resume_irqs: resuming irq 10
[   63.807250] resume_irqs: resuming irq 11
[   63.811492] resume_irqs: resuming irq 12
[   63.815612] resume_irqs: resuming irq 13
[   63.819854] resume_irqs: resuming irq 14
[   63.823974] resume_irqs: resuming irq 15
[   63.828216] resume_irqs: resuming irq 16
[   63.832336] resume_irqs: resuming irq 17
[   63.836578] resume_irqs: resuming irq 18
[   63.840698] resume_irqs: resuming irq 19
[   63.844940] resume_irqs: resuming irq 20
[   63.849060] resume_irqs: resuming irq 21
[   63.853302] resume_irqs: resuming irq 22
[   63.857421] resume_irqs: resuming irq 23
[   63.863555] omap_i2c_xfer: Enabled irq 72
[   63.867919] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.873443] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.879058] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.886535] omap_i2c_xfer: Disabled irq 72
[   63.891052] omap_i2c_xfer: Enabled irq 72
[   63.895263] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.900848] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.906463] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.912017] omap_i2c_xfer: Disabled irq 72
[   63.916473] omap_i2c_xfer: Enabled irq 72
[   63.920806] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.926300] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.931915] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.937530] omap_i2c_xfer: Disabled irq 72
[   63.941925] omap_i2c_xfer: Enabled irq 72
[   63.946228] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.951751] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.957336] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.962982] omap_i2c_xfer: Disabled irq 72
[   63.967346] omap_i2c_xfer: Enabled irq 72
[   63.971679] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.977233] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.982788] omap_i2c_isr: irq 72, runtime_suspended = 0
[   63.988403] omap_i2c_xfer: Disabled irq 72
[   63.992858] omap_i2c_xfer: Enabled irq 72
[   63.997100] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.002685] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.008300] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.013854] omap_i2c_xfer: Disabled irq 72
[   64.018310] omap_i2c_xfer: Enabled irq 72
[   64.022613] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.028137] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.033721] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.039337] omap_i2c_xfer: Disabled irq 72
[   64.043731] omap_i2c_xfer: Enabled irq 72
[   64.048034] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.053619] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.059173] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.064788] omap_i2c_xfer: Disabled irq 72
[   64.069244] omap_i2c_xfer: Enabled irq 72
[   64.073486] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.079040] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.084594] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.090209] omap_i2c_xfer: Disabled irq 72
[   64.094665] omap_i2c_xfer: Enabled irq 72
[   64.098907] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.104492] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.110076] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.115631] omap_i2c_xfer: Disabled irq 72
[   64.120086] omap_i2c_xfer: Enabled irq 72
[   64.124389] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.129913] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.135498] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.141143] omap_i2c_xfer: Disabled irq 72
[   64.145507] omap_i2c_xfer: Enabled irq 72
[   64.149841] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.155395] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.160949] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.166564] omap_i2c_xfer: Disabled irq 72
[   64.171020] omap_i2c_xfer: Enabled irq 72
[   64.175262] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.180847] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.186431] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.191986] omap_i2c_xfer: Disabled irq 72
[   64.196441] omap_i2c_xfer: Enabled irq 72
[   64.200683] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.206268] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.211853] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.217407] omap_i2c_xfer: Disabled irq 72
[   64.221862] omap_i2c_xfer: Enabled irq 72
[   64.226196] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.231689] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.237274] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.242919] omap_i2c_xfer: Disabled irq 72
[   64.247283] omap_i2c_xfer: Enabled irq 72
[   64.251617] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.257171] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.262725] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.268341] omap_i2c_xfer: Disabled irq 72
[   64.272796] omap_i2c_xfer: Enabled irq 72
[   64.277038] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.282623] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.288208] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.293762] omap_i2c_xfer: Disabled irq 72
[   64.298217] omap_i2c_xfer: Enabled irq 72
[   64.302459] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.308044] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.313659] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.319274] omap_i2c_xfer: Disabled irq 72
[   64.323669] omap_i2c_xfer: Enabled irq 72
[   64.327972] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.333496] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.339080] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.344726] omap_i2c_xfer: Disabled irq 72
[   64.349090] omap_i2c_xfer: Enabled irq 72
[   64.353424] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.358978] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.364532] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.370147] omap_i2c_xfer: Disabled irq 72
[   64.374603] omap_i2c_xfer: Enabled irq 72
[   64.378845] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.384429] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.390045] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.395599] omap_i2c_xfer: Disabled irq 72
[   64.400024] omap_i2c_xfer: Enabled irq 72
[   64.404266] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.409851] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.415435] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.421081] omap_i2c_xfer: Disabled irq 72
[   64.425445] omap_i2c_xfer: Enabled irq 72
[   64.429779] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.435272] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.440887] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.446502] omap_i2c_xfer: Disabled irq 72
[   64.450897] omap_i2c_xfer: Enabled irq 72
[   64.455200] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.460784] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.466339] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.471954] omap_i2c_xfer: Disabled irq 72
[   64.476409] omap_i2c_xfer: Enabled irq 72
[   64.480651] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.486236] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.491821] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.497375] omap_i2c_xfer: Disabled irq 72
[   64.501831] omap_i2c_xfer: Enabled irq 72
[   64.506072] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.511627] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.517242] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.522888] omap_i2c_xfer: Disabled irq 72
[   64.527252] omap_i2c_xfer: Enabled irq 72
[   64.531585] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.537078] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.542694] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.548309] omap_i2c_xfer: Disabled irq 72
[   64.552673] omap_i2c_xfer: Enabled irq 72
[   64.557006] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.562561] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.568115] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.573730] omap_i2c_xfer: Disabled irq 72
[   64.578186] omap_i2c_xfer: Enabled irq 72
[   64.582427] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.588012] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.593597] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.599151] omap_i2c_xfer: Disabled irq 72
[   64.603607] omap_i2c_xfer: Enabled irq 72
[   64.607849] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.613433] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.619018] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.624664] omap_i2c_xfer: Disabled irq 72
[   64.629028] omap_i2c_xfer: Enabled irq 72
[   64.633331] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.638854] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.644439] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.650085] omap_i2c_xfer: Disabled irq 72
[   64.654449] omap_i2c_xfer: Enabled irq 72
[   64.658782] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.664367] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.669891] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.675537] omap_i2c_xfer: Disabled irq 72
[   64.679992] omap_i2c_xfer: Enabled irq 72
[   64.684234] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.689788] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.695404] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.700958] omap_i2c_xfer: Disabled irq 72
[   64.705413] omap_i2c_xfer: Enabled irq 72
[   64.709655] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.715240] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.720825] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.726470] omap_i2c_xfer: Disabled irq 72
[   64.730834] omap_i2c_xfer: Enabled irq 72
[   64.735168] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.740661] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.746246] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.751892] omap_i2c_xfer: Disabled irq 72
[   64.756256] omap_i2c_xfer: Enabled irq 72
[   64.760589] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.766174] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.771697] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.777313] omap_i2c_xfer: Disabled irq 72
[   64.781799] omap_i2c_xfer: Enabled irq 72
[   64.786010] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.791595] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.797210] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.802734] omap_i2c_xfer: Disabled irq 72
[   64.807189] omap_i2c_xfer: Enabled irq 72
[   64.811523] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.817016] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.822631] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.828247] omap_i2c_xfer: Disabled irq 72
[   64.832641] omap_i2c_xfer: Enabled irq 72
[   64.836944] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.842468] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.848052] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.853668] omap_i2c_xfer: Disabled irq 72
[   64.858062] omap_i2c_xfer: Enabled irq 72
[   64.862365] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.867950] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.873474] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.879119] omap_i2c_xfer: Disabled irq 72
[   64.883575] omap_i2c_xfer: Enabled irq 72
[   64.887786] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.893371] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.898956] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.904510] omap_i2c_xfer: Disabled irq 72
[   64.908966] omap_i2c_xfer: Enabled irq 72
[   64.913299] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.918792] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.924407] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.930023] omap_i2c_xfer: Disabled irq 72
[   64.934417] omap_i2c_xfer: Enabled irq 72
[   64.938720] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.944305] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.949829] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.955474] omap_i2c_xfer: Disabled irq 72
[   64.959930] omap_i2c_xfer: Enabled irq 72
[   64.964141] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.969726] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.975280] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.980895] omap_i2c_xfer: Disabled irq 72
[   64.985351] omap_i2c_xfer: Enabled irq 72
[   64.989593] omap_i2c_isr: irq 72, runtime_suspended = 0
[   64.995147] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.000762] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.006317] omap_i2c_xfer: Disabled irq 72
[   65.010772] omap_i2c_xfer: Enabled irq 72
[   65.015106] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.020599] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.026184] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.031829] omap_i2c_xfer: Disabled irq 72
[   65.036224] omap_i2c_xfer: Enabled irq 72
[   65.040527] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.046112] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.051635] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.057250] omap_i2c_xfer: Disabled irq 72
[   65.061706] omap_i2c_xfer: Enabled irq 72
[   65.065948] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.071533] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.077117] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.082672] omap_i2c_xfer: Disabled irq 72
[   65.087127] omap_i2c_xfer: Enabled irq 72
[   65.091369] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.096954] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.102539] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.108093] omap_i2c_xfer: Disabled irq 72
[   65.112548] omap_i2c_xfer: Enabled irq 72
[   65.116882] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.122375] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.127990] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.133605] omap_i2c_xfer: Disabled irq 72
[   65.138000] omap_i2c_xfer: Enabled irq 72
[   65.142303] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.147888] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.153442] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.159057] omap_i2c_xfer: Disabled irq 72
[   65.163513] omap_i2c_xfer: Enabled irq 72
[   65.167724] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.173309] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.178924] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.184478] omap_i2c_xfer: Disabled irq 72
[   65.188934] omap_i2c_xfer: Enabled irq 72
[   65.193145] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.198730] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.204345] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.209960] omap_i2c_xfer: Disabled irq 72
[   65.214324] omap_i2c_xfer: Enabled irq 72
[   65.218658] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.224151] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.229766] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.235382] omap_i2c_xfer: Disabled irq 72
[   65.239776] omap_i2c_xfer: Enabled irq 72
[   65.244079] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.249664] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.255187] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.260864] resume_irqs: resuming irq 24
[   65.265045] [sched_delayed] sched: RT throttling activated
[   65.270904] resume_irqs: resuming irq 25
[   65.275146] resume_irqs: resuming irq 26
[   65.279266] resume_irqs: resuming irq 27
[   65.283508] resume_irqs: resuming irq 28
[   65.287628] resume_irqs: resuming irq 29
[   65.291870] resume_irqs: resuming irq 30
[   65.296112] resume_irqs: resuming irq 31
[   65.300231] resume_irqs: resuming irq 32
[   65.304473] resume_irqs: resuming irq 33
[   65.308593] resume_irqs: resuming irq 34
[   65.312866] omap_i2c_xfer: Disabled irq 72
[   65.317260] omap_i2c_xfer: Enabled irq 72
[   65.321594] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.327178] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.332733] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.338378] omap_i2c_xfer: Disabled irq 72
[   65.342834] omap_i2c_xfer: Enabled irq 72
[   65.347076] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.352630] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.358245] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.363800] omap_i2c_xfer: Disabled irq 72
[   65.368255] omap_i2c_xfer: Enabled irq 72
[   65.372497] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.378082] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.383697] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.389251] omap_i2c_xfer: Disabled irq 72
[   65.393707] omap_i2c_xfer: Enabled irq 72
[   65.398040] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.403533] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.409118] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.414764] omap_i2c_xfer: Disabled irq 72
[   65.419128] omap_i2c_xfer: Enabled irq 72
[   65.423461] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.429016] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.434570] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.440185] omap_i2c_xfer: Disabled irq 72
[   65.444641] omap_i2c_xfer: Enabled irq 72
[   65.448883] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.454437] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.460052] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.465606] omap_i2c_xfer: Disabled irq 72
[   65.470062] omap_i2c_xfer: Enabled irq 72
[   65.474304] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.479858] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.485473] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.491088] omap_i2c_xfer: Disabled irq 72
[   65.495483] omap_i2c_xfer: Enabled irq 72
[   65.499786] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.505310] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.510894] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.516540] omap_i2c_xfer: Disabled irq 72
[   65.520904] omap_i2c_xfer: Enabled irq 72
[   65.525238] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.530792] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.536346] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.541961] omap_i2c_xfer: Disabled irq 72
[   65.546417] omap_i2c_xfer: Enabled irq 72
[   65.550659] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.556243] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.561828] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.567382] omap_i2c_xfer: Disabled irq 72
[   65.571838] omap_i2c_xfer: Enabled irq 72
[   65.576080] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.581634] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.587249] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.592864] omap_i2c_xfer: Disabled irq 72
[   65.597259] omap_i2c_xfer: Enabled irq 72
[   65.601593] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.607086] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.612670] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.618316] omap_i2c_xfer: Disabled irq 72
[   65.622680] omap_i2c_xfer: Enabled irq 72
[   65.627014] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.632568] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.638122] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.643737] omap_i2c_xfer: Disabled irq 72
[   65.648193] omap_i2c_xfer: Enabled irq 72
[   65.652435] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.658020] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.663604] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.669158] omap_i2c_xfer: Disabled irq 72
[   65.673614] omap_i2c_xfer: Enabled irq 72
[   65.677856] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.683441] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.689025] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.694671] omap_i2c_xfer: Disabled irq 72
[   65.699035] omap_i2c_xfer: Enabled irq 72
[   65.703369] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.708862] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.714447] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.720092] omap_i2c_xfer: Disabled irq 72
[   65.724456] omap_i2c_xfer: Enabled irq 72
[   65.728790] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.734344] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.739898] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.745513] omap_i2c_xfer: Disabled irq 72
[   65.749969] omap_i2c_xfer: Enabled irq 72
[   65.754211] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.759796] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.765380] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.770935] omap_i2c_xfer: Disabled irq 72
[   65.775390] omap_i2c_xfer: Enabled irq 72
[   65.779632] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.785186] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.790802] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.796417] omap_i2c_xfer: Disabled irq 72
[   65.800811] omap_i2c_xfer: Enabled irq 72
[   65.805114] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.810638] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.816223] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.821868] omap_i2c_xfer: Disabled irq 72
[   65.826263] omap_i2c_xfer: Enabled irq 72
[   65.830566] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.836151] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.841674] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.847320] omap_i2c_xfer: Disabled irq 72
[   65.851776] omap_i2c_xfer: Enabled irq 72
[   65.856018] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.861572] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.867187] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.872741] omap_i2c_xfer: Disabled irq 72
[   65.877197] omap_i2c_xfer: Enabled irq 72
[   65.881408] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.886993] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.892608] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.898223] omap_i2c_xfer: Disabled irq 72
[   65.902587] omap_i2c_xfer: Enabled irq 72
[   65.906921] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.912445] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.918029] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.923645] omap_i2c_xfer: Disabled irq 72
[   65.928039] omap_i2c_xfer: Enabled irq 72
[   65.932342] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.937927] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.943481] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.949096] omap_i2c_xfer: Disabled irq 72
[   65.953552] omap_i2c_xfer: Enabled irq 72
[   65.957794] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.963348] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.968963] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.974517] omap_i2c_xfer: Disabled irq 72
[   65.978973] omap_i2c_xfer: Enabled irq 72
[   65.983276] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.988800] omap_i2c_isr: irq 72, runtime_suspended = 0
[   65.994384] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.000030] omap_i2c_xfer: Disabled irq 72
[   66.004394] omap_i2c_xfer: Enabled irq 72
[   66.008728] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.014221] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.019836] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.025451] omap_i2c_xfer: Disabled irq 72
[   66.029846] omap_i2c_xfer: Enabled irq 72
[   66.034149] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.039733] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.045257] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.050903] omap_i2c_xfer: Disabled irq 72
[   66.055358] omap_i2c_xfer: Enabled irq 72
[   66.059600] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.065185] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.070770] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.076324] omap_i2c_xfer: Disabled irq 72
[   66.080810] omap_i2c_xfer: Enabled irq 72
[   66.085113] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.090606] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.096221] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.101837] omap_i2c_xfer: Disabled irq 72
[   66.106231] omap_i2c_xfer: Enabled irq 72
[   66.110534] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.116119] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.121643] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.127288] omap_i2c_xfer: Disabled irq 72
[   66.131744] omap_i2c_xfer: Enabled irq 72
[   66.135955] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.141540] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.147094] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.152709] omap_i2c_xfer: Disabled irq 72
[   66.157165] omap_i2c_xfer: Enabled irq 72
[   66.161407] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.166961] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.172576] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.178131] omap_i2c_xfer: Disabled irq 72
[   66.182586] omap_i2c_xfer: Enabled irq 72
[   66.186889] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.192413] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.197998] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.203643] omap_i2c_xfer: Disabled irq 72
[   66.208007] omap_i2c_xfer: Enabled irq 72
[   66.212341] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.217895] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.223449] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.229064] omap_i2c_xfer: Disabled irq 72
[   66.233520] omap_i2c_xfer: Enabled irq 72
[   66.237762] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.243316] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.248931] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.254486] omap_i2c_xfer: Disabled irq 72
[   66.258941] omap_i2c_xfer: Enabled irq 72
[   66.263153] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.268737] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.274353] resume_irqs: resuming irq 35
[   66.278503] resume_irqs: resuming irq 36
[   66.282745] resume_irqs: resuming irq 37
[   66.286865] resume_irqs: resuming irq 38
[   66.291107] resume_irqs: resuming irq 39
[   66.295227] resume_irqs: resuming irq 40
[   66.299468] resume_irqs: resuming irq 41
[   66.303710] resume_irqs: resuming irq 42
[   66.307830] resume_irqs: resuming irq 43
[   66.312103] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.317687] omap_i2c_xfer: Disabled irq 72
[   66.322143] omap_i2c_xfer: Enabled irq 72
[   66.326385] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.331939] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.337554] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.343200] omap_i2c_xfer: Disabled irq 72
[   66.347564] omap_i2c_xfer: Enabled irq 72
[   66.351867] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.357391] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.362976] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.368621] omap_i2c_xfer: Disabled irq 72
[   66.372985] omap_i2c_xfer: Enabled irq 72
[   66.377319] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.382904] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.388427] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.394042] omap_i2c_xfer: Disabled irq 72
[   66.398529] omap_i2c_xfer: Enabled irq 72
[   66.402740] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.408325] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.413940] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.419494] omap_i2c_xfer: Disabled irq 72
[   66.423950] omap_i2c_xfer: Enabled irq 72
[   66.428161] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.433746] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.439361] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.444976] omap_i2c_xfer: Disabled irq 72
[   66.449371] omap_i2c_xfer: Enabled irq 72
[   66.453674] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.459197] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.464782] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.470397] omap_i2c_xfer: Disabled irq 72
[   66.474792] omap_i2c_xfer: Enabled irq 72
[   66.479095] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.484680] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.490234] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.495849] omap_i2c_xfer: Disabled irq 72
[   66.500305] omap_i2c_xfer: Enabled irq 72
[   66.504547] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.510101] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.515716] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.521270] omap_i2c_xfer: Disabled irq 72
[   66.525726] omap_i2c_xfer: Enabled irq 72
[   66.529968] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.535552] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.541168] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.546783] omap_i2c_xfer: Disabled irq 72
[   66.551177] omap_i2c_xfer: Enabled irq 72
[   66.555480] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.560974] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.566589] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.572204] omap_i2c_xfer: Disabled irq 72
[   66.576599] omap_i2c_xfer: Enabled irq 72
[   66.580902] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.586486] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.592010] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.597656] omap_i2c_xfer: Disabled irq 72
[   66.602111] omap_i2c_xfer: Enabled irq 72
[   66.606353] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.611907] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.617523] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.623077] omap_i2c_xfer: Disabled irq 72
[   66.627532] omap_i2c_xfer: Enabled irq 72
[   66.631866] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.637359] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.642944] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.648590] omap_i2c_xfer: Disabled irq 72
[   66.652954] omap_i2c_xfer: Enabled irq 72
[   66.657287] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.662780] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.668365] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.674011] omap_i2c_xfer: Disabled irq 72
[   66.678375] omap_i2c_xfer: Enabled irq 72
[   66.682708] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.688262] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.693817] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.699432] omap_i2c_xfer: Disabled irq 72
[   66.703887] omap_i2c_xfer: Enabled irq 72
[   66.708129] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.713684] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.719299] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.724853] omap_i2c_xfer: Disabled irq 72
[   66.729309] omap_i2c_xfer: Enabled irq 72
[   66.733612] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.739135] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.744720] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.750366] omap_i2c_xfer: Disabled irq 72
[   66.754760] omap_i2c_xfer: Enabled irq 72
[   66.759063] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.764648] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.770172] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.775817] omap_i2c_xfer: Disabled irq 72
[   66.780273] omap_i2c_xfer: Enabled irq 72
[   66.784484] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.790069] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.795593] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.801239] omap_i2c_xfer: Disabled irq 72
[   66.805694] omap_i2c_xfer: Enabled irq 72
[   66.809906] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.815490] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.821105] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.826660] omap_i2c_xfer: Disabled irq 72
[   66.831085] omap_i2c_xfer: Enabled irq 72
[   66.835418] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.840942] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.846527] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.852142] omap_i2c_xfer: Disabled irq 72
[   66.856536] omap_i2c_xfer: Enabled irq 72
[   66.860839] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.866424] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.871978] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.877593] omap_i2c_xfer: Disabled irq 72
[   66.882049] omap_i2c_xfer: Enabled irq 72
[   66.886291] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.891845] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.897460] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.903015] omap_i2c_xfer: Disabled irq 72
[   66.907470] omap_i2c_xfer: Enabled irq 72
[   66.911712] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.917266] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.922882] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.928497] omap_i2c_xfer: Disabled irq 72
[   66.932891] omap_i2c_xfer: Enabled irq 72
[   66.937194] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.942718] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.948303] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.953948] omap_i2c_xfer: Disabled irq 72
[   66.958312] omap_i2c_xfer: Enabled irq 72
[   66.962646] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.968200] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.973754] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.979370] omap_i2c_xfer: Disabled irq 72
[   66.983825] omap_i2c_xfer: Enabled irq 72
[   66.988067] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.993652] omap_i2c_isr: irq 72, runtime_suspended = 0
[   66.999237] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.004791] omap_i2c_xfer: Disabled irq 72
[   67.009277] omap_i2c_xfer: Enabled irq 72
[   67.013488] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.019073] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.024658] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.030303] omap_i2c_xfer: Disabled irq 72
[   67.034667] omap_i2c_xfer: Enabled irq 72
[   67.039001] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.044494] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.050109] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.055725] omap_i2c_xfer: Disabled irq 72
[   67.060119] omap_i2c_xfer: Enabled irq 72
[   67.064422] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.070007] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.075531] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.081176] omap_i2c_xfer: Disabled irq 72
[   67.085601] omap_i2c_xfer: Enabled irq 72
[   67.089843] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.095428] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.101043] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.106567] omap_i2c_xfer: Disabled irq 72
[   67.111053] omap_i2c_xfer: Enabled irq 72
[   67.115264] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.120849] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.126434] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.132080] omap_i2c_xfer: Disabled irq 72
[   67.136444] omap_i2c_xfer: Enabled irq 72
[   67.140747] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.146270] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.151855] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.157501] omap_i2c_xfer: Disabled irq 72
[   67.161865] omap_i2c_xfer: Enabled irq 72
[   67.166198] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.171752] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.177307] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.182922] omap_i2c_xfer: Disabled irq 72
[   67.187377] omap_i2c_xfer: Enabled irq 72
[   67.191619] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.197204] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.202789] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.208343] omap_i2c_xfer: Disabled irq 72
[   67.212799] omap_i2c_xfer: Enabled irq 72
[   67.217041] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.222625] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.228240] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.233856] omap_i2c_xfer: Disabled irq 72
[   67.238220] omap_i2c_xfer: Enabled irq 72
[   67.242553] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.248046] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.253662] resume_irqs: resuming irq 44
[   67.257934] resume_irqs: resuming irq 45
[   67.262054] resume_irqs: resuming irq 46
[   67.266296] resume_irqs: resuming irq 47
[   67.270416] resume_irqs: resuming irq 48
[   67.274658] resume_irqs: resuming irq 49
[   67.278778] resume_irqs: resuming irq 50
[   67.283020] resume_irqs: resuming irq 51
[   67.287139] resume_irqs: resuming irq 52
[   67.291381] resume_irqs: resuming irq 53
[   67.295501] resume_irqs: resuming irq 54
[   67.299743] resume_irqs: resuming irq 55
[   67.303985] resume_irqs: resuming irq 56
[   67.308105] resume_irqs: resuming irq 57
[   67.312377] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.317932] omap_i2c_xfer: Disabled irq 72
[   67.322418] omap_i2c_xfer: Enabled irq 72
[   67.326629] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.332214] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.337829] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.343444] omap_i2c_xfer: Disabled irq 72
[   67.347839] omap_i2c_xfer: Enabled irq 72
[   67.352142] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.357666] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.363250] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.368896] omap_i2c_xfer: Disabled irq 72
[   67.373260] omap_i2c_xfer: Enabled irq 72
[   67.377563] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.383148] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.388702] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.394317] omap_i2c_xfer: Disabled irq 72
[   67.398773] omap_i2c_xfer: Enabled irq 72
[   67.402984] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.408569] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.414184] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.419738] omap_i2c_xfer: Disabled irq 72
[   67.424194] omap_i2c_xfer: Enabled irq 72
[   67.428436] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.433990] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.439605] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.445220] omap_i2c_xfer: Disabled irq 72
[   67.449615] omap_i2c_xfer: Enabled irq 72
[   67.453948] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.459442] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.465057] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.470672] omap_i2c_xfer: Disabled irq 72
[   67.475036] omap_i2c_xfer: Enabled irq 72
[   67.479370] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.484924] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.490478] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.496093] omap_i2c_xfer: Disabled irq 72
[   67.500579] omap_i2c_xfer: Enabled irq 72
[   67.504791] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.510375] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.515960] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.521545] omap_i2c_xfer: Disabled irq 72
[   67.526000] omap_i2c_xfer: Enabled irq 72
[   67.530303] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.535827] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.541412] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.547027] omap_i2c_xfer: Disabled irq 72
[   67.551422] omap_i2c_xfer: Enabled irq 72
[   67.555725] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.561309] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.566833] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.572479] omap_i2c_xfer: Disabled irq 72
[   67.576843] omap_i2c_xfer: Enabled irq 72
[   67.581176] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.586730] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.592285] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.597900] omap_i2c_xfer: Disabled irq 72
[   67.602355] omap_i2c_xfer: Enabled irq 72
[   67.606597] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.612152] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.617767] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.623321] omap_i2c_xfer: Disabled irq 72
[   67.627777] omap_i2c_xfer: Enabled irq 72
[   67.632080] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.637603] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.643188] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.648834] omap_i2c_xfer: Disabled irq 72
[   67.653198] omap_i2c_xfer: Enabled irq 72
[   67.657501] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.663085] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.668640] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.674255] omap_i2c_xfer: Disabled irq 72
[   67.678741] omap_i2c_xfer: Enabled irq 72
[   67.682952] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.688537] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.694152] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.699707] omap_i2c_xfer: Disabled irq 72
[   67.704162] omap_i2c_xfer: Enabled irq 72
[   67.708374] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.713958] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.719573] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.725097] omap_i2c_xfer: Disabled irq 72
[   67.729583] omap_i2c_xfer: Enabled irq 72
[   67.733886] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.739379] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.744995] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.750610] omap_i2c_xfer: Disabled irq 72
[   67.755004] omap_i2c_xfer: Enabled irq 72
[   67.759307] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.764892] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.770416] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.776031] omap_i2c_xfer: Disabled irq 72
[   67.780487] omap_i2c_xfer: Enabled irq 72
[   67.784729] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.790313] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.795898] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.801452] omap_i2c_xfer: Disabled irq 72
[   67.805908] omap_i2c_xfer: Enabled irq 72
[   67.810150] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.815734] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.821319] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.826965] omap_i2c_xfer: Disabled irq 72
[   67.831329] omap_i2c_xfer: Enabled irq 72
[   67.835662] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.841156] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.846740] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.852386] omap_i2c_xfer: Disabled irq 72
[   67.856750] omap_i2c_xfer: Enabled irq 72
[   67.861053] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.866638] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.872161] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.877807] omap_i2c_xfer: Disabled irq 72
[   67.882263] omap_i2c_xfer: Enabled irq 72
[   67.886505] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.892059] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.897674] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.903228] omap_i2c_xfer: Disabled irq 72
[   67.907684] omap_i2c_xfer: Enabled irq 72
[   67.911926] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.917480] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.923095] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.928710] omap_i2c_xfer: Disabled irq 72
[   67.933105] omap_i2c_xfer: Enabled irq 72
[   67.937408] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.942932] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.948516] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.954162] omap_i2c_xfer: Disabled irq 72
[   67.958526] omap_i2c_xfer: Enabled irq 72
[   67.962860] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.968444] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.973968] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.979583] omap_i2c_xfer: Disabled irq 72
[   67.984039] omap_i2c_xfer: Enabled irq 72
[   67.988281] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.993865] omap_i2c_isr: irq 72, runtime_suspended = 0
[   67.999450] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.005004] omap_i2c_xfer: Disabled irq 72
[   68.009490] omap_i2c_xfer: Enabled irq 72
[   68.013702] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.019287] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.024902] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.030517] omap_i2c_xfer: Disabled irq 72
[   68.034881] omap_i2c_xfer: Enabled irq 72
[   68.039215] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.044708] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.050323] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.055938] omap_i2c_xfer: Disabled irq 72
[   68.060333] omap_i2c_xfer: Enabled irq 72
[   68.064636] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.070220] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.075744] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.081390] omap_i2c_xfer: Disabled irq 72
[   68.085845] omap_i2c_xfer: Enabled irq 72
[   68.090057] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.095642] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.101226] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.106781] omap_i2c_xfer: Disabled irq 72
[   68.111267] omap_i2c_xfer: Enabled irq 72
[   68.115478] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.121063] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.126678] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.132293] omap_i2c_xfer: Disabled irq 72
[   68.136688] omap_i2c_xfer: Enabled irq 72
[   68.140991] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.146514] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.152099] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.157745] omap_i2c_xfer: Disabled irq 72
[   68.162109] omap_i2c_xfer: Enabled irq 72
[   68.166442] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.171997] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.177551] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.183166] omap_i2c_xfer: Disabled irq 72
[   68.187622] omap_i2c_xfer: Enabled irq 72
[   68.191864] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.197418] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.203033] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.208587] omap_i2c_xfer: Disabled irq 72
[   68.213043] omap_i2c_xfer: Enabled irq 72
[   68.217285] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.222839] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.228454] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.234069] omap_i2c_xfer: Disabled irq 72
[   68.238464] omap_i2c_xfer: Enabled irq 72
[   68.242767] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.248291] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.253875] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.259490] resume_irqs: resuming irq 58
[   68.263641] resume_irqs: resuming irq 59
[   68.267883] resume_irqs: resuming irq 60
[   68.272003] resume_irqs: resuming irq 61
[   68.276245] resume_irqs: resuming irq 62
[   68.280487] resume_irqs: resuming irq 63
[   68.284637] resume_irqs: resuming irq 64
[   68.288848] resume_irqs: resuming irq 65
[   68.292999] resume_irqs: resuming irq 66
[   68.297210] resume_irqs: resuming irq 67
[   68.301361] resume_irqs: resuming irq 68
[   68.305572] resume_irqs: resuming irq 69
[   68.309722] resume_irqs: resuming irq 70
[   68.314025] omap_i2c_xfer: Disabled irq 72
[   68.318389] omap_i2c_xfer: Enabled irq 72
[   68.322723] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.328308] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.333831] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.339508] omap_i2c_xfer: Disabled irq 72
[   68.343963] omap_i2c_xfer: Enabled irq 72
[   68.348205] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.353759] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.359374] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.364929] omap_i2c_xfer: Disabled irq 72
[   68.369384] omap_i2c_xfer: Enabled irq 72
[   68.373626] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.379211] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.384796] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.390441] omap_i2c_xfer: Disabled irq 72
[   68.394836] omap_i2c_xfer: Enabled irq 72
[   68.399139] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.404632] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.410247] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.415863] omap_i2c_xfer: Disabled irq 72
[   68.420257] omap_i2c_xfer: Enabled irq 72
[   68.424560] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.430145] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.435668] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.441314] omap_i2c_xfer: Disabled irq 72
[   68.445770] omap_i2c_xfer: Enabled irq 72
[   68.449981] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.455566] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.461181] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.466735] omap_i2c_xfer: Disabled irq 72
[   68.471191] omap_i2c_xfer: Enabled irq 72
[   68.475494] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.481018] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.486602] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.492218] omap_i2c_xfer: Disabled irq 72
[   68.496612] omap_i2c_xfer: Enabled irq 72
[   68.500915] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.506439] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.512023] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.517669] omap_i2c_xfer: Disabled irq 72
[   68.522033] omap_i2c_xfer: Enabled irq 72
[   68.526367] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.531921] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.537475] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.543090] omap_i2c_xfer: Disabled irq 72
[   68.547546] omap_i2c_xfer: Enabled irq 72
[   68.551788] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.557373] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.562957] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.568511] omap_i2c_xfer: Disabled irq 72
[   68.572967] omap_i2c_xfer: Enabled irq 72
[   68.577301] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.582794] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.588409] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.594024] omap_i2c_xfer: Disabled irq 72
[   68.598419] omap_i2c_xfer: Enabled irq 72
[   68.602722] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.608306] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.613830] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.619476] omap_i2c_xfer: Disabled irq 72
[   68.623931] omap_i2c_xfer: Enabled irq 72
[   68.628173] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.633728] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.639282] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.644897] omap_i2c_xfer: Disabled irq 72
[   68.649353] omap_i2c_xfer: Enabled irq 72
[   68.653594] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.659179] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.664764] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.670318] omap_i2c_xfer: Disabled irq 72
[   68.674774] omap_i2c_xfer: Enabled irq 72
[   68.679107] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.684600] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.690185] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.695831] omap_i2c_xfer: Disabled irq 72
[   68.700195] omap_i2c_xfer: Enabled irq 72
[   68.704498] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.710083] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.715637] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.721252] omap_i2c_xfer: Disabled irq 72
[   68.725708] omap_i2c_xfer: Enabled irq 72
[   68.729919] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.735504] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.741119] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.746673] omap_i2c_xfer: Disabled irq 72
[   68.751129] omap_i2c_xfer: Enabled irq 72
[   68.755340] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.760925] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.766540] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.772094] omap_i2c_xfer: Disabled irq 72
[   68.776550] omap_i2c_xfer: Enabled irq 72
[   68.780853] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.786346] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.791961] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.797576] omap_i2c_xfer: Disabled irq 72
[   68.801971] omap_i2c_xfer: Enabled irq 72
[   68.806274] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.811859] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.817413] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.823028] omap_i2c_xfer: Disabled irq 72
[   68.827484] omap_i2c_xfer: Enabled irq 72
[   68.831726] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.837310] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.842895] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.848449] omap_i2c_xfer: Disabled irq 72
[   68.852905] omap_i2c_xfer: Enabled irq 72
[   68.857147] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.862731] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.868316] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.873931] omap_i2c_xfer: Disabled irq 72
[   68.878326] omap_i2c_xfer: Enabled irq 72
[   68.882629] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.888153] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.893737] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.899353] omap_i2c_xfer: Disabled irq 72
[   68.903747] omap_i2c_xfer: Enabled irq 72
[   68.908050] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.913635] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.919158] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.924804] omap_i2c_xfer: Disabled irq 72
[   68.929260] omap_i2c_xfer: Enabled irq 72
[   68.933471] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.939056] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.944641] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.950195] omap_i2c_xfer: Disabled irq 72
[   68.954650] omap_i2c_xfer: Enabled irq 72
[   68.958892] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.964447] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.970062] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.975708] omap_i2c_xfer: Disabled irq 72
[   68.980072] omap_i2c_xfer: Enabled irq 72
[   68.984374] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.989898] omap_i2c_isr: irq 72, runtime_suspended = 0
[   68.995483] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.001129] omap_i2c_xfer: Disabled irq 72
[   69.005493] omap_i2c_xfer: Enabled irq 72
[   69.009826] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.015380] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.020935] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.026550] omap_i2c_xfer: Disabled irq 72
[   69.031005] omap_i2c_xfer: Enabled irq 72
[   69.035247] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.040832] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.046417] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.052001] omap_i2c_xfer: Disabled irq 72
[   69.056457] omap_i2c_xfer: Enabled irq 72
[   69.060668] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.066253] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.071868] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.077484] omap_i2c_xfer: Disabled irq 72
[   69.081878] omap_i2c_xfer: Enabled irq 72
[   69.086181] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.091705] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.097290] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.102935] omap_i2c_xfer: Disabled irq 72
[   69.107299] omap_i2c_xfer: Enabled irq 72
[   69.111633] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.117187] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.122741] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.128356] omap_i2c_xfer: Disabled irq 72
[   69.132812] omap_i2c_xfer: Enabled irq 72
[   69.137054] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.142639] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.148223] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.153778] omap_i2c_xfer: Disabled irq 72
[   69.158233] omap_i2c_xfer: Enabled irq 72
[   69.162475] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.168060] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.173645] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.179290] omap_i2c_xfer: Disabled irq 72
[   69.183654] omap_i2c_xfer: Enabled irq 72
[   69.187988] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.193481] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.199096] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.204711] omap_i2c_xfer: Disabled irq 72
[   69.209106] omap_i2c_xfer: Enabled irq 72
[   69.213409] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.218994] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.224517] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.230133] omap_i2c_xfer: Disabled irq 72
[   69.234619] omap_i2c_xfer: Enabled irq 72
[   69.238830] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.244415] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.249999] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.255554] omap_i2c_xfer: Disabled irq 72
[   69.260009] omap_i2c_xfer: Enabled irq 72
[   69.264251] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.269836] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.275451] resume_irqs: resuming irq 71
[   69.279602] resume_irqs: resuming irq 72
[   69.283843] resume_irqs: resuming irq 73
[   69.288085] resume_irqs: resuming irq 74
[   69.292205] resume_irqs: resuming irq 75
[   69.296447] resume_irqs: resuming irq 76
[   69.300567] resume_irqs: resuming irq 77
[   69.304809] resume_irqs: resuming irq 78
[   69.308929] resume_irqs: resuming irq 79
[   69.313201] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.318786] omap_i2c_xfer: Disabled irq 72
[   69.323242] omap_i2c_xfer: Enabled irq 72
[   69.327575] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.333068] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.338653] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.344299] omap_i2c_xfer: Disabled irq 72
[   69.348663] omap_i2c_xfer: Enabled irq 72
[   69.352996] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.358551] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.364105] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.369720] omap_i2c_xfer: Disabled irq 72
[   69.374176] omap_i2c_xfer: Enabled irq 72
[   69.378417] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.383972] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.389587] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.395141] omap_i2c_xfer: Disabled irq 72
[   69.399597] omap_i2c_xfer: Enabled irq 72
[   69.403839] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.409393] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.415008] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.420562] omap_i2c_xfer: Disabled irq 72
[   69.425018] omap_i2c_xfer: Enabled irq 72
[   69.429321] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.434844] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.440429] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.446075] omap_i2c_xfer: Disabled irq 72
[   69.450439] omap_i2c_xfer: Enabled irq 72
[   69.454742] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.460327] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.465850] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.471496] omap_i2c_xfer: Disabled irq 72
[   69.475952] omap_i2c_xfer: Enabled irq 72
[   69.480163] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.485748] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.491363] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.496917] omap_i2c_xfer: Disabled irq 72
[   69.501373] omap_i2c_xfer: Enabled irq 72
[   69.505584] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.511169] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.516784] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.522430] omap_i2c_xfer: Disabled irq 72
[   69.526794] omap_i2c_xfer: Enabled irq 72
[   69.531097] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.536621] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.542205] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.547851] omap_i2c_xfer: Disabled irq 72
[   69.552215] omap_i2c_xfer: Enabled irq 72
[   69.556549] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.562103] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.567657] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.573272] omap_i2c_xfer: Disabled irq 72
[   69.577728] omap_i2c_xfer: Enabled irq 72
[   69.581970] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.587524] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.593139] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.598693] omap_i2c_xfer: Disabled irq 72
[   69.603149] omap_i2c_xfer: Enabled irq 72
[   69.607391] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.612945] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.618560] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.624206] omap_i2c_xfer: Disabled irq 72
[   69.628570] omap_i2c_xfer: Enabled irq 72
[   69.632873] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.638397] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.643981] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.649627] omap_i2c_xfer: Disabled irq 72
[   69.653991] omap_i2c_xfer: Enabled irq 72
[   69.658325] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.663879] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.669433] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.675048] omap_i2c_xfer: Disabled irq 72
[   69.679504] omap_i2c_xfer: Enabled irq 72
[   69.683746] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.689331] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.694915] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.700469] omap_i2c_xfer: Disabled irq 72
[   69.704925] omap_i2c_xfer: Enabled irq 72
[   69.709167] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.714752] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.720336] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.725982] omap_i2c_xfer: Disabled irq 72
[   69.730346] omap_i2c_xfer: Enabled irq 72
[   69.734649] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.740173] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.745788] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.751403] omap_i2c_xfer: Disabled irq 72
[   69.755798] omap_i2c_xfer: Enabled irq 72
[   69.760101] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.765686] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.771209] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.776855] omap_i2c_xfer: Disabled irq 72
[   69.781311] omap_i2c_xfer: Enabled irq 72
[   69.785522] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.791107] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.796722] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.802276] omap_i2c_xfer: Disabled irq 72
[   69.806732] omap_i2c_xfer: Enabled irq 72
[   69.810943] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.816528] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.822143] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.827758] omap_i2c_xfer: Disabled irq 72
[   69.832122] omap_i2c_xfer: Enabled irq 72
[   69.836456] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.841949] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.847564] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.853179] omap_i2c_xfer: Disabled irq 72
[   69.857574] omap_i2c_xfer: Enabled irq 72
[   69.861877] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.867462] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.872985] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.878601] omap_i2c_xfer: Disabled irq 72
[   69.883056] omap_i2c_xfer: Enabled irq 72
[   69.887298] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.892883] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.898468] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.904022] omap_i2c_xfer: Disabled irq 72
[   69.908477] omap_i2c_xfer: Enabled irq 72
[   69.912719] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.918273] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.923889] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.929504] omap_i2c_xfer: Disabled irq 72
[   69.933898] omap_i2c_xfer: Enabled irq 72
[   69.938201] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.943725] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.949310] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.954925] omap_i2c_xfer: Disabled irq 72
[   69.959320] omap_i2c_xfer: Enabled irq 72
[   69.963623] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.969207] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.974731] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.980377] omap_i2c_xfer: Disabled irq 72
[   69.984832] omap_i2c_xfer: Enabled irq 72
[   69.989044] omap_i2c_isr: irq 72, runtime_suspended = 0
[   69.994628] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.000244] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.005798] omap_i2c_xfer: Disabled irq 72
[   70.010253] omap_i2c_xfer: Enabled irq 72
[   70.014587] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.020080] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.025665] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.031311] omap_i2c_xfer: Disabled irq 72
[   70.035675] omap_i2c_xfer: Enabled irq 72
[   70.040008] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.045501] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.051116] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.056732] omap_i2c_xfer: Disabled irq 72
[   70.061126] omap_i2c_xfer: Enabled irq 72
[   70.065429] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.071014] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.076538] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.082183] omap_i2c_xfer: Disabled irq 72
[   70.086608] omap_i2c_xfer: Enabled irq 72
[   70.090850] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.096435] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.102050] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.107574] omap_i2c_xfer: Disabled irq 72
[   70.112030] omap_i2c_xfer: Enabled irq 72
[   70.116363] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.121856] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.127471] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.133087] omap_i2c_xfer: Disabled irq 72
[   70.137451] omap_i2c_xfer: Enabled irq 72
[   70.141784] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.147338] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.152893] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.158508] omap_i2c_xfer: Disabled irq 72
[   70.162963] omap_i2c_xfer: Enabled irq 72
[   70.167175] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.172760] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.178314] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.183929] omap_i2c_xfer: Disabled irq 72
[   70.188385] omap_i2c_xfer: Enabled irq 72
[   70.192596] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.198181] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.203796] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.209350] omap_i2c_xfer: Disabled irq 72
[   70.213806] omap_i2c_xfer: Enabled irq 72
[   70.218139] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.223632] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.229248] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.234863] omap_i2c_xfer: Disabled irq 72
[   70.239227] omap_i2c_xfer: Enabled irq 72
[   70.243560] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.249145] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.254699] resume_irqs: resuming irq 80
[   70.258941] resume_irqs: resuming irq 81
[   70.263061] resume_irqs: resuming irq 82
[   70.267303] resume_irqs: resuming irq 83
[   70.271453] resume_irqs: resuming irq 84
[   70.275665] resume_irqs: resuming irq 85
[   70.279815] resume_irqs: resuming irq 86
[   70.284027] resume_irqs: resuming irq 87
[   70.288269] resume_irqs: resuming irq 88
[   70.292419] resume_irqs: resuming irq 89
[   70.296630] resume_irqs: resuming irq 90
[   70.300781] resume_irqs: resuming irq 91
[   70.305023] resume_irqs: resuming irq 92
[   70.309143] resume_irqs: resuming irq 93
[   70.313415] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.318969] omap_i2c_xfer: Disabled irq 72
[   70.323455] omap_i2c_xfer: Enabled irq 72
[   70.327758] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.333282] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.338867] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.344512] omap_i2c_xfer: Disabled irq 72
[   70.348876] omap_i2c_xfer: Enabled irq 72
[   70.353210] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.358795] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.364318] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.369934] omap_i2c_xfer: Disabled irq 72
[   70.374389] omap_i2c_xfer: Enabled irq 72
[   70.378631] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.384216] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.389801] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.395355] omap_i2c_xfer: Disabled irq 72
[   70.399810] omap_i2c_xfer: Enabled irq 72
[   70.404052] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.409637] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.415222] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.420867] omap_i2c_xfer: Disabled irq 72
[   70.425231] omap_i2c_xfer: Enabled irq 72
[   70.429565] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.435058] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.440643] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.446289] omap_i2c_xfer: Disabled irq 72
[   70.450653] omap_i2c_xfer: Enabled irq 72
[   70.454986] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.460571] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.466094] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.471740] omap_i2c_xfer: Disabled irq 72
[   70.476196] omap_i2c_xfer: Enabled irq 72
[   70.480407] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.485992] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.491607] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.497161] omap_i2c_xfer: Disabled irq 72
[   70.501617] omap_i2c_xfer: Enabled irq 72
[   70.505828] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.511413] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.516998] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.522644] omap_i2c_xfer: Disabled irq 72
[   70.527008] omap_i2c_xfer: Enabled irq 72
[   70.531341] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.536834] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.542449] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.548065] omap_i2c_xfer: Disabled irq 72
[   70.552459] omap_i2c_xfer: Enabled irq 72
[   70.556762] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.562347] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.567871] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.573516] omap_i2c_xfer: Disabled irq 72
[   70.577972] omap_i2c_xfer: Enabled irq 72
[   70.582183] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.587768] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.593383] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.598907] omap_i2c_xfer: Disabled irq 72
[   70.603393] omap_i2c_xfer: Enabled irq 72
[   70.607604] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.613189] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.618774] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.624420] omap_i2c_xfer: Disabled irq 72
[   70.628784] omap_i2c_xfer: Enabled irq 72
[   70.633087] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.638610] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.644195] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.649841] omap_i2c_xfer: Disabled irq 72
[   70.654205] omap_i2c_xfer: Enabled irq 72
[   70.658538] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.664093] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.669647] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.675262] omap_i2c_xfer: Disabled irq 72
[   70.679718] omap_i2c_xfer: Enabled irq 72
[   70.683959] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.689544] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.695129] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.700683] omap_i2c_xfer: Disabled irq 72
[   70.705139] omap_i2c_xfer: Enabled irq 72
[   70.709381] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.714935] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.720550] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.726196] omap_i2c_xfer: Disabled irq 72
[   70.730560] omap_i2c_xfer: Enabled irq 72
[   70.734863] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.740386] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.745971] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.751586] omap_i2c_xfer: Disabled irq 72
[   70.755981] omap_i2c_xfer: Enabled irq 72
[   70.760284] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.765869] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.771392] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.777038] omap_i2c_xfer: Disabled irq 72
[   70.781494] omap_i2c_xfer: Enabled irq 72
[   70.785705] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.791290] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.796905] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.802459] omap_i2c_xfer: Disabled irq 72
[   70.806915] omap_i2c_xfer: Enabled irq 72
[   70.811126] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.816711] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.822296] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.827941] omap_i2c_xfer: Disabled irq 72
[   70.832305] omap_i2c_xfer: Enabled irq 72
[   70.836639] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.842132] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.847747] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.853363] omap_i2c_xfer: Disabled irq 72
[   70.857757] omap_i2c_xfer: Enabled irq 72
[   70.862060] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.867645] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.873168] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.878784] omap_i2c_xfer: Disabled irq 72
[   70.883270] omap_i2c_xfer: Enabled irq 72
[   70.887481] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.893066] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.898681] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.904235] omap_i2c_xfer: Disabled irq 72
[   70.908691] omap_i2c_xfer: Enabled irq 72
[   70.912994] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.918518] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.924102] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.929748] omap_i2c_xfer: Disabled irq 72
[   70.934112] omap_i2c_xfer: Enabled irq 72
[   70.938415] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.943939] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.949523] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.955169] omap_i2c_xfer: Disabled irq 72
[   70.959533] omap_i2c_xfer: Enabled irq 72
[   70.963867] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.969421] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.974975] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.980621] omap_i2c_xfer: Disabled irq 72
[   70.985076] omap_i2c_xfer: Enabled irq 72
[   70.989318] omap_i2c_isr: irq 72, runtime_suspended = 0
[   70.994873] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.000488] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.006042] omap_i2c_xfer: Disabled irq 72
[   71.010498] omap_i2c_xfer: Enabled irq 72
[   71.014801] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.020324] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.025909] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.031555] omap_i2c_xfer: Disabled irq 72
[   71.035919] omap_i2c_xfer: Enabled irq 72
[   71.040252] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.045837] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.051361] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.056976] omap_i2c_xfer: Disabled irq 72
[   71.061431] omap_i2c_xfer: Enabled irq 72
[   71.065673] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.071258] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.076782] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.082397] omap_i2c_xfer: Disabled irq 72
[   71.086883] omap_i2c_xfer: Enabled irq 72
[   71.091094] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.096679] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.102264] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.107818] omap_i2c_xfer: Disabled irq 72
[   71.112274] omap_i2c_xfer: Enabled irq 72
[   71.116607] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.122100] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.127716] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.133361] omap_i2c_xfer: Disabled irq 72
[   71.137725] omap_i2c_xfer: Enabled irq 72
[   71.142059] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.147644] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.153167] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.158782] omap_i2c_xfer: Disabled irq 72
[   71.163238] omap_i2c_xfer: Enabled irq 72
[   71.167480] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.173065] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.178649] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.184204] omap_i2c_xfer: Disabled irq 72
[   71.188690] omap_i2c_xfer: Enabled irq 72
[   71.192901] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.198486] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.204071] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.209625] omap_i2c_xfer: Disabled irq 72
[   71.214111] omap_i2c_xfer: Enabled irq 72
[   71.218414] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.223937] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.229522] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.235137] omap_i2c_xfer: Disabled irq 72
[   71.239532] omap_i2c_xfer: Enabled irq 72
[   71.243835] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.249420] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.254943] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.260589] resume_irqs: resuming irq 94
[   71.264831] resume_irqs: resuming irq 95
[   71.268981] resume_irqs: resuming irq 96
[   71.273223] resume_irqs: resuming irq 97
[   71.277343] resume_irqs: resuming irq 98
[   71.281585] resume_irqs: resuming irq 99
[   71.285705] resume_irqs: resuming irq 100
[   71.290039] resume_irqs: resuming irq 101
[   71.294250] resume_irqs: resuming irq 102
[   71.298583] resume_irqs: resuming irq 103
[   71.302795] resume_irqs: resuming irq 104
[   71.307128] resume_irqs: resuming irq 105
[   71.311492] omap_i2c_xfer: Disabled irq 72
[   71.315887] omap_i2c_xfer: Enabled irq 72
[   71.320220] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.325714] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.331329] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.336975] omap_i2c_xfer: Disabled irq 72
[   71.341369] omap_i2c_xfer: Enabled irq 72
[   71.345672] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.351257] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.356781] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.362426] omap_i2c_xfer: Disabled irq 72
[   71.366882] omap_i2c_xfer: Enabled irq 72
[   71.371093] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.376708] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.382293] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.387847] omap_i2c_xfer: Disabled irq 72
[   71.392303] omap_i2c_xfer: Enabled irq 72
[   71.396545] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.402099] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.407714] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.413330] omap_i2c_xfer: Disabled irq 72
[   71.417724] omap_i2c_xfer: Enabled irq 72
[   71.422027] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.427551] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.433135] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.438781] omap_i2c_xfer: Disabled irq 72
[   71.443145] omap_i2c_xfer: Enabled irq 72
[   71.447479] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.453033] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.458587] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.464202] omap_i2c_xfer: Disabled irq 72
[   71.468658] omap_i2c_xfer: Enabled irq 72
[   71.472900] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.478485] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.484069] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.489624] omap_i2c_xfer: Disabled irq 72
[   71.494079] omap_i2c_xfer: Enabled irq 72
[   71.498321] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.503906] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.509490] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.515136] omap_i2c_xfer: Disabled irq 72
[   71.519500] omap_i2c_xfer: Enabled irq 72
[   71.523834] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.529327] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.534912] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.540557] omap_i2c_xfer: Disabled irq 72
[   71.544921] omap_i2c_xfer: Enabled irq 72
[   71.549255] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.554840] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.560363] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.565979] omap_i2c_xfer: Disabled irq 72
[   71.570465] omap_i2c_xfer: Enabled irq 72
[   71.574676] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.580261] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.585845] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.591430] omap_i2c_xfer: Disabled irq 72
[   71.595855] omap_i2c_xfer: Enabled irq 72
[   71.600097] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.605682] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.611297] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.616912] omap_i2c_xfer: Disabled irq 72
[   71.621307] omap_i2c_xfer: Enabled irq 72
[   71.625610] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.631134] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.636718] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.642364] omap_i2c_xfer: Disabled irq 72
[   71.646728] omap_i2c_xfer: Enabled irq 72
[   71.651031] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.656616] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.662170] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.667785] omap_i2c_xfer: Disabled irq 72
[   71.672241] omap_i2c_xfer: Enabled irq 72
[   71.676483] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.682037] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.687652] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.693206] omap_i2c_xfer: Disabled irq 72
[   71.697662] omap_i2c_xfer: Enabled irq 72
[   71.701873] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.707458] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.713073] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.718688] omap_i2c_xfer: Disabled irq 72
[   71.723052] omap_i2c_xfer: Enabled irq 72
[   71.727386] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.732879] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.738494] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.744110] omap_i2c_xfer: Disabled irq 72
[   71.748504] omap_i2c_xfer: Enabled irq 72
[   71.752807] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.758392] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.763916] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.769561] omap_i2c_xfer: Disabled irq 72
[   71.774017] omap_i2c_xfer: Enabled irq 72
[   71.778228] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.783813] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.789428] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.794982] omap_i2c_xfer: Disabled irq 72
[   71.799438] omap_i2c_xfer: Enabled irq 72
[   71.803741] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.809265] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.814849] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.820465] omap_i2c_xfer: Disabled irq 72
[   71.824859] omap_i2c_xfer: Enabled irq 72
[   71.829193] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.834777] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.840301] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.845916] omap_i2c_xfer: Disabled irq 72
[   71.850402] omap_i2c_xfer: Enabled irq 72
[   71.854614] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.860198] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.865722] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.871337] omap_i2c_xfer: Disabled irq 72
[   71.875793] omap_i2c_xfer: Enabled irq 72
[   71.880035] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.885620] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.891204] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.896759] omap_i2c_xfer: Disabled irq 72
[   71.901214] omap_i2c_xfer: Enabled irq 72
[   71.905548] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.911041] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.916656] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.922271] omap_i2c_xfer: Disabled irq 72
[   71.926666] omap_i2c_xfer: Enabled irq 72
[   71.930969] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.936553] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.942077] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.947723] omap_i2c_xfer: Disabled irq 72
[   71.952178] omap_i2c_xfer: Enabled irq 72
[   71.956420] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.961975] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.967590] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.973144] omap_i2c_xfer: Disabled irq 72
[   71.977600] omap_i2c_xfer: Enabled irq 72
[   71.981811] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.987396] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.993011] omap_i2c_isr: irq 72, runtime_suspended = 0
[   71.998565] omap_i2c_xfer: Disabled irq 72
[   72.003021] omap_i2c_xfer: Enabled irq 72
[   72.007354] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.012847] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.018463] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.024078] omap_i2c_xfer: Disabled irq 72
[   72.028472] omap_i2c_xfer: Enabled irq 72
[   72.032775] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.038360] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.043884] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.049530] omap_i2c_xfer: Disabled irq 72
[   72.053985] omap_i2c_xfer: Enabled irq 72
[   72.058227] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.063781] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.069396] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.074951] omap_i2c_xfer: Disabled irq 72
[   72.079406] omap_i2c_xfer: Enabled irq 72
[   72.083648] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.089202] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.094818] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.100433] omap_i2c_xfer: Disabled irq 72
[   72.104827] omap_i2c_xfer: Enabled irq 72
[   72.109130] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.114654] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.120239] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.125885] omap_i2c_xfer: Disabled irq 72
[   72.130249] omap_i2c_xfer: Enabled irq 72
[   72.134582] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.140136] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.145690] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.151306] omap_i2c_xfer: Disabled irq 72
[   72.155761] omap_i2c_xfer: Enabled irq 72
[   72.160003] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.165557] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.171173] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.176727] omap_i2c_xfer: Disabled irq 72
[   72.181182] omap_i2c_xfer: Enabled irq 72
[   72.185394] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.190979] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.196594] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.202209] omap_i2c_xfer: Disabled irq 72
[   72.206573] omap_i2c_xfer: Enabled irq 72
[   72.210906] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.216400] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.222015] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.227630] omap_i2c_xfer: Disabled irq 72
[   72.232025] omap_i2c_xfer: Enabled irq 72
[   72.236328] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.241912] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.247436] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.253051] omap_i2c_xfer: Disabled irq 72
[   72.257507] omap_i2c_xfer: Enabled irq 72
[   72.261749] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.267333] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.272949] resume_irqs: resuming irq 106
[   72.277191] resume_irqs: resuming irq 107
[   72.281524] resume_irqs: resuming irq 108
[   72.285736] resume_irqs: resuming irq 109
[   72.290069] resume_irqs: resuming irq 110
[   72.294281] resume_irqs: resuming irq 111
[   72.298614] resume_irqs: resuming irq 112
[   72.302825] resume_irqs: resuming irq 113
[   72.307159] resume_irqs: resuming irq 114
[   72.311523] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.317077] omap_i2c_xfer: Disabled irq 72
[   72.321563] omap_i2c_xfer: Enabled irq 72
[   72.325775] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.331359] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.336975] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.342590] omap_i2c_xfer: Disabled irq 72
[   72.346984] omap_i2c_xfer: Enabled irq 72
[   72.351287] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.356811] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.362396] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.368041] omap_i2c_xfer: Disabled irq 72
[   72.372406] omap_i2c_xfer: Enabled irq 72
[   72.376739] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.382293] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.387847] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.393463] omap_i2c_xfer: Disabled irq 72
[   72.397918] omap_i2c_xfer: Enabled irq 72
[   72.402130] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.407714] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.413299] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.418853] omap_i2c_xfer: Disabled irq 72
[   72.423339] omap_i2c_xfer: Enabled irq 72
[   72.427551] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.433135] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.438751] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.444366] omap_i2c_xfer: Disabled irq 72
[   72.448760] omap_i2c_xfer: Enabled irq 72
[   72.453063] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.458557] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.464172] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.469787] omap_i2c_xfer: Disabled irq 72
[   72.474182] omap_i2c_xfer: Enabled irq 72
[   72.478485] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.484069] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.489593] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.495239] omap_i2c_xfer: Disabled irq 72
[   72.499694] omap_i2c_xfer: Enabled irq 72
[   72.503936] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.509490] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.515106] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.520660] omap_i2c_xfer: Disabled irq 72
[   72.525115] omap_i2c_xfer: Enabled irq 72
[   72.529357] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.534942] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.540527] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.546173] omap_i2c_xfer: Disabled irq 72
[   72.550537] omap_i2c_xfer: Enabled irq 72
[   72.554840] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.560363] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.565948] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.571594] omap_i2c_xfer: Disabled irq 72
[   72.575958] omap_i2c_xfer: Enabled irq 72
[   72.580291] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.585876] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.591400] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.597015] omap_i2c_xfer: Disabled irq 72
[   72.601470] omap_i2c_xfer: Enabled irq 72
[   72.605712] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.611297] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.616882] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.622436] omap_i2c_xfer: Disabled irq 72
[   72.626892] omap_i2c_xfer: Enabled irq 72
[   72.631134] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.636718] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.642303] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.647918] omap_i2c_xfer: Disabled irq 72
[   72.652313] omap_i2c_xfer: Enabled irq 72
[   72.656616] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.662139] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.667724] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.673370] omap_i2c_xfer: Disabled irq 72
[   72.677734] omap_i2c_xfer: Enabled irq 72
[   72.682067] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.687622] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.693176] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.698791] omap_i2c_xfer: Disabled irq 72
[   72.703247] omap_i2c_xfer: Enabled irq 72
[   72.707489] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.713073] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.718658] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.724212] omap_i2c_xfer: Disabled irq 72
[   72.728668] omap_i2c_xfer: Enabled irq 72
[   72.732910] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.738494] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.744079] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.749725] omap_i2c_xfer: Disabled irq 72
[   72.754089] omap_i2c_xfer: Enabled irq 72
[   72.758422] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.763916] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.769531] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.775146] omap_i2c_xfer: Disabled irq 72
[   72.779510] omap_i2c_xfer: Enabled irq 72
[   72.783843] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.789428] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.794952] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.800567] omap_i2c_xfer: Disabled irq 72
[   72.805023] omap_i2c_xfer: Enabled irq 72
[   72.809265] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.814849] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.820434] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.825988] omap_i2c_xfer: Disabled irq 72
[   72.830444] omap_i2c_xfer: Enabled irq 72
[   72.834777] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.840270] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.845886] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.851501] omap_i2c_xfer: Disabled irq 72
[   72.855865] omap_i2c_xfer: Enabled irq 72
[   72.860198] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.865692] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.871307] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.876922] omap_i2c_xfer: Disabled irq 72
[   72.881317] omap_i2c_xfer: Enabled irq 72
[   72.885620] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.891204] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.896728] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.902343] omap_i2c_xfer: Disabled irq 72
[   72.906799] omap_i2c_xfer: Enabled irq 72
[   72.911041] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.916595] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.922210] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.927764] omap_i2c_xfer: Disabled irq 72
[   72.932220] omap_i2c_xfer: Enabled irq 72
[   72.936523] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.942047] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.947631] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.953247] omap_i2c_xfer: Disabled irq 72
[   72.957641] omap_i2c_xfer: Enabled irq 72
[   72.961944] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.967468] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.973052] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.978698] omap_i2c_xfer: Disabled irq 72
[   72.983062] omap_i2c_xfer: Enabled irq 72
[   72.987396] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.992980] omap_i2c_isr: irq 72, runtime_suspended = 0
[   72.998504] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.004119] omap_i2c_xfer: Disabled irq 72
[   73.008575] omap_i2c_xfer: Enabled irq 72
[   73.012817] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.018402] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.023986] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.029541] omap_i2c_xfer: Disabled irq 72
[   73.034027] omap_i2c_xfer: Enabled irq 72
[   73.038330] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.043853] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.049438] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.055053] omap_i2c_xfer: Disabled irq 72
[   73.059448] omap_i2c_xfer: Enabled irq 72
[   73.063751] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.069335] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.074890] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.080505] omap_i2c_xfer: Disabled irq 72
[   73.084960] omap_i2c_xfer: Enabled irq 72
[   73.089202] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.094757] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.100372] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.105926] omap_i2c_xfer: Disabled irq 72
[   73.110412] omap_i2c_xfer: Enabled irq 72
[   73.114624] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.120208] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.125823] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.131347] omap_i2c_xfer: Disabled irq 72
[   73.135803] omap_i2c_xfer: Enabled irq 72
[   73.140136] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.145629] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.151245] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.156860] omap_i2c_xfer: Disabled irq 72
[   73.161254] omap_i2c_xfer: Enabled irq 72
[   73.165557] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.171142] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.176666] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.182312] omap_i2c_xfer: Disabled irq 72
[   73.186767] omap_i2c_xfer: Enabled irq 72
[   73.190979] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.196563] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.202178] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.207733] omap_i2c_xfer: Disabled irq 72
[   73.212188] omap_i2c_xfer: Enabled irq 72
[   73.216430] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.221984] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.227600] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.233215] omap_i2c_xfer: Disabled irq 72
[   73.237609] omap_i2c_xfer: Enabled irq 72
[   73.241912] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.247406] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.253051] resume_irqs: resuming irq 115
[   73.257385] resume_irqs: resuming irq 116
[   73.261627] resume_irqs: resuming irq 117
[   73.265930] resume_irqs: resuming irq 118
[   73.270172] resume_irqs: resuming irq 119
[   73.274475] resume_irqs: resuming irq 120
[   73.278717] resume_irqs: resuming irq 121
[   73.283020] resume_irqs: resuming irq 122
[   73.287261] resume_irqs: resuming irq 123
[   73.291564] resume_irqs: resuming irq 124
[   73.295898] resume_irqs: resuming irq 125
[   73.300109] resume_irqs: resuming irq 126
[   73.304443] resume_irqs: resuming irq 127
[   73.308654] resume_irqs: resuming irq 128
[   73.313018] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.318572] omap_i2c_xfer: Disabled irq 72
[   73.323059] omap_i2c_xfer: Enabled irq 72
[   73.327392] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.332885] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.338500] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.344116] omap_i2c_xfer: Disabled irq 72
[   73.348510] omap_i2c_xfer: Enabled irq 72
[   73.352813] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.358398] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.363922] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.369567] omap_i2c_xfer: Disabled irq 72
[   73.374023] omap_i2c_xfer: Enabled irq 72
[   73.378265] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.383819] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.389434] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.394989] omap_i2c_xfer: Disabled irq 72
[   73.399444] omap_i2c_xfer: Enabled irq 72
[   73.403686] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.409271] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.414855] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.420410] omap_i2c_xfer: Disabled irq 72
[   73.424865] omap_i2c_xfer: Enabled irq 72
[   73.429199] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.434692] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.440307] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.445922] omap_i2c_xfer: Disabled irq 72
[   73.450317] omap_i2c_xfer: Enabled irq 72
[   73.454620] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.460205] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.465759] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.471374] omap_i2c_xfer: Disabled irq 72
[   73.475830] omap_i2c_xfer: Enabled irq 72
[   73.480041] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.485626] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.491241] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.496795] omap_i2c_xfer: Disabled irq 72
[   73.501251] omap_i2c_xfer: Enabled irq 72
[   73.505462] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.511047] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.516632] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.522277] omap_i2c_xfer: Disabled irq 72
[   73.526672] omap_i2c_xfer: Enabled irq 72
[   73.530975] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.536499] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.542083] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.547729] omap_i2c_xfer: Disabled irq 72
[   73.552093] omap_i2c_xfer: Enabled irq 72
[   73.556427] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.561981] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.567535] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.573150] omap_i2c_xfer: Disabled irq 72
[   73.577606] omap_i2c_xfer: Enabled irq 72
[   73.581848] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.587402] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.593017] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.598571] omap_i2c_xfer: Disabled irq 72
[   73.603027] omap_i2c_xfer: Enabled irq 72
[   73.607269] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.612823] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.618438] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.624084] omap_i2c_xfer: Disabled irq 72
[   73.628448] omap_i2c_xfer: Enabled irq 72
[   73.632751] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.638275] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.643859] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.649505] omap_i2c_xfer: Disabled irq 72
[   73.653869] omap_i2c_xfer: Enabled irq 72
[   73.658203] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.663757] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.669311] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.674926] omap_i2c_xfer: Disabled irq 72
[   73.679412] omap_i2c_xfer: Enabled irq 72
[   73.683624] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.689208] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.694793] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.700347] omap_i2c_xfer: Disabled irq 72
[   73.704803] omap_i2c_xfer: Enabled irq 72
[   73.709045] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.714630] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.720214] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.725860] omap_i2c_xfer: Disabled irq 72
[   73.730224] omap_i2c_xfer: Enabled irq 72
[   73.734558] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.740051] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.745666] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.751281] omap_i2c_xfer: Disabled irq 72
[   73.755645] omap_i2c_xfer: Enabled irq 72
[   73.759979] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.765563] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.771087] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.776702] omap_i2c_xfer: Disabled irq 72
[   73.781158] omap_i2c_xfer: Enabled irq 72
[   73.785400] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.790985] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.796569] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.802124] omap_i2c_xfer: Disabled irq 72
[   73.806579] omap_i2c_xfer: Enabled irq 72
[   73.810821] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.816406] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.821990] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.827636] omap_i2c_xfer: Disabled irq 72
[   73.832000] omap_i2c_xfer: Enabled irq 72
[   73.836303] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.841827] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.847412] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.853057] omap_i2c_xfer: Disabled irq 72
[   73.857421] omap_i2c_xfer: Enabled irq 72
[   73.861755] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.867309] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.872863] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.878479] omap_i2c_xfer: Disabled irq 72
[   73.882934] omap_i2c_xfer: Enabled irq 72
[   73.887176] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.892761] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.898345] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.903900] omap_i2c_xfer: Disabled irq 72
[   73.908386] omap_i2c_xfer: Enabled irq 72
[   73.912597] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.918182] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.923767] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.929412] omap_i2c_xfer: Disabled irq 72
[   73.933776] omap_i2c_xfer: Enabled irq 72
[   73.938110] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.943603] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.949218] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.954833] omap_i2c_xfer: Disabled irq 72
[   73.959197] omap_i2c_xfer: Enabled irq 72
[   73.963531] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.969116] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.974639] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.980255] omap_i2c_xfer: Disabled irq 72
[   73.984710] omap_i2c_xfer: Enabled irq 72
[   73.988952] omap_i2c_isr: irq 72, runtime_suspended = 0
[   73.994537] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.000122] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.005676] omap_i2c_xfer: Disabled irq 72
[   74.010131] omap_i2c_xfer: Enabled irq 72
[   74.014465] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.019958] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.025573] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.031188] omap_i2c_xfer: Disabled irq 72
[   74.035583] omap_i2c_xfer: Enabled irq 72
[   74.039886] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.045410] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.050994] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.056640] omap_i2c_xfer: Disabled irq 72
[   74.061004] omap_i2c_xfer: Enabled irq 72
[   74.065338] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.070892] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.076446] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.082061] omap_i2c_xfer: Disabled irq 72
[   74.086517] omap_i2c_xfer: Enabled irq 72
[   74.090759] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.096313] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.101928] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.107482] omap_i2c_xfer: Disabled irq 72
[   74.111938] omap_i2c_xfer: Enabled irq 72
[   74.116241] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.121765] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.127380] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.132995] omap_i2c_xfer: Disabled irq 72
[   74.137359] omap_i2c_xfer: Enabled irq 72
[   74.141693] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.147277] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.152801] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.158416] omap_i2c_xfer: Disabled irq 72
[   74.162872] omap_i2c_xfer: Enabled irq 72
[   74.167114] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.172698] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.178222] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.183868] omap_i2c_xfer: Disabled irq 72
[   74.188323] omap_i2c_xfer: Enabled irq 72
[   74.192535] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.198120] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.203735] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.209289] omap_i2c_xfer: Disabled irq 72
[   74.213745] omap_i2c_xfer: Enabled irq 72
[   74.218048] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.223571] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.229156] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.234771] omap_i2c_xfer: Disabled irq 72
[   74.239166] omap_i2c_xfer: Enabled irq 72
[   74.243469] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.249053] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.254577] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.260223] resume_irqs: resuming irq 129
[   74.264556] resume_irqs: resuming irq 130
[   74.268798] resume_irqs: resuming irq 131
[   74.273101] resume_irqs: resuming irq 132
[   74.277343] resume_irqs: resuming irq 133
[   74.281646] resume_irqs: resuming irq 134
[   74.285888] resume_irqs: resuming irq 135
[   74.290191] resume_irqs: resuming irq 136
[   74.294433] resume_irqs: resuming irq 137
[   74.298736] resume_irqs: resuming irq 138
[   74.302978] resume_irqs: resuming irq 139
[   74.307281] resume_irqs: resuming irq 140
[   74.311676] omap_i2c_xfer: Disabled irq 72
[   74.316070] omap_i2c_xfer: Enabled irq 72
[   74.320373] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.325897] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.331481] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.337158] omap_i2c_xfer: Disabled irq 72
[   74.341522] omap_i2c_xfer: Enabled irq 72
[   74.345855] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.351440] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.356964] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.362579] omap_i2c_xfer: Disabled irq 72
[   74.367065] omap_i2c_xfer: Enabled irq 72
[   74.371276] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.376861] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.382476] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.388031] omap_i2c_xfer: Disabled irq 72
[   74.392486] omap_i2c_xfer: Enabled irq 72
[   74.396728] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.402313] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.407897] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.413543] omap_i2c_xfer: Disabled irq 72
[   74.417907] omap_i2c_xfer: Enabled irq 72
[   74.422241] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.427734] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.433319] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.438964] omap_i2c_xfer: Disabled irq 72
[   74.443328] omap_i2c_xfer: Enabled irq 72
[   74.447662] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.453216] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.458770] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.464385] omap_i2c_xfer: Disabled irq 72
[   74.468841] omap_i2c_xfer: Enabled irq 72
[   74.473083] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.478637] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.484252] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.489807] omap_i2c_xfer: Disabled irq 72
[   74.494262] omap_i2c_xfer: Enabled irq 72
[   74.498504] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.504058] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.509674] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.515289] omap_i2c_xfer: Disabled irq 72
[   74.519683] omap_i2c_xfer: Enabled irq 72
[   74.523986] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.529510] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.535095] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.540740] omap_i2c_xfer: Disabled irq 72
[   74.545104] omap_i2c_xfer: Enabled irq 72
[   74.549407] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.554992] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.560516] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.566162] omap_i2c_xfer: Disabled irq 72
[   74.570617] omap_i2c_xfer: Enabled irq 72
[   74.574859] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.580413] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.586029] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.591583] omap_i2c_xfer: Disabled irq 72
[   74.596038] omap_i2c_xfer: Enabled irq 72
[   74.600250] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.605834] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.611450] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.617065] omap_i2c_xfer: Disabled irq 72
[   74.621459] omap_i2c_xfer: Enabled irq 72
[   74.625793] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.631286] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.636871] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.642517] omap_i2c_xfer: Disabled irq 72
[   74.646881] omap_i2c_xfer: Enabled irq 72
[   74.651214] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.656799] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.662322] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.667938] omap_i2c_xfer: Disabled irq 72
[   74.672393] omap_i2c_xfer: Enabled irq 72
[   74.676635] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.682220] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.687805] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.693359] omap_i2c_xfer: Disabled irq 72
[   74.697814] omap_i2c_xfer: Enabled irq 72
[   74.702148] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.707641] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.713256] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.718872] omap_i2c_xfer: Disabled irq 72
[   74.723266] omap_i2c_xfer: Enabled irq 72
[   74.727569] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.733093] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.738677] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.744293] omap_i2c_xfer: Disabled irq 72
[   74.748687] omap_i2c_xfer: Enabled irq 72
[   74.752990] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.758575] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.764099] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.769744] omap_i2c_xfer: Disabled irq 72
[   74.774200] omap_i2c_xfer: Enabled irq 72
[   74.778411] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.783996] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.789611] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.795166] omap_i2c_xfer: Disabled irq 72
[   74.799621] omap_i2c_xfer: Enabled irq 72
[   74.803924] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.809448] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.815032] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.820678] omap_i2c_xfer: Disabled irq 72
[   74.825042] omap_i2c_xfer: Enabled irq 72
[   74.829376] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.834960] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.840484] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.846130] omap_i2c_xfer: Disabled irq 72
[   74.850585] omap_i2c_xfer: Enabled irq 72
[   74.854797] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.860382] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.865905] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.871551] omap_i2c_xfer: Disabled irq 72
[   74.876007] omap_i2c_xfer: Enabled irq 72
[   74.880218] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.885803] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.891418] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.896942] omap_i2c_xfer: Disabled irq 72
[   74.901428] omap_i2c_xfer: Enabled irq 72
[   74.905731] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.911224] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.916839] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.922454] omap_i2c_xfer: Disabled irq 72
[   74.926849] omap_i2c_xfer: Enabled irq 72
[   74.931152] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.936737] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.942260] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.947875] omap_i2c_xfer: Disabled irq 72
[   74.952331] omap_i2c_xfer: Enabled irq 72
[   74.956573] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.962158] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.967742] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.973297] omap_i2c_xfer: Disabled irq 72
[   74.977752] omap_i2c_xfer: Enabled irq 72
[   74.981994] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.987579] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.993164] omap_i2c_isr: irq 72, runtime_suspended = 0
[   74.998718] omap_i2c_xfer: Disabled irq 72
[   75.003173] omap_i2c_xfer: Enabled irq 72
[   75.007507] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.013000] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.018615] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.024230] omap_i2c_xfer: Disabled irq 72
[   75.028625] omap_i2c_xfer: Enabled irq 72
[   75.032928] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.038513] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.044036] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.049682] omap_i2c_xfer: Disabled irq 72
[   75.054138] omap_i2c_xfer: Enabled irq 72
[   75.058380] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.063934] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.069549] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.075103] omap_i2c_xfer: Disabled irq 72
[   75.079559] omap_i2c_xfer: Enabled irq 72
[   75.083801] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.089385] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.094970] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.100616] omap_i2c_xfer: Disabled irq 72
[   75.104980] omap_i2c_xfer: Enabled irq 72
[   75.109283] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.114807] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.120391] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.126037] omap_i2c_xfer: Disabled irq 72
[   75.130401] omap_i2c_xfer: Enabled irq 72
[   75.134735] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.140289] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.145812] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.151458] omap_i2c_xfer: Disabled irq 72
[   75.155914] omap_i2c_xfer: Enabled irq 72
[   75.160125] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.165710] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.171295] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.176849] omap_i2c_xfer: Disabled irq 72
[   75.181304] omap_i2c_xfer: Enabled irq 72
[   75.185546] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.191131] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.196716] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.202362] omap_i2c_xfer: Disabled irq 72
[   75.206726] omap_i2c_xfer: Enabled irq 72
[   75.211059] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.216552] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.222167] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.227783] omap_i2c_xfer: Disabled irq 72
[   75.232147] omap_i2c_xfer: Enabled irq 72
[   75.236480] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.242034] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.247589] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.253204] omap_i2c_xfer: Disabled irq 72
[   75.257659] omap_i2c_xfer: Enabled irq 72
[   75.261901] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.267456] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.273101] resume_irqs: resuming irq 141
[   75.277313] resume_irqs: resuming irq 142
[   75.281646] resume_irqs: resuming irq 143
[   75.285888] resume_irqs: resuming irq 144
[   75.290191] resume_irqs: resuming irq 145
[   75.294433] resume_irqs: resuming irq 146
[   75.298767] resume_irqs: resuming irq 147
[   75.302978] resume_irqs: resuming irq 148
[   75.307312] resume_irqs: resuming irq 149
[   75.311676] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.317230] omap_i2c_xfer: Disabled irq 72
[   75.321685] omap_i2c_xfer: Enabled irq 72
[   75.325927] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.331512] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.337097] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.342742] omap_i2c_xfer: Disabled irq 72
[   75.347106] omap_i2c_xfer: Enabled irq 72
[   75.351440] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.356933] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.362548] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.368164] omap_i2c_xfer: Disabled irq 72
[   75.372528] omap_i2c_xfer: Enabled irq 72
[   75.376861] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.382446] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.387969] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.393585] omap_i2c_xfer: Disabled irq 72
[   75.398040] omap_i2c_xfer: Enabled irq 72
[   75.402282] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.407867] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.413482] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.419006] omap_i2c_xfer: Disabled irq 72
[   75.423461] omap_i2c_xfer: Enabled irq 72
[   75.427703] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.433288] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.438873] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.444519] omap_i2c_xfer: Disabled irq 72
[   75.448883] omap_i2c_xfer: Enabled irq 72
[   75.453186] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.458709] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.464294] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.469940] omap_i2c_xfer: Disabled irq 72
[   75.474304] omap_i2c_xfer: Enabled irq 72
[   75.478637] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.484191] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.489746] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.495361] omap_i2c_xfer: Disabled irq 72
[   75.499816] omap_i2c_xfer: Enabled irq 72
[   75.504058] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.509643] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.515228] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.520812] omap_i2c_xfer: Disabled irq 72
[   75.525268] omap_i2c_xfer: Enabled irq 72
[   75.529479] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.535064] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.540679] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.546295] omap_i2c_xfer: Disabled irq 72
[   75.550689] omap_i2c_xfer: Enabled irq 72
[   75.554992] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.560516] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.566101] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.571746] omap_i2c_xfer: Disabled irq 72
[   75.576110] omap_i2c_xfer: Enabled irq 72
[   75.580413] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.585998] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.591552] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.597167] omap_i2c_xfer: Disabled irq 72
[   75.601623] omap_i2c_xfer: Enabled irq 72
[   75.605865] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.611450] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.617034] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.622589] omap_i2c_xfer: Disabled irq 72
[   75.627044] omap_i2c_xfer: Enabled irq 72
[   75.631286] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.636871] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.642456] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.648101] omap_i2c_xfer: Disabled irq 72
[   75.652465] omap_i2c_xfer: Enabled irq 72
[   75.656799] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.662292] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.667877] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.673522] omap_i2c_xfer: Disabled irq 72
[   75.677886] omap_i2c_xfer: Enabled irq 72
[   75.682189] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.687774] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.693328] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.698944] omap_i2c_xfer: Disabled irq 72
[   75.703399] omap_i2c_xfer: Enabled irq 72
[   75.707641] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.713195] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.718811] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.724365] omap_i2c_xfer: Disabled irq 72
[   75.728820] omap_i2c_xfer: Enabled irq 72
[   75.733062] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.738616] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.744232] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.749877] omap_i2c_xfer: Disabled irq 72
[   75.754241] omap_i2c_xfer: Enabled irq 72
[   75.758575] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.764068] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.769683] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.775299] omap_i2c_xfer: Disabled irq 72
[   75.779693] omap_i2c_xfer: Enabled irq 72
[   75.783996] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.789581] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.795104] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.800720] omap_i2c_xfer: Disabled irq 72
[   75.805206] omap_i2c_xfer: Enabled irq 72
[   75.809417] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.815002] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.820617] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.826171] omap_i2c_xfer: Disabled irq 72
[   75.830627] omap_i2c_xfer: Enabled irq 72
[   75.834930] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.840423] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.846038] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.851654] omap_i2c_xfer: Disabled irq 72
[   75.856048] omap_i2c_xfer: Enabled irq 72
[   75.860351] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.865875] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.871459] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.877105] omap_i2c_xfer: Disabled irq 72
[   75.881469] omap_i2c_xfer: Enabled irq 72
[   75.885772] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.891357] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.896911] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.902526] omap_i2c_xfer: Disabled irq 72
[   75.906982] omap_i2c_xfer: Enabled irq 72
[   75.911193] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.916778] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.922393] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.927947] omap_i2c_xfer: Disabled irq 72
[   75.932403] omap_i2c_xfer: Enabled irq 72
[   75.936706] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.942230] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.947814] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.953430] omap_i2c_xfer: Disabled irq 72
[   75.957824] omap_i2c_xfer: Enabled irq 72
[   75.962127] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.967712] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.973236] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.978881] omap_i2c_xfer: Disabled irq 72
[   75.983337] omap_i2c_xfer: Enabled irq 72
[   75.987579] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.993133] omap_i2c_isr: irq 72, runtime_suspended = 0
[   75.998687] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.004302] omap_i2c_xfer: Disabled irq 72
[   76.008758] omap_i2c_xfer: Enabled irq 72
[   76.013000] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.018585] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.024169] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.029724] omap_i2c_xfer: Disabled irq 72
[   76.034179] omap_i2c_xfer: Enabled irq 72
[   76.038513] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.044006] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.049621] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.055236] omap_i2c_xfer: Disabled irq 72
[   76.059631] omap_i2c_xfer: Enabled irq 72
[   76.063934] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.069519] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.075042] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.080657] omap_i2c_xfer: Disabled irq 72
[   76.085113] omap_i2c_xfer: Enabled irq 72
[   76.089355] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.094940] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.100524] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.106079] omap_i2c_xfer: Disabled irq 72
[   76.110534] omap_i2c_xfer: Enabled irq 72
[   76.114776] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.120361] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.125946] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.131500] omap_i2c_xfer: Disabled irq 72
[   76.135955] omap_i2c_xfer: Enabled irq 72
[   76.140289] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.145782] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.151367] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.157012] omap_i2c_xfer: Disabled irq 72
[   76.161376] omap_i2c_xfer: Enabled irq 72
[   76.165710] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.171295] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.176818] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.182434] omap_i2c_xfer: Disabled irq 72
[   76.186889] omap_i2c_xfer: Enabled irq 72
[   76.191131] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.196716] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.202331] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.207885] omap_i2c_xfer: Disabled irq 72
[   76.212341] omap_i2c_xfer: Enabled irq 72
[   76.216583] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.222137] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.227752] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.233367] omap_i2c_xfer: Disabled irq 72
[   76.237762] omap_i2c_xfer: Enabled irq 72
[   76.242065] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.247589] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.253204] resume_irqs: resuming irq 150
[   76.257537] resume_irqs: resuming irq 151
[   76.261749] resume_irqs: resuming irq 152
[   76.266082] resume_irqs: resuming irq 153
[   76.270324] resume_irqs: resuming irq 154
[   76.274627] resume_irqs: resuming irq 155
[   76.278869] resume_irqs: resuming irq 156
[   76.283172] resume_irqs: resuming irq 157
[   76.287414] resume_irqs: resuming irq 158
[   76.291717] resume_irqs: resuming irq 159
[   76.296051] resume_irqs: resuming irq 160
[   76.300262] resume_irqs: resuming irq 161
[   76.304595] resume_irqs: resuming irq 162
[   76.308837] resume_irqs: resuming irq 163
[   76.313201] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.318756] omap_i2c_xfer: Disabled irq 72
[   76.323211] omap_i2c_xfer: Enabled irq 72
[   76.327545] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.333038] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.338653] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.344268] omap_i2c_xfer: Disabled irq 72
[   76.348663] omap_i2c_xfer: Enabled irq 72
[   76.352966] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.358551] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.364074] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.369720] omap_i2c_xfer: Disabled irq 72
[   76.374176] omap_i2c_xfer: Enabled irq 72
[   76.378387] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.383972] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.389587] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.395111] omap_i2c_xfer: Disabled irq 72
[   76.399566] omap_i2c_xfer: Enabled irq 72
[   76.403808] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.409393] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.415008] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.420532] omap_i2c_xfer: Disabled irq 72
[   76.424987] omap_i2c_xfer: Enabled irq 72
[   76.429321] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.434814] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.440429] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.446044] omap_i2c_xfer: Disabled irq 72
[   76.450439] omap_i2c_xfer: Enabled irq 72
[   76.454772] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.460357] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.465881] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.471496] omap_i2c_xfer: Disabled irq 72
[   76.475952] omap_i2c_xfer: Enabled irq 72
[   76.480194] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.485778] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.491363] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.496948] omap_i2c_xfer: Disabled irq 72
[   76.501403] omap_i2c_xfer: Enabled irq 72
[   76.505645] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.511230] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.516845] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.522460] omap_i2c_xfer: Disabled irq 72
[   76.526855] omap_i2c_xfer: Enabled irq 72
[   76.531158] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.536682] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.542266] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.547882] omap_i2c_xfer: Disabled irq 72
[   76.552276] omap_i2c_xfer: Enabled irq 72
[   76.556579] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.562164] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.567718] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.573333] omap_i2c_xfer: Disabled irq 72
[   76.577789] omap_i2c_xfer: Enabled irq 72
[   76.582000] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.587585] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.593200] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.598754] omap_i2c_xfer: Disabled irq 72
[   76.603210] omap_i2c_xfer: Enabled irq 72
[   76.607421] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.613006] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.618621] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.624237] omap_i2c_xfer: Disabled irq 72
[   76.628631] omap_i2c_xfer: Enabled irq 72
[   76.632934] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.638458] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.644042] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.649658] omap_i2c_xfer: Disabled irq 72
[   76.654052] omap_i2c_xfer: Enabled irq 72
[   76.658355] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.663940] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.669464] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.675109] omap_i2c_xfer: Disabled irq 72
[   76.679565] omap_i2c_xfer: Enabled irq 72
[   76.683807] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.689361] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.694976] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.700531] omap_i2c_xfer: Disabled irq 72
[   76.704986] omap_i2c_xfer: Enabled irq 72
[   76.709197] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.714782] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.720397] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.726013] omap_i2c_xfer: Disabled irq 72
[   76.730377] omap_i2c_xfer: Enabled irq 72
[   76.734710] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.740234] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.745819] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.751434] omap_i2c_xfer: Disabled irq 72
[   76.755828] omap_i2c_xfer: Enabled irq 72
[   76.760131] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.765716] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.771240] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.776885] omap_i2c_xfer: Disabled irq 72
[   76.781341] omap_i2c_xfer: Enabled irq 72
[   76.785583] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.791137] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.796752] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.802307] omap_i2c_xfer: Disabled irq 72
[   76.806762] omap_i2c_xfer: Enabled irq 72
[   76.811004] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.816558] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.822174] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.827789] omap_i2c_xfer: Disabled irq 72
[   76.832183] omap_i2c_xfer: Enabled irq 72
[   76.836486] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.842010] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.847595] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.853240] omap_i2c_xfer: Disabled irq 72
[   76.857604] omap_i2c_xfer: Enabled irq 72
[   76.861907] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.867492] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.873046] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.878662] omap_i2c_xfer: Disabled irq 72
[   76.883117] omap_i2c_xfer: Enabled irq 72
[   76.887359] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.892913] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.898529] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.904083] omap_i2c_xfer: Disabled irq 72
[   76.908538] omap_i2c_xfer: Enabled irq 72
[   76.912780] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.918334] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.923950] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.929565] omap_i2c_xfer: Disabled irq 72
[   76.933959] omap_i2c_xfer: Enabled irq 72
[   76.938262] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.943786] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.949371] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.954986] omap_i2c_xfer: Disabled irq 72
[   76.959381] omap_i2c_xfer: Enabled irq 72
[   76.963684] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.969268] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.977142] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.982727] omap_i2c_xfer: Disabled irq 72
[   76.987213] omap_i2c_xfer: Enabled irq 72
[   76.991516] omap_i2c_isr: irq 72, runtime_suspended = 0
[   76.997039] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.002624] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.008270] omap_i2c_xfer: Disabled irq 72
[   77.012664] omap_i2c_xfer: Enabled irq 72
[   77.016967] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.022552] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.028076] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.033721] omap_i2c_xfer: Disabled irq 72
[   77.038177] omap_i2c_xfer: Enabled irq 72
[   77.042419] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.047973] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.053588] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.059143] omap_i2c_xfer: Disabled irq 72
[   77.063598] omap_i2c_xfer: Enabled irq 72
[   77.067840] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.073394] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.079010] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.084564] omap_i2c_xfer: Disabled irq 72
[   77.089019] omap_i2c_xfer: Enabled irq 72
[   77.093322] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.098846] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.104431] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.110076] omap_i2c_xfer: Disabled irq 72
[   77.114440] omap_i2c_xfer: Enabled irq 72
[   77.118774] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.124359] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.129882] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.135528] omap_i2c_xfer: Disabled irq 72
[   77.139984] omap_i2c_xfer: Enabled irq 72
[   77.144195] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.149780] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.155395] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.160949] omap_i2c_xfer: Disabled irq 72
[   77.165405] omap_i2c_xfer: Enabled irq 72
[   77.169616] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.175201] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.180816] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.186431] omap_i2c_xfer: Disabled irq 72
[   77.190795] omap_i2c_xfer: Enabled irq 72
[   77.195129] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.200622] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.206237] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.211853] omap_i2c_xfer: Disabled irq 72
[   77.216247] omap_i2c_xfer: Enabled irq 72
[   77.220550] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.226135] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.231658] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.237304] omap_i2c_xfer: Disabled irq 72
[   77.241760] omap_i2c_xfer: Enabled irq 72
[   77.245971] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.251556] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.257232] resume_irqs: resuming irq 164
[   77.261444] resume_irqs: resuming irq 165
[   77.265777] resume_irqs: resuming irq 166
[   77.270019] resume_irqs: resuming irq 167
[   77.274322] resume_irqs: resuming irq 168
[   77.278564] resume_irqs: resuming irq 169
[   77.282867] resume_irqs: resuming irq 170
[   77.287109] resume_irqs: resuming irq 171
[   77.291412] resume_irqs: resuming irq 172
[   77.295745] resume_irqs: resuming irq 173
[   77.299957] resume_irqs: resuming irq 174
[   77.304290] resume_irqs: resuming irq 175
[   77.308502] resume_irqs: resuming irq 176
[   77.312866] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.318420] omap_i2c_xfer: Disabled irq 72
[   77.322906] omap_i2c_xfer: Enabled irq 72
[   77.327209] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.332733] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.338348] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.343963] omap_i2c_xfer: Disabled irq 72
[   77.348358] omap_i2c_xfer: Enabled irq 72
[   77.352691] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.358245] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.363800] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.369415] omap_i2c_xfer: Disabled irq 72
[   77.373870] omap_i2c_xfer: Enabled irq 72
[   77.378112] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.383697] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.389221] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.394866] omap_i2c_xfer: Disabled irq 72
[   77.399322] omap_i2c_xfer: Enabled irq 72
[   77.403564] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.409149] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.414733] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.420288] omap_i2c_xfer: Disabled irq 72
[   77.424743] omap_i2c_xfer: Enabled irq 72
[   77.429077] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.434570] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.440185] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.445800] omap_i2c_xfer: Disabled irq 72
[   77.450195] omap_i2c_xfer: Enabled irq 72
[   77.454498] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.460083] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.465606] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.471252] omap_i2c_xfer: Disabled irq 72
[   77.475708] omap_i2c_xfer: Enabled irq 72
[   77.479919] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.485504] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.491088] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.496643] omap_i2c_xfer: Disabled irq 72
[   77.501098] omap_i2c_xfer: Enabled irq 72
[   77.505340] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.510925] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.516510] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.522064] omap_i2c_xfer: Disabled irq 72
[   77.526550] omap_i2c_xfer: Enabled irq 72
[   77.530853] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.536346] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.541961] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.547576] omap_i2c_xfer: Disabled irq 72
[   77.551971] omap_i2c_xfer: Enabled irq 72
[   77.556274] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.561859] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.567413] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.573028] omap_i2c_xfer: Disabled irq 72
[   77.577484] omap_i2c_xfer: Enabled irq 72
[   77.581695] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.587280] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.592895] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.598449] omap_i2c_xfer: Disabled irq 72
[   77.602905] omap_i2c_xfer: Enabled irq 72
[   77.607147] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.612701] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.618316] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.623931] omap_i2c_xfer: Disabled irq 72
[   77.628326] omap_i2c_xfer: Enabled irq 72
[   77.632629] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.638153] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.643737] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.649383] omap_i2c_xfer: Disabled irq 72
[   77.653747] omap_i2c_xfer: Enabled irq 72
[   77.658081] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.663635] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.669189] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.674804] omap_i2c_xfer: Disabled irq 72
[   77.679260] omap_i2c_xfer: Enabled irq 72
[   77.683502] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.689086] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.694671] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.700225] omap_i2c_xfer: Disabled irq 72
[   77.704681] omap_i2c_xfer: Enabled irq 72
[   77.708923] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.714477] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.720092] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.725738] omap_i2c_xfer: Disabled irq 72
[   77.730102] omap_i2c_xfer: Enabled irq 72
[   77.734405] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.739929] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.745544] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.751159] omap_i2c_xfer: Disabled irq 72
[   77.755523] omap_i2c_xfer: Enabled irq 72
[   77.759857] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.765411] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.770965] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.776580] omap_i2c_xfer: Disabled irq 72
[   77.781036] omap_i2c_xfer: Enabled irq 72
[   77.785278] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.790832] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.796447] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.802001] omap_i2c_xfer: Disabled irq 72
[   77.806457] omap_i2c_xfer: Enabled irq 72
[   77.810668] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.816253] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.821838] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.827484] omap_i2c_xfer: Disabled irq 72
[   77.831878] omap_i2c_xfer: Enabled irq 72
[   77.836181] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.841705] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.847290] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.852905] omap_i2c_xfer: Disabled irq 72
[   77.857299] omap_i2c_xfer: Enabled irq 72
[   77.861602] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.867187] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.872741] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.878356] omap_i2c_xfer: Disabled irq 72
[   77.882812] omap_i2c_xfer: Enabled irq 72
[   77.887023] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.892608] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.898193] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.903747] omap_i2c_xfer: Disabled irq 72
[   77.908203] omap_i2c_xfer: Enabled irq 72
[   77.912445] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.918029] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.923614] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.929260] omap_i2c_xfer: Disabled irq 72
[   77.933624] omap_i2c_xfer: Enabled irq 72
[   77.937957] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.943450] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.949035] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.954681] omap_i2c_xfer: Disabled irq 72
[   77.959045] omap_i2c_xfer: Enabled irq 72
[   77.963378] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.968933] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.974487] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.980102] omap_i2c_xfer: Disabled irq 72
[   77.984558] omap_i2c_xfer: Enabled irq 72
[   77.988800] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.994354] omap_i2c_isr: irq 72, runtime_suspended = 0
[   77.999969] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.005523] omap_i2c_xfer: Disabled irq 72
[   78.009979] omap_i2c_xfer: Enabled irq 72
[   78.014221] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.019775] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.025390] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.031005] omap_i2c_xfer: Disabled irq 72
[   78.035400] omap_i2c_xfer: Enabled irq 72
[   78.039703] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.045227] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.050811] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.056457] omap_i2c_xfer: Disabled irq 72
[   78.060852] omap_i2c_xfer: Enabled irq 72
[   78.065155] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.070739] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.076263] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.081909] omap_i2c_xfer: Disabled irq 72
[   78.086364] omap_i2c_xfer: Enabled irq 72
[   78.090576] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.096160] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.101745] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.107299] omap_i2c_xfer: Disabled irq 72
[   78.111755] omap_i2c_xfer: Enabled irq 72
[   78.116088] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.121582] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.127197] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.132812] omap_i2c_xfer: Disabled irq 72
[   78.137207] omap_i2c_xfer: Enabled irq 72
[   78.141510] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.147033] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.152618] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.158233] omap_i2c_xfer: Disabled irq 72
[   78.162628] omap_i2c_xfer: Enabled irq 72
[   78.166931] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.172515] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.178039] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.183685] omap_i2c_xfer: Disabled irq 72
[   78.188140] omap_i2c_xfer: Enabled irq 72
[   78.192352] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.197937] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.203552] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.209106] omap_i2c_xfer: Disabled irq 72
[   78.213562] omap_i2c_xfer: Enabled irq 72
[   78.217864] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.223388] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.228973] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.234588] omap_i2c_xfer: Disabled irq 72
[   78.238983] omap_i2c_xfer: Enabled irq 72
[   78.243286] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.248870] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.254394] omap_i2c_isr: irq 72, runtime_suspended = 0
[   78.260040] omap_i2c_xfer: Disabled irq 72
[   78.264495] resume_irqs: resuming irq 177
[   78.268737] resume_irqs: resuming irq 178
[   78.273071] resume_irqs: resuming irq 179
[   78.277343] resume_irqs: resuming irq 180
[   78.281677] resume_irqs: resuming irq 181
[   78.285888] resume_irqs: resuming irq 182
[   78.290252] resume_irqs: resuming irq 183
[   78.294464] resume_irqs: resuming irq 184
[   78.298797] resume_irqs: resuming irq 185
[   78.303009] resume_irqs: resuming irq 186
[   78.307342] resume_irqs: resuming irq 187
[   78.311737] omap_i2c_xfer: Enabled irq 72
[   78.315948] omap_i2c_isr: irq 72, runtime_suspended = 0


--=-eXXQ7ZcXQ42Yf2gsIGGC
Content-Disposition: attachment; filename="0001-TESTING-random-i2c-suspend-resume-debugs.patch"
Content-Type: text/x-patch; name="0001-TESTING-random-i2c-suspend-resume-debugs.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From c2cdf7b02bead3bfe8768d875c7c01a58cab9d9f Mon Sep 17 00:00:00 2001
From: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Date: Mon, 15 Oct 2012 10:27:24 +0300
Subject: [PATCH 1/1] TESTING: random i2c / suspend / resume debugs

debugging stuff for the i2c resume issues. not for merging.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
---
 drivers/base/power/main.c              |    9 +++++++--
 drivers/i2c/busses/i2c-omap.c          |    5 +++++
 drivers/input/misc/twl4030-pwrbutton.c |    3 +++
 kernel/irq/pm.c                        |    1 +
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a3c1404..403848e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -467,7 +467,9 @@ static void dpm_resume_noirq(pm_message_t state)
 	}
 	mutex_unlock(&dpm_list_mtx);
 	dpm_show_time(starttime, state, "noirq");
+	printk(KERN_CRIT "before allowing irqs\n");
 	resume_device_irqs();
+	printk(KERN_CRIT "after allowing irqs\n");
 	cpuidle_resume();
 }
 
@@ -555,6 +557,7 @@ static void dpm_resume_early(pm_message_t state)
 void dpm_resume_start(pm_message_t state)
 {
 	dpm_resume_noirq(state);
+	printk(KERN_CRIT "%s: before starting early resume\n",__func__);
 	dpm_resume_early(state);
 }
 EXPORT_SYMBOL_GPL(dpm_resume_start);
@@ -911,10 +914,12 @@ static int dpm_suspend_noirq(pm_message_t state)
 		}
 	}
 	mutex_unlock(&dpm_list_mtx);
-	if (error)
+	if (error) {
+		printk(KERN_CRIT "suspend irq failed, running irq resume\n");
 		dpm_resume_noirq(resume_event(state));
-	else
+	} else {
 		dpm_show_time(starttime, state, "noirq");
+	}
 	return error;
 }
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c42f34a..88b7365 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -588,6 +588,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	/* We have the bus, enable IRQ */
 	enable_irq(dev->irq);
+	printk(KERN_CRIT "%s: Enabled irq %d\n", __func__, dev->irq);
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
@@ -610,6 +611,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_wait_for_bb(dev);
 	disable_irq(dev->irq);
+	printk(KERN_CRIT "%s: Disabled irq %d\n", __func__, dev->irq);
 out:
 	pm_runtime_put(dev->dev);
 	return r;
@@ -760,6 +762,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	u16 bits;
 	u16 stat, w;
 	int err, count = 0;
+	printk(KERN_CRIT "%s: irq %d, runtime_suspended = %d\n", __func__,
+				this_irq, pm_runtime_suspended(dev->dev));
 
 	if (pm_runtime_suspended(dev->dev))
 		return IRQ_NONE;
@@ -1066,6 +1070,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	/* We enable IRQ only when request for I2C from master */
 	disable_irq(dev->irq);
+	printk(KERN_CRIT "%s: Disabled irq %d\n", __func__, dev->irq);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index b3dd96d..7c0e28c 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -39,9 +39,12 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 	int err;
 	u8 value;
 
+	printk(KERN_CRIT "twl4030_pwrkey IRQ %d\n", irq);
+
 	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
 				STS_HW_CONDITIONS);
 	if (!err)  {
+		printk(KERN_CRIT "twl4030_pwrkey = %d\n", value & PWR_PWRON_IRQ);
 		pm_wakeup_event(pwr->dev.parent, 0);
 		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
 		input_sync(pwr);
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index cb228bf..b70b0fc 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -47,6 +47,7 @@ static void resume_irqs(bool want_early)
 
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
+		printk(KERN_CRIT "%s: resuming irq %d\n", __func__, irq);
 		bool is_early = desc->action &&
 			desc->action->flags & IRQF_EARLY_RESUME;
 
-- 
1.7.4.1


--=-eXXQ7ZcXQ42Yf2gsIGGC--
