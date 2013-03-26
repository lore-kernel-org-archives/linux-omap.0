From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] cpufreq: drivers: Remove unnecessary assignments
 of policy-> members
Date: Tue, 26 Mar 2013 11:36:02 +0530
Message-ID: <51513ACA.2080104@ti.com>
References: <2ece6d9fe8dfb6882a1c83a1cb2404bacc40b22d.1364138740.git.viresh.kumar@linaro.org> <07b96c5b68470001197445fb3d28786ad9acdbe0.1364138740.git.viresh.kumar@linaro.org> <51500C81.7040307@ti.com> <CAKohpomTt-ajNeh-OwV9X-HNBddJzL=JB+ggFY0msmsuZabvjA@mail.gmail.com> <51501BD5.2070807@ti.com> <CAKohpo=5RHRFw_OfVZHAoAR-3xnUTMot6z_h=cWsFFgn=Fzw2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=5RHRFw_OfVZHAoAR-3xnUTMot6z_h=cWsFFgn=Fzw2Q@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Sascha Hauer <kernel@pengutronix.de>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 3/25/2013 3:54 PM, Viresh Kumar wrote:
> On 25 March 2013 15:11, Sekhar Nori <nsekhar@ti.com> wrote:
>> So down in the cpufreq driver probe below, we bail out if freq_table is
>> not provided. So all this checking for freq_table in the code you pasted
>> above is superfluous. If you can clean that part up and add checking for
>> cpufreq_frequency_table_cpuinfo() as you proposed, I will be glad to
>> test it out ;)
> 
> Attached is the complete patch and following is your fixup for davinci
> (just to review):

For the attached patch,

[nsekhar@ti.com: tested on da850 evm]
Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
sekhar
