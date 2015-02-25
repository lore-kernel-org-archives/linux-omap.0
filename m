From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 8/8 v2] ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider
 bug
Date: Wed, 25 Feb 2015 19:17:57 +0200
Message-ID: <54EE03C5.2090306@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-8-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDFF20.6030103@ti.com> <54EE0138.7020300@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE0138.7020300@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rabel@cit-ec.uni-bielefeld.de, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Robert,

On 25/02/15 19:07, Robert Abel wrote:
> Hi Roger,
> 
> On 25 Feb 2015 17:58, Roger Quadros wrote:
>>> static unsigned int gpmc_ticks_to_ps(unsigned int ticks)
>>> @@ -346,16 +395,22 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
>>>    * @st_bit  Start Bit
>>>    * @end_bit End Bit. Must be >= @st_bit.
>>>    * @name    DTS node name, w/o "gpmc,"
>>> + * @cd      Clock Domain of timing parameter.
>>> + * @shift   Parameter value left shifts @shift, which is then printed instead of value.
>>>    * @raw     Raw Format Option.
>>>    *          raw format:  gpmc,name = <value>
>>>    *          tick format: gpmc,name = <value> /&zwj;* x ticks *&zwj;/
>>>    * @noval   Parameter values equal to 0 are not printed.
>>> - * @shift   Parameter value left shifts @shift, which is then printed instead of value.
>>>    *
>>>    */
>>> -static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>>> -                   bool raw, bool noval, int shift,
>>> -                   const char *name)
>>> +static int get_gpmc_timing_reg(
>>> +    /* timing specifiers */
>>> +    int cs, int reg, int st_bit, int end_bit,
>>> +    const char *name, const enum gpmc_clk_domain cd,
>>> +    /* value transform */
>>> +    int shift,
>>> +    /* format specifiers */
>>> +    bool raw, bool noval)
>> now that you are rearranging the parameters, "name" parameter should probably be
>> at the same position (or last) in get_gpmc_timing_reg() and set_gpmc_timing_reg()?
>> Also clock domain (cd) position could be matched if possible.
> I rearranged them primarily, because I wanted to group the specifiers according to function, because I found it unnatural to add clock domain to the end, when it's "more important" than the format specifiers.
> set_gpmc_timing_reg are fine in that regard as it doesn't have format specifiers.

OK.

>>> +/**
>>> + * set_gpmc_timing_reg - set a single timing parameter for Chip Select Region.
>>> + * @cs      Chip Select Region.
>>> + * @reg     GPMC_CS_CONFIGn register offset.
>>> + * @st_bit  Start Bit
>>> + * @end_bit End Bit. Must be >= @st_bit.
>>> + * @time    Timing parameter in ns.
>>> + * @cd      Timing parameter clock domain.
>>> + * @name    Timing parameter name.
>>> + * @note    Caller is expected to have initialized CONFIG1 GPMCFCLKDIVIDER
>> @note is not a parameter.
> Well no, note's a note. This is a doxygen-style comment, so tools should put a note in the created documentation. Doxygen will put a box with yellow background, for instance.

Oh ok.

>>> -        pr_err("%s: GPMC error! CS%d: %s: %d ns, %d ticks > %d\n",
>>> +        pr_err("%s: GPMC CS%d: %s %d ns, %d ticks > %d ticks\n",
>> any reason for removing the "error!" string?
> It's already pr_err, the "error!" in-between "GPMC CS%d" made it hard to read and there's a WARN after that statement in all cases, because a child _must_ fail if a timing parameter constraint is broken.

How will the user know by looking at the kernel log that it was really an error?
We don't fail probe if set_gpmc_timing_reg() fails so I feel it is necessary to
clearly show an Error message.

You can probably reword it like "%s: Error!! GPMC CS %d..."

cheers,
-roger
