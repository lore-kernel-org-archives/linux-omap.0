From: Nishanth Menon <nm@ti.com>
Subject: Re: [linux-pm] [PATCH] opp: introduce library for device-specific
 OPPs
Date: Fri, 17 Sep 2010 17:26:34 -0500
Message-ID: <4C93EB1A.7020203@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com> <20100917153643.GC29739@sirena.org.uk> <4C938EE2.1010307@ti.com> <201009180022.51011.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <201009180022.51011.rjw@sisk.pl>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, "Granados Dorado, Roberto" <x0095451@ti.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Romit Dasgupta <ro.mit@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>And
List-Id: linux-omap@vger.kernel.org

Rafael J. Wysocki had written, on 09/17/2010 05:22 PM, the following:
> On Friday, September 17, 2010, Nishanth Menon wrote:
>> Mark Brown had written, on 09/17/2010 10:36 AM, the following:
>>> On Thu, Sep 16, 2010 at 08:29:33PM -0500, Nishanth Menon wrote:
>>>
>>>> +struct opp_def {
>>>> +	unsigned long freq;
>>>> +	unsigned long u_volt;
>>>> +
>>>> +	bool enabled;
>>>> +};
>>> It might be clearer to use some term other than enabled in the code -
>>> when reading I wasn't immediately sure if enabled meant that it was
>>> available to be selected or if it was the active operating point.  How
>>> about 'allowed' (though I'm not 100% happy with that)?
>> ;).. The opp is enabled or disabled if it is populated, it is implicit 
>> as being available but not enabled- how about active? this would change 
>> the opp_enable/disable functions to opp_activate, opp_deactivate..
> 
> Would that mean that "active" is the one currently in use?

I like the idea Phil pointed out[1] on using "available" instead.. 
opp_enable and disable will make the OPP available or not. does this 
sound better?

[1] http://marc.info/?l=linux-arm-kernel&m=128474217132058&w=2
-- 
Regards,
Nishanth Menon
