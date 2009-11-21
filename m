From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Sat, 21 Nov 2009 13:08:18 -0600
Message-ID: <4B083AA2.8070009@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com><1258092322-30833-2-git-send-email-nm@ti.com><1258092322-30833-3-git-send-email-nm@ti.com><87vdhdncqz.fsf@deeprootsystems.com> <4B001640.5070405@ti.com><4B036526.6070500@ti.com> <87pr7e6kxc.fsf@deeprootsystems.com> <4B05FBE1.6010708@ti.com> <4B0757E7.9020706@ti.com> <74583B8642AB8841B30447520659FCA9DE207167@dnce01.ent.ti.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:40938 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbZKUTIE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Nov 2009 14:08:04 -0500
Received: by gxk26 with SMTP id 26so3810122gxk.1
        for <linux-omap@vger.kernel.org>; Sat, 21 Nov 2009 11:08:10 -0800 (PST)
In-Reply-To: <74583B8642AB8841B30447520659FCA9DE207167@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Lam, SuiLun" <s-lam@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Hi Benoit,

Thanks for your detailed review comments. few views follows

Cousson, Benoit said the following on 11/21/2009 10:07 AM:
[...]
>> /**
>>   * struct omap_opp_def - OMAP OPP Definition
>>   * @enabled: True/false - is this OPP enabled/disabled by default
>>   * @freq:    Frequency in hertz corresponding to this OPP
>>   * @m_volt:  Nominal voltage in millivolts corresponding to this OPP
>>   *
>>   * OMAP SOCs from OMAP3 onwards have a standard set of tuples consisting
>>   * of frequency and voltage pairs that the device will support. This is
>>   * Operating Point. However, the actual definitions of OMAP Operating
>> Point
>>   * varies over silicon within the same family of devices. For a specific
>>   * domain, you can have a set of {frequency, voltage} pairs and this is
>> denoted
>>   * by an array of omap_opp_def. As the kernel boots and more information
>>     
>
> The OPP term is not necessarily something new to OMAP3; OMAP2420/2430 already supported 2 OPPs (100% and 50%) and to some extend OMAP1610/1710 were also able to run at a lowest OPP (50%).
>
> To be more accurate, you should explain that the OPP is relative to a voltage domain and that all IPs in that voltage domain will have potentially their own OPPs depending of the voltage.
>
>   
Thanks for explaining the history. yep, will fix up.
>> is
>>   * available, a set of these are activated based on the precise nature of
>>   * device the kernel boots up on.
>>   *
>>   * NOTE: A disabled opp from the omap_opp_def table may be enabled as
>> part of
>>     
>
> Are you sure you want to allow that? What if you re-enable none supported OPPs like a speed-binning OPP on a regular device?
>   
Yes, we want to allow this. here is why: we provide a list of ALL opps
supported on that family of devices of which the common opp entries
(across the specific family of SOCs for which the table are enabled).
yes, there are multiple ways of doing this, one of which is to have
enable/disable opp OR to use a add function etc.. we can scale this
function as needed in the future as our experience with more dynamic
silicon decisions become solid. here are specific examples:
cpu_is_3630() will probably register all OPPs for 3630 including speed
binned one which will be by default disabled, on detecting the
speedbinned variants, OPP will be specifically enabled.

Now opp.[ch] is meant to be core functions with control of some of the
functions from elsewhere, in kernel space with un exported functions, I
do not expect to write "dumb proof code", instead I would expect to
write smart optimized code and allow other smart people's smart code use
it optimally ;).. if we screw up here (e.g. enable a wrong OPP), we need
code fixing and with this framwork it would now be easy to track and fix
as OPP access are centralized.


>   
>>   * runtime logic. It is discouraged to enable/disable the OPP unless
>> they are
>>   * done as part of OPP registration sequence.
>>     
>
> Why is it discouraged? We should have as well the capability to enable/disable dynamically and temporarily an OPP (thermal management, frequency avoidance, select different OPP sets...).
>
> You should differentiate OPPs disabled at boot time because they are not supported by the platform and the ones disabled at runtime. It will avoid that you potentially re-enable a forbidden OPP.
>
> Why don't you remove them during the opp_init phase?
>   
Discouraged IMHO you may impact rest of the today's system such as
cpufreq heuristics etc.. But, I agree with you, this is a current
limitation which is not what I should reflect in the comment - will
remove that statement.  btw, it is smarter for the higher layers to make
dynamic decisions of temp frequency avoidance without having to resort
to enable/disable OPP IMHO.
>   
>>   */
>> struct omap_opp_def {
>>       bool enabled;
>>       unsigned long freq;
>>       u16 m_volt;
>>     
>
> It might be better to use an u32 and store the voltage in microvolt considering that the T2 and Phoenix have a 12.5 mV accuracy step. Moreover, this is what the regulator framework is currently using, it will avoid the *1000 operation, which is not that a big deal, I agree...
>   
Thanks for pointing this out.. yep uV makes more sense. will switch.

>   
>> };
>>
>> /**
>>   * opp_init - Initialize an OPP table from the initial table definition
>>   * @oppl:    Returned back to caller as the opp list to reference the OPP
>>   * @opp_defs:        Array of omap_opp_def to describe the OPP. This list
>> should be
>>   *           0 terminated.
>>   *
>>   * This function creates the internal datastructure representing the
>> OPP list
>>   * from an initial definition table. this handle is then used for further
>>   * validation, search, modification operations on the OPP list.
>>   *
>>   * This function returns 0 and the pointer to the allocated list
>> through oppl if
>>   * success, else corresponding error value. Caller should NOT free the
>> oppl.
>>   * opps_defs can be freed after use.
>>   */
>> int opp_init(struct omap_opp **oppl, const struct omap_opp_def *opp_defs);
>>
>> /**
>>   * opp_enable - Enable or disable a specific OPP
>>     
>
> You'd better provide two APIs opp_enable and opp_disable or find a better name for that one, like opp_state or opp_set_state.
>   
the kernel has other xyz_enable function which does disable also. yes,
this had been debated internally, and  Kevin pointed this out.

example:
include/linux/pci.h:int pci_enable_wake(struct pci_dev *dev, pci_power_t
state, bool enable);
others: grep -R ".*enable.*(" include/|grep -v define

If someone has strong opinions on this and find this function extremely
obscure, I don't mind creating wrappers around an internal __opp_onoff
and provide and opp_enable and opp_disable. it is just a one liner anyways..
>   
>>   * @opp:     pointer to opp
>>   * @freq:    frequency in hertz
>>   * @enable:  true/false to enable/disable that specific OPP
>>   *
>>   * Enables/disables a provided freq in the opp list. If the operation
>> is valid,
>>   * this returns 0, else the corresponding error value.
>>   *
>>   * OPP used here is from the the opp_is_valid/opp_has_freq or other
>> search
>>   * functions
>>   */
>> int opp_enable(const struct omap_opp *opp, const unsigned int freq);
>>
>> #endif                /* __ASM_ARM_OMAP_OPP_H */
>>
>>     
Regards,
Nishanth Menon
