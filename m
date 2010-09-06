From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Mon, 6 Sep 2010 18:22:55 +0200
Message-ID: <AANLkTikT+idycF5jo7h15+E3suVKN9bNB8N+vqGvRge1@mail.gmail.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<20100902075605.GB2962@matterhorn.lan>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCED1488@dbde02.ent.ti.com>
	<AANLkTinmWTAwckEJJs8d4BW3PVRHSBwy4i-w=MNe5eDX@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC356087031162CEB7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087031162CEB7-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Cc: "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Vishwa,

On Mon, Sep 6, 2010 at 1:15 PM, Sripathy, Vishwanath
<vishwanath.bs-l0cyMroinI0@public.gmane.org> wrote:
> I did some profiling of assembly code on OMAP3630 board (ZOOM3). In worst case it takes around 3.28ms and best case around 2.93ms for mpu off mode.
Can you give a bit more details? Which measurement has been taken (ASM
only, sleep, wake-up ...?) and what are the significant figures?

>For MPU INACTIVE/RET, it is less than 30us.
Mmh that is the resolution of the 32kHz timer, so I guess you get
either 0 or 1 timer cycle depending when you start the measurement.
IMO the 32kHz timer is too slow to measure those fast events.

> However as Kevin mentioned in other email, it would be better to find out a way to trace inside assembly code as well.
OK that could be done but first I would like to make sure such a
complication is  needed.

>
> Regards
> Vishwa

Jean
