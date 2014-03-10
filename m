From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
Date: Mon, 10 Mar 2014 14:25:43 -0500
Message-ID: <531E11B7.6080109@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
 <20140224015826.GU25940@sirena.org.uk> <530B594F.2030500@ti.com>
 <20140303035426.GC2411@sirena.org.uk> <531DF250.5060100@ti.com>
 <20140310172221.GT28112@sirena.org.uk> <531DF931.1060108@ti.com>
 <20140310180131.GZ28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140310180131.GZ28112@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/10/2014 01:01 PM, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 12:41:05PM -0500, Nishanth Menon wrote:
> 
>> The only other options are:
>> a) Abstract it at a higher level at "user drivers", since they are
>> aware of the sequencing needs - but this partially defeats the
>> purpose, unless ofcourse, we do a tricky implementation such as:
>> clk a, b, c -> prenotifiers in a, postnotifiers in c (which as you
>> mentioned is a little trickier to get right).
>> b) introduce a higher level generic dvfs function[1] which does not
>> seem very attractive either.
> 
>> Any other suggestions other than limiting the usage(and documenting it
>> so) and hoping for a future evolution to take this into consideration?
> 
> Something might be doable with telling the clock API about maintianing
> ratios between clocks?  I do think we should have an idea where we'd go
> with such requirements, even if we don't currently handle it, so that we
> can hopefully avoid another round of refactoring everything but it
> doesn't seem 100% essential, just very nice to have.
> 
Mike,
Any suggestions about the above? could we use composite clocks in some
manner here(even though I think the original intent of the same was
not the same)?

-- 
Regards,
Nishanth Menon
