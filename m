From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/8] ARM: OMAP3+: Switch to use DT based cpu0-cpufreq
 driver
Date: Fri, 15 Mar 2013 10:00:36 -0500
Message-ID: <20130315150036.GA3297@kahuna>
References: <1363294695-658-1-git-send-email-nm@ti.com>
 <5142AF41.7070003@ti.com>
 <20130315142157.GC2939@kahuna>
 <51433693.2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51433693.2@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09:56-20130315, Jon Hunter wrote:
[..]
> > But, that said, there is one path I see possible:
> > - keep omap-cpufreq alive (BUT I will add a patch that will not let it init
> >   when in DT entries are present)
> > - add DT entries for all relevant OMAPs - in DT mode, we will *only*
> > support cpufreq-cpu0
> > - All future SoCs will continue to use cpufreq-cpu0 using DT, as was the
> > alignment I believe.
> 
> Yes that is what we are doing for other drivers and should be done here.
OK. I guess we have not much of a choice with the legacy baggage we
carry around :(. Will redo the series for the same.

-- 
Regards,
Nishanth Menon
