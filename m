From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v8 0/8] Consolidate cpuidle functionality
Date: Tue, 20 Mar 2012 21:45:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1203202138130.24151@xanadu.home>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org> <87wr6evmnn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87wr6evmnn.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Robert Lee <rob.lee@linaro.org>, len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, rjw@sisk.pl, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vge
List-Id: linux-omap@vger.kernel.org

On Tue, 20 Mar 2012, Kevin Hilman wrote:

> Looks like you never heard from anyone actively working on at91,
> shmobile, kirwood or davinci.
> 
> I'm not sure we should merge those platform-specific changes without an
> ack from those platform maintainers.

Depends.  There is a limit to how long you may be willing to wait after 
people.  Sometimes the only way to make progress is to merge the thing 
and hope that someone who cares will test the stuff during the ~2 months 
-rc period and provide any fix then.  And if that doesn't happen during 
that time then either the code is just right and no one noticed the 
change, or no one cares anymore.

IMHO, Rob posted those patches many times now for quite a while (many 
months) already.  So I'd suggest simply pushing that stuff into mainline 
as is.


Nicolas
