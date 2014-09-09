From: Nishanth Menon <nm@ti.com>
Subject: Re: [resend PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device
 Tree
Date: Tue, 9 Sep 2014 08:04:49 -0500
Message-ID: <540EFAF1.40703@ti.com>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com>	<20140908193440.GC12150@kahuna>	<540EE4B0.70207@ti.com> <CAGo_u6riiMVTW2y1qZWdJ2QUVdxX7uZyaTO3tRTGivX8Pjni1w@mail.gmail.com> <540EF904.5070701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <540EF904.5070701@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, dt list <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 09/09/2014 07:56 AM, Mugunthan V N wrote:
> On Tuesday 09 September 2014 05:45 PM, Nishanth Menon wrote:
>> On Tue, Sep 9, 2014 at 6:29 AM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>>>
>>>> Sorry this is now blocked inside TI. could you explain the testing done
>>>> for sleep state? did you attempt sleep mode before testing this?
>>>>
>>>
>>> I have not tested sleep mode, just tested boot and ping test.
>>
>> I must NAK then for the reason that this is a patch that is just build
>> tested and is not tested for the feature it claims to introduce.
>>
>>
> 
> Is suspend/resume supported in mainline, i was not able to test it.
> 
> root@dra7xx-evm:~# echo mem > /sys/power/state
> -sh: echo: write error: Invalid argument
> 
> I was not able to use rtc wake also as the rtc device is not created.

Right.. that is why I was curious how you posted a patch that
supposedly supports sleep pin configurations in a kernel that does not
support suspend-resume?

Hopefully we will have it supported in 3.18 kernel[1] - still need out
of tree wakeup timer patch[2] for testing though..

If you have at least tested on relevant branch which has the feature
expected for 3.18, I might still be OK with the patch.

[1]http://marc.info/?l=linux-kernel&m=141019565513129&w=2 and
http://marc.info/?l=linux-kernel&m=141019566913133&w=2
[2] details in http://marc.info/?l=linux-kernel&m=140871637106555&w=2

-- 
Regards,
Nishanth Menon
