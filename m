From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] PM / OPP: rename functions to dev_pm_opp*
Date: Fri, 20 Sep 2013 14:07:17 -0500
Message-ID: <523C9CE5.9040009@ti.com>
References: <1379624632-17356-1-git-send-email-nm@ti.com>	<1379624632-17356-2-git-send-email-nm@ti.com>	<CAKohpoku7n6b2dDKD=+3DqG4pHtmWoeXZnAt3EoFRp+rNFofYA@mail.gmail.com>	<20130920123808.GA22176@kahuna>
 <CAKohpoktS4ZSQAeKvu3hdVsKkzcbKFvHvR2=wCA3qeB6moPphA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohpoktS4ZSQAeKvu3hdVsKkzcbKFvHvR2=wCA3qeB6moPphA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Randy Dunlap <rdunlap@infradead.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 09/20/2013 11:51 AM, Viresh Kumar wrote:
> On 20 September 2013 18:08, Nishanth Menon <nm@ti.com> wrote:
> 
>> I am open to suggestions if any one feels we can improve this better.
> 
> I didn't really had one.. I thought of pm_opp** instead of dev_pm_opp**
> though..

I had proposed this earlier, however, had gone with Rafael's
suggestion [1] to have the right context to the usage.

> 
>> I believe that change was from Patch #2[1]
> 
> Yeah.. I just replied on a single patch :)
> 
>> yes, you are right, I had squashed this patch in to squelch checkpatch
>> warnings:
> 
> I see..
> 
>> I had added a comment:
>> " Minor checkpatch warning fixes as a result of this change was fixed as
>> well."
> 
> I really missed that..
no problems..

> 
>> Would you suggest I split the change off to a separate patch or improve
>>  the comment a little more?
> 
> don't really know, maybe leave those as is and let checkpatch warn you..
> 
that is fair as well. i can split it off seperately in the next respin.

[1] http://marc.info/?l=linaro-kernel&m=137645747511725&w=2
-- 
Regards,
Nishanth Menon
