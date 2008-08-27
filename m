From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [i2c] I2c 2 issue in 2.6.24 kernel
Date: Wed, 27 Aug 2008 19:39:04 +0300
Message-ID: <31e679430808270939q1b76bf1egf1307dfb8bc345e5@mail.gmail.com>
References: <ef0d8a250808270856w4675062cibf85435d20fdecfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:44924 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585AbYH0QjG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 12:39:06 -0400
Received: by ug-out-1314.google.com with SMTP id c2so959187ugf.37
        for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 09:39:04 -0700 (PDT)
In-Reply-To: <ef0d8a250808270856w4675062cibf85435d20fdecfc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

Hi,

for omap issues, keep linux-omap in the loop :-)

We still don't have omap3 pieces in mainline so people in other
mailing lists won't
know what we're talking about.


On Wed, Aug 27, 2008 at 6:56 PM, naveen krishna ch
<naveenkrishna.ch@gmail.com> wrote:
> Hi all,
> I am porting a touchscreen driver from 2.6.23 to 2.6.24. during porting.

which driver ?

> I found issues with i2C2 of omap3EVM.
>
> During kernel it detects the touchscreen and it will create a node also.
>
> The issues are like when i run a touchscreen command line application test
> The so called evtest.c
>
> The test gives output even if i dont touch the screen
> It will show the previous touched values like this.

sounds more like a but in the touchscreen driver, not in the i2c bus driver.

> The out put catch looks like
>
> Event: time 946684851.131195, -------------- Report Sync ------------
> Event: time 946684851.224975, -------------- Report Sync ------------
> Event: time 946684851.318756, -------------- Report Sync ------------
> Event: time 946684851.412475, -------------- Report Sync ------------
> Event: time 946684851.506256, -------------- Report Sync ------------
> Event: time 946684851.599975, -------------- Report Sync ------------
> Event: time 946684851.693756, -------------- Report Sync ------------
> Event: time 946684851.787475, -------------- Report Sync ------------
> Event: time 946684851.881256, -------------- Report Sync ------------
> Event: time 946684851.974975, -------------- Report Sync ------------
> Event: time 946684852.068756, -------------- Report Sync ------------
> Event: time 946684852.162475, -------------- Report Sync ------------
> Event: time 946684852.256195, type 3 (Absolute), code 45 (?), value 1
> Event: time 946684852.256195, type 3 (Absolute), code 0 (X), value 1281
> Event: time 946684852.256195, type 3 (Absolute), code 1 (Y), value 3074
> Event: time 946684852.256195, type 3 (Absolute), code 28 (Tool Width), value
> 14
> Event: time 946684852.256195, type 3 (Absolute), code 24 (Pressure), value
> 137
> Event: time 946684852.256225, -------------- Report Sync ------------
> Event: time 946684852.279663, type 3 (Absolute), code 24 (Pressure), value 0
> Event: time 946684852.279663, -------------- Report Sync ------------
> Event: time 946684852.304260, type 3 (Absolute), code 45 (?), value 3
> Event: time 946684852.304260, type 3 (Absolute), code 42 (?), value 5364
> Event: time 946684852.304260, type 3 (Absolute), code 43 (?), value 923
> Event: time 946684852.304260, type 3 (Absolute), code 44 (?), value 2846
> Event: time 946684852.304290, type 3 (Absolute), code 28 (Tool Width), value
> 15
> Event: time 946684852.304290, type 3 (Absolute), code 24 (Pressure), value
> 54
> Event: time 946684852.304290, -------------- Report Sync ------------
> Event: time 946684852.327728, type 3 (Absolute), code 43 (?), value 517
> Event: time 946684852.327728, type 3 (Absolute), code 44 (?), value 2827
> Event: time 946684852.327758, -------------- Report Sync ------------
> Event: time 946684852.351135, type 3 (Absolute), code 43 (?), value 325
> Event: time 946684852.351135, type 3 (Absolute), code 44 (?), value 2839
> Event: time 946684852.351165, -------------- Report Sync ------------
> Event: time 946684852.374603, type 3 (Absolute), code 43 (?), value 309
> Event: time 946684852.374603, type 3 (Absolute), code 44 (?), value 2848
> Event: time 946684852.374603, -------------- Report Sync ------------
> Event: time 946684852.398040, type 3 (Absolute), code 43 (?), value 241
> Event: time 946684852.398040, type 3 (Absolute), code 44 (?), value 2839
> Event: time 946684852.398071, -------------- Report Sync ------------
> Event: time 946684852.421386, type 3 (Absolute), code 43 (?), value 261
> Event: time 946684852.421417, type 3 (Absolute), code 44 (?), value 2845
> Event: time 946684852.421417, -------------- Report Sync ------------
> Event: time 946684852.444885, type 3 (Absolute), code 43 (?), value 293
> Event: time 946684852.444915, type 3 (Absolute), code 44 (?), value 2848
> Event: time 946684852.444915, -------------- Report Sync ------------
> Event: time 946684852.468322, type 3 (Absolute), code 43 (?), value 247
> Event: time 946684852.468322, type 3 (Absolute), code 44 (?), value 2853
> Event: time 946684852.468353, -------------- Report Sync ------------
> Event: time 946684852.491760, type 3 (Absolute), code 43 (?), value 275
> Event: time 946684852.491760, type 3 (Absolute), code 44 (?), value 2845
> Event: time 946684852.491790, -------------- Report Sync ------------
> Event: time 946684852.515197, type 3 (Absolute), code 43 (?), value 214
> Event: time 946684852.515228, -------------- Report Sync ------------
> Event: time 946684852.537506, type 3 (Absolute), code 24 (Pressure), value 0
> Event: time 946684852.537506, -------------- Report Sync ------------
> Event: time 946684852.560943, -------------- Report Sync ------------
> Event: time 946684852.584350, -------------- Report Sync ------------
> Event: time 946684852.608947, type 3 (Absolute), code 45 (?), value 2
> Event: time 946684852.608947, type 3 (Absolute), code 41 (?), value 277
> Event: time 946684852.608947, type 3 (Absolute), code 42 (?), value 5265
> Event: time 946684852.608947, type 3 (Absolute), code 43 (?), value 331
> Event: time 946684852.608978, type 3 (Absolute), code 44 (?), value 2884
> Event: time 946684852.608978, type 3 (Absolute), code 24 (Pressure), value
> 132
> Event: time 946684852.608978, -------------- Report Sync ------------
> Event: time 946684852.631195, type 3 (Absolute), code 24 (Pressure), value 0
> Event: time 946684852.631195, -------------- Report Sync ------------
> Event: time 946684852.654663, type 3 (Absolute), code 45 (?), value 1
> Event: time 946684852.654663, type 3 (Absolute), code 0 (X), value 295
> Event: time 946684852.654663, type 3 (Absolute), code 1 (Y), value 2895
> Event: time 946684852.654663, type 3 (Absolute), code 24 (Pressure), value
> 140
> Event: time 946684852.654663, -------------- Report Sync ------------
> Event: time 946684852.678100, type 3 (Absolute), code 0 (X), value 309
> Event: time 946684852.678100, type 3 (Absolute), code 1 (Y), value 2899
> Event: time 946684852.678131, type 3 (Absolute), code 28 (Tool Width), value
> 13
> Event: time 946684852.678131, -------------- Report Sync ------------
> Event: time 946684852.701538, type 3 (Absolute), code 0 (X), value 327
> Event: time 946684852.701538, type 3 (Absolute), code 1 (Y), value 2901
> Event: time 946684852.701538, type 3 (Absolute), code 28 (Tool Width), value
> 15
> Event: time 946684852.701538, -------------- Report Sync ------------
> Event: time 946684852.724975, type 3 (Absolute), code 24 (Pressure), value 0
> Event: time 946684852.724975, -------------- Report Sync ------------
> Event: time 946684852.748443, -------------- Report Sync ------------
> Event: time 946684852.771881, -------------- Report Sync ------------
> Event: time 946684852.795288, -------------- Report Sync ------------
> Event: time 946684852.818725, -------------- Report Sync ------------
> Event: time 946684852.842102, -------------- Report Sync ------------
> Event: time 946684852.865600, -------------- Report Sync ------------
> Event: time 946684852.959350, -------------- Report Sync ------------
> Event: time 946684853.053436, type 3 (Absolute), code 0 (X), value 1825
> Event: time 946684853.053466, type 3 (Absolute), code 1 (Y), value 3334
> Event: time 946684853.053466, type 3 (Absolute), code 28 (Tool Width), value
> 1
> Event: time 946684853.053466, type 3 (Absolute), code 24 (Pressure), value
> 106
> Event: time 946684853.053466, -------------- Report Sync ------------
> Event: time 946684853.076538, type 3 (Absolute), code 0 (X), value 1828
> Event: time 946684853.076538, type 3 (Absolute), code 1 (Y), value 3329
> Event: time 946684853.076538, -------------- Report Sync ------------
> Event: time 946684853.100006, type 3 (Absolute), code 0 (X), value 1833
> Event: time 946684853.100006, type 3 (Absolute), code 1 (Y), value 3320
> Event: time 946684853.100006, -------------- Report Sync ------------
> Event: time 946684853.123413, type 3 (Absolute), code 0 (X), value 1826
> Event: time 946684853.123413, type 3 (Absolute), code 1 (Y), value 3273
> Event: time 946684853.123413, -------------- Report Sync ------------
> Event: time 946684853.146850, type 3 (Absolute), code 0 (X), value 1785
> Event: time 946684853.146850, type 3 (Absolute), code 1 (Y), value 3161
> Event: time 946684853.146850, type 3 (Absolute), code 28 (Tool Width), value
> 5
> Event: time 946684853.146850, -------------- Report Sync ------------
> Event: time 946684853.170288, type 3 (Absolute), code 0 (X), value 1711
> Event: time 946684853.170288, type 3 (Absolute), code 1 (Y), value 2856
> Event: time 946684853.170288, type 3 (Absolute), code 28 (Tool Width), value
> 15
> Event: time 946684853.170288, type 3 (Absolute), code 24 (Pressure), value
> 28
> Event: time 946684853.170288, -------------- Report Sync ------------
> Event: time 946684853.193725, type 3 (Absolute), code 24 (Pressure), value 0
> Event: time 946684853.193725, -------------- Report Sync ------------
> Event: time 946684853.217132, -------------- Report Sync ------------
> Event: time 946684853.240631, -------------- Report Sync ------------
> Event: time 946684853.264038, -------------- Report Sync ------------
> Event: time 946684853.287475, -------------- Report Sync ------------
>
> It starts with some value and it retains the previous touch values even if i
> remove my thumb.
>
> I tried with same driver and same evtest.c in the latest git tree and
>  there its working straight away.
>
> Can any one suggest me a debugging solution.

Get a diff from both versions of the driver (from current git to 2.6.24 or 23)
and try to fix it yourself. It's the easiest way.

You can also look at git log and try to find out which commit fixed it.

-- 
balbi
