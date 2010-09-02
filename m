From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Thu, 2 Sep 2010 11:08:43 +0200
Message-ID: <AANLkTinmWTAwckEJJs8d4BW3PVRHSBwy4i-w=MNe5eDX@mail.gmail.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<20100902075605.GB2962@matterhorn.lan>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCED1488@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCED1488-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Amit, Santosh,

On Thu, Sep 2, 2010 at 10:11 AM, Shilimkar, Santosh
<santosh.shilimkar-l0cyMroinI0@public.gmane.org> wrote:
...
>> > The point is to keep the minimum possible in the kernel: just the
>> > tracepoints we're interested in. =A0 The rest (calculations, averages,
>> > analysis, etc.) does not need to be in the kernel and can be done easi=
er
>> > and with more powerful tools outside the kernel.
>>
>> Kevin,
>>
>> I agree. We discussed this a little in our weekly meeting. Vishwa's main
>> concern was the lack of ability to instrument the last bit of SRAM code.
>>
>> I have a feeling that even with caches on when we enter this code, we
>> won't
>> see too much variance in the latency to execute this bit of code. Vishwa
>> is
>> going to confirm that now. If that hypothesis is true, we can indeed move
>> to
>> using tracepoints in the idle path and use external tools to track laten=
cy.
I agree. Can you confirm this asap?
I am looking at the instrumentation tracepoints now. I think it would
be ideal to provide multiple tracepoints in both sleep and wake-up
paths.

> There will be difference with and without caches but the delta latency wi=
ll be constant with caches and without caches. Another important point is
> he lowest level code should be just profiled once and for worst CPU/BUS c=
lock speed.
Ok.

>> Even if it isn't true, the rest of the idle path could still contain
>> tracepoints.
I am looking at the best way to introduce tracepoints in the low level
code, in case it is needed.

> I also think this would be better approach considering a generic solution.
Good!

>
> Regards,
> Santosh
>

Jean
