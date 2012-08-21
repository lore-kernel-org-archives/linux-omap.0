From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 1/3] ARM: OMAP: hwmod: partially un-reset hwmods might not
 be properly enabled
Date: Mon, 20 Aug 2012 20:13:47 -0500
Message-ID: <CALLhW=44R0H-3k5qU=Uckf9UjzP2=xLFYXJt8Nce7VoKFpX_dQ@mail.gmail.com>
References: <1342466485-1050-1-git-send-email-omar.luna@linaro.org>
	<1342466485-1050-2-git-send-email-omar.luna@linaro.org>
	<50324E84.6080407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50324E84.6080407@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On 20 August 2012 09:49, Benoit Cousson <b-cousson@ti.com> wrote:
> On 07/16/2012 09:21 PM, Omar Ramirez Luna wrote:
>> Some IP blocks might not be using/controlling more than one
>> reset line, this check loosens the restriction to fully use
>> hwmod framework for those drivers.
>>
>> E.g.: ipu has reset lines: mmu_cache, cpu0 and cpu1.
>> - cpu1 might not be used and hence (with previous check)
>>   won't be fully enabled by hwmod code.
>
> You mean that you might have some case where you need to enable the
> mmu_cache and cpu0 and thus deassert only the mmu/cpu0 while keeping the
> cpu1 under reset?
>
> So the any_hardreset is indeed not appropriate in that case.
>
> In fact, since the hardreset cannot be handled at all by the hwmod fmwk,
> I'm even wondering if we should take care of checking the state at all.
> But as Paul stated, if was done due to the lack of understanding about
> the diver usage, so maybe things will become clearer once we will have
> that code available.
>
> So I guess that checking for all the lines for the hardreset state is
> anyway already a first step toward a good understanding of the reset
> need for the remote processors.
>
> The patch looks fine to me considering that we do not have a lot of
> information about the usage :-(
>
> Maybe you could add more information in the changelog to explain the way
> you are going to use the reset API.

I'll add an updated description with more information.

Thanks for the comments,

Omar
