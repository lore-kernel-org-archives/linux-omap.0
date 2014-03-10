From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
Date: Mon, 10 Mar 2014 12:41:05 -0500
Message-ID: <531DF931.1060108@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
 <20140224015826.GU25940@sirena.org.uk> <530B594F.2030500@ti.com>
 <20140303035426.GC2411@sirena.org.uk> <531DF250.5060100@ti.com>
 <20140310172221.GT28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140310172221.GT28112@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-doc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/10/2014 12:22 PM, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 12:11:44PM -0500, Nishanth Menon wrote:
>> On 03/02/2014 09:54 PM, Mark Brown wrote:
>>> On Mon, Feb 24, 2014 at 08:38:07AM -0600, Nishanth Menon wrote:
> 
>>>> Intent here is to allow drivers such as cpufreq-cpu0 to be reused on
>>>> platforms such as TI's OMAP derivatives, and other SoCs which differ
>>>> only by the sequence involved in voltage scale operations. So, this
>>>> patch provides a framework for registering the underlying
>>>> implementation of the SoC specific voltage change methodology.
> 
>>> That bit is clear, what's very opaque from the code is how this is going
>>> to be accomplished.
> 
>> The SoC specific voltage domain drivers register with
>> devm_voltdm_register. the fops provide the abstraction needed for the
>> SoC (example in patch #5 - which introduces OMAP specific voltage
>> domain which handles ABB and VDD regulators).
> 
>> What would you suggest that we do to clarify the usage here?
> 
> Probably saying something about this in the commit message would be
> enough - mentioning how the registration occurs and that things are
> triggered by clock frequency changes.

OK. will do, thanks for suggesting the same.

>>> So the first question I have here is what happens if multiple clocks
>>> need to be updated in lock step - if we're only triggering off clock
>>> notifiers that seems tricky.  The other thing here is that the fact that
> 
>> Yes, that is true, however, there are ways to implement them, for
>> example: We could implement an higher level clock that takes care of
>> the multiple clock node control to handle this kind of scenario.
> 
> That seems concerning given the fact that people seem to like describing
> their entire clock trees in DT, we shouldn't be putting implementation
> stuff there.

The only other options are:
a) Abstract it at a higher level at "user drivers", since they are
aware of the sequencing needs - but this partially defeats the
purpose, unless ofcourse, we do a tricky implementation such as:
clk a, b, c -> prenotifiers in a, postnotifiers in c (which as you
mentioned is a little trickier to get right).
b) introduce a higher level generic dvfs function[1] which does not
seem very attractive either.


Any other suggestions other than limiting the usage(and documenting it
so) and hoping for a future evolution to take this into consideration?

[1] http://marc.info/?t=139275581900004&r=1&w=2

-- 
Regards,
Nishanth Menon
