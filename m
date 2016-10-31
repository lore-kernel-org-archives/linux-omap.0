From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval property query
Date: Mon, 31 Oct 2016 13:22:18 -0700
Message-ID: <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd> <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2016 at 11:47 AM, Matt Ranostay <mranostay@gmail.com> wrote:
> On Mon, Oct 24, 2016 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
>>> Pavel + Sebastian this is the patchset that need I some input on :)
>>
>> Better then previous one.
>>
>> But my version of bq27xxx_battery.c already contains this:
>
> This is for allowing udev rule to set the properties as well.
> otherwise a kinda crude RUN = " echo value >
> /sys/module/bq27xxx_battery/parameters/poll_interval" is required.

Any thoughts on this?

Thanks,

Matt


>
>>
>> static const struct kernel_param_ops param_ops_poll_interval = {
>>         .get = param_get_uint,
>>         .set = poll_interval_param_set,
>> };
>>
>> ...so it should be possible to set poll interval already.
>>
>>                                                                         Pavel
>>
>> --
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
