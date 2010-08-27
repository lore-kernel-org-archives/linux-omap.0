From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 19:11:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCA86EE6@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<4C7792AD.80804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4C7792AD.80804-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, "vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Cc: "Chalhoub, Nicole" <n-chalhoub-l0cyMroinI0@public.gmane.org>, Jean Pihet <jean.pihet-BedXh0tyk8Y@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "Bour,
	Vincent" <v-bour-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Benoit,
> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Cousson, Benoit
> Sent: Friday, August 27, 2010 3:56 PM
> To: vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Sripathy, Vishwanath
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org; Jean Pihet;
> Chalhoub, Nicole; Bour, Vincent
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
> 
> Hi Vishwa,
> 
> On 8/28/2010 12:08 AM, vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> > From: Vishwanath BS<vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> > This patch has instrumentation code for measuring latencies for
> > various CPUIdle C states for OMAP. Idea here is to capture the
> > timestamp at various phases of CPU Idle and then compute the sw
> > latency for various c states. For OMAP, 32k clock is chosen as
> > reference clock this as is an always on clock. wkup domain memory
> > (scratchpad memory) is used for storing timestamps. One can see the
> > worstcase latencies in below sysfs entries (after enabling
> CONFIG_CPU_IDLE_PROF
> > in .config). This information can be used to correctly configure cpu
> idle
> > latencies for various C states after adding HW latencies for each of
> > these sw latencies.
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
> 
> FYI, Jean is currently working on using standard Linux probes in order
> to instrument CPUIdle / CPUfreq. I'm not sure it is doable, but it might
> better to use standard method to do that instead of purely OMAP3
> specific stuff. This code will not scale easily on OMAP4.
> 
Just discussed how to scale this for all OMAPs. Firstly we need to
get this code to common place instead of tying it to OMAP3/OMAP4 
specific low level code. Since on OMAP3, we can push C-functions
on SRAM and for OMAP4 we don't have any limitation, all this
code can be converted to C. 

Vishwa is planning to attempt that in next version.

Regards,
santosh
