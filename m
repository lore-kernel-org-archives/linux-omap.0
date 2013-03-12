From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] cpufreq: cpufreq-cpu0: support for clock which are
 not in DT yet.
Date: Tue, 12 Mar 2013 10:51:08 -0500
Message-ID: <20130312155108.GA22409@kahuna>
References: <1363043130-30270-1-git-send-email-nm@ti.com>
 <1363043130-30270-2-git-send-email-nm@ti.com>
 <513EB704.8030907@ti.com>
 <513F3A88.5060903@ti.com>
 <20130312143535.GA21599@kahuna>
 <DC88CAD03C0052499C1907B327FC63229BF816@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229BF816@DBDE01.ent.ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10:17-20130312, J, KEERTHY wrote:
> > OK. My intent is to remove omap-cpufreq.c. So, I guess I could do
> > something like the following (not tested yet), but would that be the
> > right approach?
> 
> Similar attempt was done for am33xx_clks in this by Shawn:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg84157.html
Thanks on the same and all inputs folks. Based on the discussion, will give it
another shot to make the patch apply for all OMAPs - Since we are
gradually transitioning to DT, we should be able to gradually drop
features to being enabled only in DT supported boot. This will allow us
to remove redundant drivers from the kernel. I hope this sounds
reasonable to all.
-- 
Regards,
Nishanth Menon
