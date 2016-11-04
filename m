From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval property query
Date: Fri, 4 Nov 2016 13:39:19 -0700
Message-ID: <CAKzfze_FrerJF6JOjVJ2XdyJgPm9OkEziX+oVOr7Aix3N31anw@mail.gmail.com>
References: <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd> <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
 <20161031213846.GA21014@amd> <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
 <20161102082206.GE21488@amd> <CAKzfze8d_MZJzR1a6rbwVXCWhb30C5GqFamUt2Viw1CzvyaQxw@mail.gmail.com>
 <20161104070955.GA3679@amd> <20161104145855.GH21430@atomide.com> <20161104202924.GA6841@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161104202924.GA6841@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Matt Ranostay <matt@ranostay.consulting>, pali.rohar@gmail.com, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, =?UTF-8?B?TWlja3Vsw6HFoSBRd2VydHo=?= <abcloriens@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 4, 2016 at 1:29 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2016-11-04 07:58:55, Tony Lindgren wrote:
>> * Pavel Machek <pavel@ucw.cz> [161104 00:10]:
>> > On Thu 2016-11-03 22:00:56, Matt Ranostay wrote:
>> > Do you actually have hardware with more than one bq27xxx?
>>
>> I can at least see the twl4030 battery/charger features
>> being used together with some bq device to monitor the
>> battery state. Not sure if that counts as multiple
>> instances here though :)
>
> I have that, too, but that was not what i was asking.
>
> Matt wanted support for different polling intervals on different
> bq27xxx chips. I'd like to know know if he actually has more than one
> bq27xxx in his device...
>

Actually only one bq27xxx chip but in theory we could have more.

> Best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
