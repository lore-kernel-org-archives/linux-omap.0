From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
Date: Sun, 18 Aug 2019 17:06:05 +0300
Message-ID: <87h86elgaa.fsf@tynnyri.adurom.net>
References: <20190818104629.GA27360@amd>
        <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
        <20190818114332.GA32205@amd>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190818114332.GA32205@amd> (Pavel Machek's message of "Sun, 18
        Aug 2019 13:43:32 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>, "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> On Sun 2019-08-18 12:53:01, Michael Nazzareno Trimarchi wrote:
>> Hi
>> 
>> On Sun, Aug 18, 2019 at 12:46 PM Pavel Machek <pavel@ucw.cz> wrote:
>> >
>> > Hi!
>> >
>> > First, I guess I should mention that this is first time I'm attempting
>> > to get wifi going on D4.
>> >
>> > I'm getting this:
>> >
>> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
>> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
>> > user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
>> > wlan0     Interface doesn't support scanning.
>> >
>> 
>> Try to use iw command. iwlist use an obsolete interface that you need
>> to activate in kernel for back compatibility with old command. Can be
>> your problem?
>
> Let me see ... CONFIG_CFG80211_WEXT was not set.
>
> Tried enabling it, and now I got. I remember getting it before,
> too... let me try few more boots, perhaps it is random.

>From developers' point of view WEXT is ancient and untested, everybody
should switch to nl80211. So I strongly using iw (which uses nl80211).
Of course this nothing to do with the wlcore warning you saw, just
wanted to make you aware the state of wireless extensions.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
