From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Wed, 18 Sep 2019 11:37:47 +0200
Message-ID: <caf10e4e-c688-cdb7-7d0d-7a030923a194@linaro.org>
References: <20190912183037.18449-1-aford173@gmail.com>
 <51bb8890-bfd7-c241-1ce5-151df3a90513@linaro.org>
 <CAHCN7xKjwkJHysSkNymF=sw6KuS=FqbapuRFZODuj6E_hmRG1A@mail.gmail.com>
 <2ef812a4-2f2d-b2e2-9fa4-080775e24bc8@linaro.org>
 <20190918092418.que4c5jpcn2dcavx@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190918092418.que4c5jpcn2dcavx@vireshk-mac-ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Adam Ford <aford173@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Andr=c3=a9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

On 18/09/2019 11:24, Viresh Kumar wrote:
> On 13-09-19, 00:33, Daniel Lezcano wrote:
>>
>> Hi Adam,
>>
>> On 12/09/2019 23:19, Adam Ford wrote:
>>> On Thu, Sep 12, 2019 at 4:12 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 12/09/2019 20:30, Adam Ford wrote:
>>>>> The thermal sensor in the omap3 family isn't accurate, but it's
>>>>> better than nothing.  The various OPP's enabled for the omap3630
>>>>> support up to OPP1G, however the datasheet for the DM3730 states
>>>>> that OPP130 and OPP1G are not available above TJ of 90C.
>>>>>
>>>>> This patch configures the thermal throttling to limit the
>>>>> operating points of the omap3630 to Only OPP50 and OPP100 if
>>>>> the thermal sensor reads a value above 90C.
>>
>> Oh, that's a very interesting use case.
>>
>> AFAICT the thermal framework is not designed to deal with this
>> situation. I agree this setup may work (even if I'm not convinced about
>> the stability of the whole).
>>
>> May be Viresh can help for the cpufreq side?
> 
> Sorry but I am not able to understand what's not supported by thermal framework
> here and what can I do to help :)

The solution of preventing running above the 90°C by changing the OPPs
is fine and works. It is a way of workaround the spec.

But AFAIU, the specs of the board say the OPPs 800MHz and 1GHz are only
permitted during an amount of time above 90°C which makes the constraint
inverted and recall somehow the 'turbo-mode' description:

"
- turbo-mode: Marks the OPP to be used only for turbo modes. Turbo mode
is available on some platforms, where the device can run over its
operating frequency for a short duration of time limited by the device's
power, current and thermal limits.
"

This is where I thought you can give an input.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
