From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER
 from devm_usb_get_phy_by_node
Date: Tue, 8 Sep 2015 11:32:24 -0700
Message-ID: <CAMAWPa8q1BOMvvKqqU88vYq4-_QhuxefVqkM6=4BP4-FGZxRPw@mail.gmail.com>
References: <20150730001113.4012.18086.stgit@noble>
	<20150730001124.4012.31980.stgit@noble>
	<CAMAWPa__hFOuz24YBcFiR+m5mOUArSuNpuqh3Ju1H+yj6qadfA@mail.gmail.com>
	<CAMAWPa_s2ELgRBRtWzFucmREMuLXS_V5Akmad5yFU13-GrzBDA@mail.gmail.com>
	<87si6x4a2f.fsf@notabene.neil.brown.name>
	<20150902130724.GQ4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150902130724.GQ4215@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Neil Brown <neil@brown.name>, Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, lkml <linux-kernel@vger.kernel.org>, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 2, 2015 at 6:07 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Neil Brown <neil@brown.name> [150901 23:23]:
>> Kevin Hilman <khilman@kernel.org> writes:
>>
>> > ping... this boot failure has now landed in mainline
>>
>> sorry, I'm on leave at the moment and travelling so I'm unlikely to be
>> able to look at this properly.  I should be able to examine this issue
>> before the end of the month but cannot promise sooner than that (though
>> it is not impossible).
>>
>> Maybe it would be best to just revert it until a proper analysis can be
>> done.
>
> OK yeah let's revert this one for now until we know what goes wrong.

Looks like this is still in mainline.

Tony, can you revert?

Kevin
