From: Christ van Willegen <cvwillegen@gmail.com>
Subject: Re: [Gta04-owner] [PATCH 10/13] twl4030_charger: add software
 controlled linear charging mode.
Date: Tue, 15 Sep 2015 14:08:55 +0200
Message-ID: <CA+Ot1Ow8d8Q+U6oFKibWiPHLcua5WknFbZy0PEsU36ONas=7UQ@mail.gmail.com>
References: <20150730001113.4012.18086.stgit@noble> <20150730001124.4012.27784.stgit@noble>
 <20150915112825.GA10704@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150915112825.GA10704@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
Cc: NeilBrown <neil@brown.name>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

On Tue, Sep 15, 2015 at 1:28 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2015-07-30 10:11:24, NeilBrown wrote:
>>
>> Add a 'continuous' option for usb charging which enables
>> the "linear" charging mode of the twl4030.
>>
>> Linear charging does a good job with not-so-reliable power sources.
>> Auto mode does not work well as it switches off when voltage drops
>> momentarily.  Care must be taken not to over-charge.
>
> Can you explain how the user can "care not to over-charge"?

Just my $0.02, I assumed (whoops!) that Neil mean that the _code_
should take care not to over-charge... but not sure how he intended to
to that.

Anyway, that was my interpretation of the (indeed, it could be
explained in different ways...) comment.

Christ van Willegen
