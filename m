From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Sat, 12 Nov 2016 09:03:42 +0100
Message-ID: <3ca04742-6376-5a88-8d10-5b88fcd8f5e5@redhat.com>
References: <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd> <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd> <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd> <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <20161111221224.GB10983@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20161111221224.GB10983@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 11-11-16 23:12, Pavel Machek wrote:
> Hi!
>
> Reason #1:
>
>>>> Hmm. So userland can read the LED state, and it can get _some_ value
>>>> back, but it can not know if it is current state or not.

That is not correct, the current behavior for eading the brightness
atrribute is to always return the current state.

>> Why a dedicated file? Are we going to mirror brightness here
>> wrt r/w (show/store) behavior ? If not userspace now needs
>> 2 open fds which is not really nice. If we are and we are
>> not going to use poll for something else on brightness itself
>> then why not just poll directly on brightness ?
>
> Reason #1 is above.

See my reply above.

> Reason #2 is "if userspace sees brightness file, it can not know if
> the notifications on change actually work or not".

If it needs to know that it can simply check the kernel version.

> Reason #3 is that you broke Tony's system. Polling does not make sense
> when trigger such as "CPU in use" is active.

Have you seen v4 of my patch? It fixes this while keeping the
polling on the brightness attribute itself, it basically goes
back (more or less) to v1 of my patch which did not have this
problem. I never wanted notification of trigger / blinking
changes because I already feared Tony's problem would happen.

> Reason #4 is that there are really two brightnesses:
>
> 1) maximum brightness trigger is going to use
>
> 2) current brightness
>
> Currently writing to "brightness" file changes 1), but reading returns
> 2) when available.

Right and Jacek has already said that we cannot change the
reading behavior on the brightness file because of ABI concerns.

So if anything we need a new blink_brightness file or such,
which when read shows the maximum brightness when blinking or
triggers are active. Note that we already have a max_brightness
file which is the actual maximum brightness the led supports.

Since the existing ABI behavior is for the existing brightness
file to return the *current* brightness, please explain to me
how polling on say the new blink_brightness file would make
sense to detect changes in the current brightness ?

> So, feel free to propose better interface. One that solves #1..#4
> above.

Proposal 1:

v4 of my patch, see the list. It solves all but #4, which
is out of scope for my patch, feel free to submit a patch to
solve #4 (with a new sysfs attr).

Proposal 2:

Add a new "user_brightness" file, which shows the last brightness
as set by the user, this would show the read behavior we really
want of brightness: show the real brightness when not blinking /
triggers are active, show the brightness used when on when
blinking / triggers are active.

And then we could add poll support on this new user_brightness
file, thus avoiding the problem with the extra cpu-load on
notifications on blinking / triggers.

Regards,

Hans
