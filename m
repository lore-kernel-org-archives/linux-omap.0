From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 06:13:43 -0800
Message-ID: <37154fca-5cfd-7f65-0f9b-14b979a094e6@roeck-us.net>
References: <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
 <20170127111626.GB5335@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170127111626.GB5335@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org

On 01/27/2017 03:16 AM, Pavel Machek wrote:
> Hi!
>
>>>> That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
>>>> the ABI Police, but taking the entire device away is ok.
>
> Changing bq27200-0 to bq27200_0 is forbidden in -rc6 time. If you
> believe noone depends on the name, argue your case, and it might be
> possible to change it in -rc0.
>
> If someone uses the name, they care about the device, and you can't
> take it away.
>
>>> No. IMO, it depends on if the interface is used or not.
>>> If hwmon I/F is used, we can not take it away, nor change its name.
>>
>> Even if the use doesn't depend on that name ?
>
> If the use doesn't depend on the name, you may get away with changing
> the name. (But not in -rc6.)
>
>>> If thermal zone I/F is used, we can not change it's 'type' name to be
>>> compatible with new hwmon API.
>>
>> You mean you can not fix the name to be compatible with libsensors.
>>
>> Makes me wonder if there shouldn't be a rule that exploits must not
>> be fixed if already exploited.
>
> That is not useful argumentation.

Oh, but it is. Providing a valid name is a bug fix for me. For you it is
an ABI change. So the ultimate question is what counts as an ABI change
and what counts as a bug fix.

Guenter
