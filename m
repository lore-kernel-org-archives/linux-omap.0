From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
Date: Sat, 30 Jan 2016 15:51:06 +0100
Message-ID: <CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
	<1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx) <drivshin.allworx@gmail.com>:
> From: David Rivshin <drivshin@allworx.com>
>
> After going through the math and constraints checking to compute load and
> match values, it is helpful to know what the resultant period and duty
> cycle are.
>
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
>
> I found this helpful while testing the other changes, so I included it in
> case it may be of use to someone in the future. I would have no issues with
> dropping this if it's not considered worthwhile.

It's useful, but converting it as a sysfs attribute would be great !


Neil
