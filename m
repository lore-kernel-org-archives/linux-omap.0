From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Fri, 06 Feb 2015 09:15:51 -0800
Message-ID: <54D4F6C7.2020007@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org> <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6> <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum> <54D0F179.1040906@gmail.com> <54D2AA9B.7010800@codeaurora.org> <54D3900A.9060200@gmail.com> <54D423C3.9030105@codeaurora.org> <54D482EE.6050004@gmail.com> <alpine.DEB.2.10.1502061009320.2538@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1502061009320.2538@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>, Quentin Lambert <lambert.quentin@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/06/15 01:12, Julia Lawall wrote:
>
> On Fri, 6 Feb 2015, Quentin Lambert wrote:
>
>> On 06/02/2015 03:15, Stephen Boyd wrote:
>>> Thanks for the coccinelle patch. Thinking more about it, I don't think
>>> we care if the pointer is dereferenced because that would require a
>>> definition of struct clk and that is most likely not the case outside of
>>> the clock framework. Did you scan the entire kernel?
>> No I haven't.
>>> I'm running it now
>>> but it seems to be taking a while.
>>>
>> Yes, that's why, as a first step, I chose to limit the scan to the arm
>> directory.
> Are you sure to be using all of the options provided:
>
> // Options: --recursive-includes --relax-include-path
> // Options: --include-headers-for-types
>
> And are you using 1.0.0-rc23 or 1.0.0-rc24?  Those should save parsed
> header files so that they don't have to be parsed over and over.
>
> If you are using rc24, then you can use the -j option for parallelism.
> But then you should also use an option like --chunksize 10 (I don't know
> what number would be good), because the default is chunksize 1, and in
> that case the saved parsed header files are not reused, because the fies
> are all processed individually.  In general, it is only the files within a
> chunk that will share parsed header files.

Thanks for the info.

$ spatch --version
spatch version 1.0.0-rc22 with Python support and with PCRE support

so I guess I need to update. I tried throwing it into
scripts/coccinelle/misc and then did

make O=../obj/ coccicheck
COCCI=../kernel/scripts/coccinelle/misc/structclk.cocci

at the toplevel but it didn't find anything.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
