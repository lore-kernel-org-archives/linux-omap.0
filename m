From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/6] clk: introduce the common clock framework
Date: Fri, 13 Jan 2012 20:39:07 -0800
Message-ID: <CAJOA=zNtKvvek5LPsDYUie8KLcTBB0F4GxWhzn2g8=YxpCcMPQ@mail.gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
	<1323834838-2206-4-git-send-email-mturquette@linaro.org>
	<alpine.LFD.2.02.1112141007550.3020@ionos>
	<CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA@mail.gmail.com>
	<20111217110433.GC14547@n2100.arm.linux.org.uk>
	<4F11021A.8070407@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F11021A.8070407-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 13, 2012 at 8:18 PM, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> w=
rote:
> On 12/17/2011 03:04 AM, Russell King - ARM Linux wrote:
>>
>> On Fri, Dec 16, 2011 at 04:45:48PM -0800, Turquette, Mike wrote:
>>>
>>> On Wed, Dec 14, 2011 at 5:18 AM, Thomas Gleixner<tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>>> =A0wrote:
>>>>
>>>> On Tue, 13 Dec 2011, Mike Turquette wrote:
>>>>>
>>>>> +void __clk_unprepare(struct clk *clk)
>>>>> +{
>>>>> + =A0 =A0 if (!clk)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>> +
>>>>> + =A0 =A0 if (WARN_ON(clk->prepare_count =3D=3D 0))
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>> +
>>>>> + =A0 =A0 if (--clk->prepare_count> =A00)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>> +
>>>>> + =A0 =A0 WARN_ON(clk->enable_count> =A00);
>>>>
>>>>
>>>> So this leaves the clock enable count set. I'm a bit wary about
>>>> that. Shouldn't it either return (including bumping the prepare_count
>>>> again) or call clk_disable() ?
>>
>>
>> No it should not.
>>
>>> I've hit this in my port of OMAP. =A0It comes from this simple situatio=
n:
>>>
>>> driver 1 (adapted for clk_prepare/clk_unprepare):
>>> clk_prepare(clk);
>>> clk_enable(clk);
>>>
>>> ...
>>>
>>> driver2 (not adapted for clk_prepare/clk_unprepare):
>>> clk_enable(clk);
>>
>>
>> So this is basically buggy. =A0Look, it's quite simple. =A0Convert _all_
>> your drivers to clk_prepare/clk_unprepare _before_ you start switching
>> your platform to use these new functions. =A0You can do that _today_
>> without exception.
>>
>> We must refuse to merge _any_ user which does this the old way - and
>> we should have been doing this since my commit was merged into mainline
>> to allow drivers to be converted.
>>
>> And stop trying to think of ways around this inside clk_prepare/
>> clk_unprepare/clk_enable/clk_disable. =A0You can't do it. =A0Just fix _a=
ll_
>> the drivers. =A0Now. =A0Before you start implementing
>> clk_prepare/clk_unprepare.
>
>
> I agree with Russell's suggestion. This is what I'm trying to do with the
> MSM platform. Not sure if I'm too optimistic, but as of today, I'm still
> optimistic I can push the MSM driver devs to get this done before we enab=
le
> real prepare/unprepare support.

Just to reach closure on this topic: I don't plan to change
__clk_unprepare in the next version of the patches.  The warnings are
doing a fine job of catching code which has yet to be properly
converted to use clk_(un)prepare.

Mike

>
>
> Thanks,
> Saravana
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
