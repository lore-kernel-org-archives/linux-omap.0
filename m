From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ti-soc-thermal: implement omap3 support
Date: Thu, 2 Apr 2015 16:49:01 +0200
Message-ID: <20150402144901.GC18125@amd>
References: <20150103114632.GA21883@amd>
 <20150118202447.GA29014@amd>
 <20150331084234.GA11712@amd>
 <CANOLnOO4J3RQCJZB0ibkGc5KhvPu+Q1f-bwc8mpxKCPRgjw5PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOO4J3RQCJZB0ibkGc5KhvPu+Q1f-bwc8mpxKCPRgjw5PQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Pali Rohar <pali.rohar@gmail.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> > +/* Thresholds and limits for OMAP34XX MPU temperature sensor */
> > +static struct temp_sensor_data omap34xx_mpu_temp_sensor_data = {
> > +       .min_freq = 32768,
> > +       .max_freq = 32768,
> > +       .max_temp = -99000,
> > +       .min_temp = 99000,
> 
> This looks mixed up. Also, perhaps use -40000 to 125000 to match the
> table below?

Yes, that looks reasonable, thanks for review. v2 in minute or so.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
