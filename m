From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 06:14:57 -0800
Message-ID: <74f6b75a-66b0-789f-658b-0e9f5cfed5a8@roeck-us.net>
References: <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface> <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <20170127110947.GA5335@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127110947.GA5335@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, fabio.estevam@nxp.com, Zhang Rui <rui.zhang@intel.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 01/27/2017 03:09 AM, Pavel Machek wrote:
>
>>> If this is the case, you'd better set
>>> (struct thermal_zone_params)->no_hwmon when registering the thermal
>>> zone device, in which case, the hwmon device will not be created.
>>>
>>> In fact, I'd prefer to change tzp->no_hwmon to tzp->hwmon to not create
>>> hwmon I/F by default, and see if there is anyone using it. If yes, we
>>> can set the flag in soc thermal driver, explicitly, at meantime, a
>>> hwmon compatible name is required.
>>>
>>> But one foreseeable result is that we may get bug reports from end user
>>> that some sensors (acpitz, etc) are gone in 'sensors' output. And TBH,
>>> I'm not quite sure if this can be counted as a regression or not.
>>>
>>
>> That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
>> the ABI Police, but taking the entire device away is ok.
>
> Stop trying to break other people's systems. Thanks you.
>
You still have not shown that it does. Actually, I am trying to _fix_
other people's systems (those using libsensors).

Guenter
