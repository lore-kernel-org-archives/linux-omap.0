From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to program
 pbias regulator
Date: Tue, 1 Sep 2015 17:01:21 +0530
Message-ID: <55E58C89.3030000@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com> <1437996250-2913-2-git-send-email-kishon@ti.com> <20150814180006.GB10748@sirena.org.uk> <55D2C872.9000400@ti.com> <20150819181149.GZ10748@sirena.org.uk> <55DC3D58.4030409@ti.com> <20150825135044.GJ27431@sirena.org.uk> <55E42FF7.9010706@ti.com> <20150831145249.GO12027@sirena.org.uk> <55E5727E.1040103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55E5727E.1040103@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Now fixed Lee Jones mail address!

On Tuesday 01 September 2015 03:10 PM, Kishon Vijay Abraham I wrote:
> Hi Mark,
> 
> On Monday 31 August 2015 08:22 PM, Mark Brown wrote:
>> On Mon, Aug 31, 2015 at 04:14:07PM +0530, Kishon Vijay Abraham I wrote:
>>> On Tuesday 25 August 2015 07:20 PM, Mark Brown wrote:
>>>> On Tue, Aug 25, 2015 at 01:03:04PM +0300, Grygorii Strashko wrote:
>>>>> On 08/19/2015 09:11 PM, Mark Brown wrote:
>>
>>>>>> So substract this address from the start of the resource to get the
>>>>>> offset?  Or provide a wrapper function in the resource code which does
>>>>>> that.  
>>>>
>>>>> I'd be very appreciated if you have and can share any thought on
>>>>> How can we get this absolute base address to substract?
>>>>
>>>> Ask the syscon device for its resource?  Or have it provide an absolute
>>>
>>> Even if we get the absolute address of syscon, we have to do the
>>> subtraction only for the newer dtbs (previous dtbs already have only the
>>> offset). Do you recommend adding a new property to differentiate between
>>> older dtbs and newer dtbs? Any other suggestions here?
>>
>> Hang on.  This is the first I've heard of any DTs not just having
>> absolute addresses.  How does any of this work - has it ever worked, and
>> is the situation completely understood?  My original concern with this
> 
> Before commit d919501feffa8715147582c3ffce96fad0c7016f ARM: dts: dra7:
> add minimal l4 bus layout with control module support, the dt was like
> 
> ocp {
> 	dra7_ctrl_general: tisyscon@4a002e00 {
> 		compatible = "syscon";
> 		reg = <0x4a002e00 0x7c>;
> 	};
> 
> 	pbias_regulator: pbias_regulator {
> 		compatible = "ti,pbias-omap";
> 		reg = <0 0x4>;
> 		syscon = <&dra7_ctrl_general>;
> 	};
> };
> 
> Here platform_get_resource in pbias driver returns '0' which is
> populated in vsel_reg and enable_reg. And regulator_enable_regmap uses
> the base address from tisyscon@4a002e00 which is '0x4a002e00' and offset
> from enable_reg which is '0' inorder to write to the pbias register.
> 
> But after commit d919501fef, the dt became like this (after a couple of
> fixes)
> 
> ocp {
> 	l4_cfg: l4@4a000000 {
> 		compatible = "ti,dra7-l4-cfg", "simple-bus";
> 		ranges = <0 0x4a000000 0x22c000>;
> 
> 		scm: scm@2000 {
> 			compatible = "ti,dra7-scm-core", "simple-bus";
> 			reg = <0x2000 0x2000>;
> 			ranges = <0 0x2000 0x2000>;
> 
> 			scm_conf: scm_conf@0 {
> 				compatible = "syscon", "simple-bus";
> 				reg = <0x0 0x1400>;
> 				ranges = <0 0x0 0x1400>;
> 
> 				pbias_regulator: pbias_regulator {
> 					compatible = "ti,pbias-omap";
> 					reg = <0xe00 0x4>;
> 					syscon = <&scm_conf>;
>                                 };
> 			};
> 		};
> 	};
> };
> 
> Here platform_get_resource in pbias driver returns '4a002e00' which is
> populated in vsel_reg and enable_reg. And regulator_enable_regmap uses
> the base address from scm_conf@0 which is '0x4a002000' and offset from
> enable_reg which is '4a002e00' inorder to write to the pbias register
> and it results in a abort.
> 
>> was that I coudn't understand the commit log and your original response
>> seemed to indicate that we always have the absolute address :(  Perhaps
> 
> We started having the absolute address only after the dt change (commit
> d919501fef and a couple of more dt fixes).
> 
>> this is something to do with the brief mention of having moved the DT
>> node for some reason?
>>
>> We at least need some sort of coherent explanation of the problem and a
>> comprehensible fix to go with it.  Right now it seems like things are
>> just being moved about to hide problems without either of these things
>> which seems like it makes the code less clear and more fragile.
> 
> hmm.. IMO the actual problem was modelling the 'offset' as a resource
> (by populating the offset in 'reg' property) which was added when the
> initial pbias dt node was created. And now since the pbias dt node is
> being moved around, it's causing inadvertent address translation
> breaking the pbias driver. IMHO the value in 'reg' property of pbias dt
> node should be treated as 'offset' instead of address 'resource' and
> that's what my patch tried to do.
>>
>>>> address based interface for that matter?
>>
>>> Syscon doesn't directly expose any API's to write to it's register.
>>> Rather it uses regmap APIs to read/write to it's register. I'm not sure
>>> if it's possible to add regmap APIs to write to a register with absolute
>>> address. Any hints?
>>
>> Yes, I'm aware that it is regmap based!  What I am suggesting is that if
>> people are making DTs like yours with devices that are children of the
>> syscon then presumably it might be useful for it to allow client drivers
>> to pass absolute addresses in so that it can translate for them.
> 
> Arnd, Lee?
> 
> Thanks
> Kishon
> 
