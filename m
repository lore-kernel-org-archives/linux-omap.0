From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] Introduce SET_NOIRQ_SYSTEM_SLEEP_PM_OPS and use it
Date: Fri, 15 May 2015 02:06:49 +0200
Message-ID: <1461742.xdGTkVV0dU@vostro.rjw.lan>
References: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org> <7hr3r4w9bf.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <7hr3r4w9bf.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: grygorii.strashko@linaro.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday, April 28, 2015 08:40:04 AM Kevin Hilman wrote:
> <grygorii.strashko@linaro.org> writes:
> 
> > From: Grygorii Strashko <grygorii.strashko@linaro.org>
> >
> > While working on suspend-to-disk functionality on TI dra7-evm (DRA7xx SoC)
> > i've found that the most common problem I have to dial with is absence
> > of corresponding PM callbacks in drivers and, in particular, noirq callbacks.
> > So, I've fixed one driver first
> > commit 6248015d6867 "ARM: omap-device: add missed callback for suspend-to-disk"
> > but then found another one which need to be fixed too (omap_l3_noc.c).
> > At this moment I decided to make my life easier and added new macro
> > SET_NOIRQ_SYSTEM_SLEEP_PM_OPS using the same approach as for the existing
> > SET_SYSTEM_SLEEP_PM_OPS macro.
> >
> > SET_NOIRQ_SYSTEM_SLEEP_PM_OPS: defined for CONFIG_PM_SLEEP and
> > assigns ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
> > function. Vice versa happens for ->resume_noirq, ->thaw_noirq and
> > ->restore_noirq.
> >
> > Further two patches reuse this newly introduced macro.
> >
> > SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, defined for CONFIG_PM_SLEEP, will
> >     point ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
> >     function. Vice versa happens for ->resume_noirq, ->thaw_noirq and
> >     ->restore_noirq.
> 
> For the series:
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> And for the omap_device changes:
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

All three queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
