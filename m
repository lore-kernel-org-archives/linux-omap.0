From: Nishanth Menon <nm@ti.com>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Mon, 6 Apr 2015 13:45:22 -0500
Message-ID: <5522D442.9090905@ti.com>
References: <5522886D.5050409@ti.com> <20150406134541.GE6023@sirena.org.uk> <55228FE0.2040702@ti.com> <20150406135829.GH4027@n2100.arm.linux.org.uk> <20150406150127.GF6023@sirena.org.uk> <5522A391.6080503@ti.com> <20150406152750.GE11160@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20150406152750.GE11160@saruman.tx.rr.com>
Sender: linux-next-owner@vger.kernel.org
To: balbi@ti.com
Cc: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/06/2015 10:27 AM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Apr 06, 2015 at 10:17:37AM -0500, Nishanth Menon wrote:
>> On 04/06/2015 10:01 AM, Mark Brown wrote:
>>> On Mon, Apr 06, 2015 at 02:58:29PM +0100, Russell King - ARM Linux wrote:
>>>> On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:
>>>
>>>>>> at least a description of the problem you're seeing and some attempt at
>>>
>>>>> Test was a simple boot test. There seems to be a lockdep reported at the
>>>>> very least in the log provided (see
>>>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
>>>>> ).
>>>
>>>> I think what Mark is trying to say is to include a fuller description of
>>>> the problem, and don't expect people to fire up their web browser to get
>>>> a basic overview of what the problem is.
>>>
>>> Yes, indeed.  I hadn't actually opened the links, I might've got round
>>> to it later on.
>>>
>>>> My guess is that the problem _appears_ to be that someone's added a call
>>>> to debug_check_no_locks_held() into schedule_hrtimeout_range_clock()
>>>> without considering what this means.
>>>
>>>> What it means is that you can't now use usleep_range() from within any
>>>> driver probe function - which is absolutely absurd.
>>>
>>> I can't think of any regulator side changes which might be relevant in
>>> that period.  It's possible that there might be something in the MFD I
>>> guess.
>>>
>>
>> Ran a few tests since my original email..
>>
>> 6261b06de565baafa590e58a531a1a5522cea0b6 ("regulator: Defer lookup of
>> supply to regulator_get") was the only patch that was introduced in
>> the interval. there seems nothing in mfd either.
>>
>> I still have the following in my log.. trying to further down.
> 
> I noticed a similar warning with AM437x SK
> 
posting intermediate debug results:

I did a bisect on the merge commits to identify which tree the
regression got introduced, looks like it is the merge from akpm tree -
I have not yet looked deeper.

b58a6c0b0808 Merge branch 'akpm-current/current'
---> FAIL http://paste.ubuntu.org.cn/2540641

ef31288bdf44 Merge remote-tracking branch 'livepatching/for-next'
--> OK -> http://paste.ubuntu.org.cn/2540778

Felipe, could you confirm on your end as well on SK (my fs does not
use systemd unfortunately)?

-- 
Regards,
Nishanth Menon
