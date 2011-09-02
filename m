From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 3/3] trace points: power: remove 'cpu_id' from trace_cpu_idle
Date: Fri, 2 Sep 2011 09:26:28 +0200
Message-ID: <CAORVsuVkxHTEr5J9F1USr3csMoCELDfk9ixeG3kddy6oRj5RUw@mail.gmail.com>
References: <1313766244-22313-1-git-send-email-tom.leiming@gmail.com>
	<201108192231.02665.trenn@suse.de>
	<CACVXFVPeFyg7YoAsY63Mpy9HVR1y3ibg9R8HnUfLVe=hKf3ApA@mail.gmail.com>
	<201108221027.34441.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201108221027.34441.trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Ming Lei <tom.leiming@gmail.com>
Cc: rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-omap@vger.kernel.org

Ming Lei, Thomas,

Sorry if it is a bit late to jump in.

On Mon, Aug 22, 2011 at 10:27 AM, Thomas Renninger <trenn@suse.de> wrot=
e:
> On Saturday, August 20, 2011 04:40:09 AM Ming Lei wrote:
>> Hi,
>>
>> 2011/8/20 Thomas Renninger <trenn@suse.de>:
>> > On Friday, August 19, 2011 05:04:04 PM tom.leiming@gmail.com wrote=
:
>> >> From: Ming Lei <tom.leiming@gmail.com>
>> >>
>> >> This patch removes the 'cpu_id' parameter of the cpu_idle
>> >> trace point, based on the ideas below:
>> >>
>> >> - the cpu_id which is passed to trace point is always the current
>> >> =A0 cpu
>> > Are you sure this will always be true?
>>
>> It is sure at least now, =A0the only place to pass 'dev->cpu' is ins=
ide
>> cpuidle_idle_call,
> It was known that cpu_id is always the current cpu with current
> implementation when this got introduced.
> But the perf events API must not change back and forth for userspace
> compatibility. Therefore the cpu_id was added in case
> that future implementations want to pass info where the current cpu
> is not the cpu which is sent to the sleep state.
Agree. Let's keep the cpu_id field.

>
>> smp_processor_id() can't be used safely in preemptible context.
> I expect the only side effect that could happen is that if smp_proces=
s_id
> is interrupted you get the wrong core id on a cpu idle trace event.
> This only happens if cpuidle is not used and even then should happen
> very rarely, nothing to worry for a debug tool like that.
> And it should get fixed if these idle functions get fully integrated =
into
> cpuidle at some point of time.
>
> =A0 Thomas
>

Regards,
Jean
