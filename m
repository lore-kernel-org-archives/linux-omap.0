From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 32/35 linux-next] clk: constify of_device_id array
Date: Fri, 27 Mar 2015 00:19:35 -0700
Message-ID: <20150327071935.GB18059@codeaurora.org>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
 <20150318141509.7930.28419@quantum>
 <386731024.185864.1427020449384.open-xchange@webmail.nmp.proximus.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <386731024.185864.1427020449384.open-xchange@webmail.nmp.proximus.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Michael Turquette <mturquette@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-omap@vger.kernel.org

On 03/22, Fabian Frederick wrote:
> 
> 
> > On 18 March 2015 at 15:15 Michael Turquette <mturquette@linaro.org> wrote:
> >
> >
> > Quoting Fabian Frederick (2015-03-16 12:59:06)
> > > of_device_id is always used as const.
> > > (See driver.of_match_table and open firmware functions)
> > >
> > > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> >
> > Acked-by: Michael Turquette <mturquette@linaro.org>
> 
> Thanks :)
> 
> btw, something I forgot to mention in changelog is the __initdata -> __initconst
> for ti_clkdm_match_table[]
> 
> I can send it again with a new changelog if necessary ...
> 

Did you want us to take this through clk-next? If so please
resend with the new commit text.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
