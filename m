From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Backlight in motorola Droid 4
Date: Tue, 30 Jul 2019 13:21:11 -0500
Message-ID: <ff91f577-98ad-d27b-02c2-6ed495cf4a38@ti.com>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd> <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
 <20190724124530.GA30211@amd> <ca69f627-96e2-f982-3a29-18b0127ac6e5@ti.com>
 <edde330e-516b-ecaa-4139-0bfa766a9c08@ti.com> <20190729220030.GA20100@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729220030.GA20100@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello

On 7/29/19 5:00 PM, Pavel Machek wrote:
> Hi!
>
>>> Looking at the rest of the code.
>>>
>>> The DT doc indicated that this was a required child property so this is
>>> why it
>>>
>>> errors out.
>>>
>>> Dan
>>>
>>> <snip>
>>>
>> Did you want me to fix up the LM3532 and send the patch?
> If you could do that, that would be nice :-).

Ok I am working on this.

Is Droid4 supposed to boot off of mainline?  I see blogs stating it should

but the device locks up when it jumps to the kernel 5.3-rc1.

Unless I need to update my kexec or boot.cfg file but I cannot find any 
up to date info on that.

Dan


>
>> Or do you have a patch ready to go?
> No progress there, I'm busy with other stuff...
>
> Thanks,
> 									Pavel
>
