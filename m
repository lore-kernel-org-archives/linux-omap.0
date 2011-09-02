From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 3/3] trace points: power: remove 'cpu_id' from trace_cpu_idle
Date: Fri, 2 Sep 2011 15:38:07 +0800
Message-ID: <CACVXFVOq2Hn-ZED2LyRQjk72mWJ5N=_LbVw3-vvrK-xUtKZGhQ@mail.gmail.com>
References: <1313766244-22313-1-git-send-email-tom.leiming@gmail.com>
	<201108192231.02665.trenn@suse.de>
	<CACVXFVPeFyg7YoAsY63Mpy9HVR1y3ibg9R8HnUfLVe=hKf3ApA@mail.gmail.com>
	<201108221027.34441.trenn@suse.de>
	<CAORVsuVkxHTEr5J9F1USr3csMoCELDfk9ixeG3kddy6oRj5RUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAORVsuVkxHTEr5J9F1USr3csMoCELDfk9ixeG3kddy6oRj5RUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 2, 2011 at 3:26 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>> It was known that cpu_id is always the current cpu with current
>> implementation when this got introduced.
>> But the perf events API must not change back and forth for userspace
>> compatibility. Therefore the cpu_id was added in case
>> that future implementations want to pass info where the current cpu
>> is not the cpu which is sent to the sleep state.
> Agree. Let's keep the cpu_id field.

OK, let's keep it.

How about removing it in clock_enalbe/clock_disable/power_domain_target
as did in [1/3] and [2/3]?  I don't see any usefulness of 'cpu_id' in the tree
trace points.


thanks,
-- 
Ming Lei
