From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/3] gpio: twl4030: Correct status reporting for outputs
Date: Wed, 12 Dec 2012 13:47:41 +0100
Message-ID: <50C87CED.3070705@ti.com>
References: <1354791127-20545-1-git-send-email-peter.ujfalusi@ti.com> <CACRpkdYZcEpN-BJy=3DPAQL+QgR+EyNeyABtAPE96+2hYxOQwQ@mail.gmail.com> <50C86691.60005@ti.com> <CACxGe6uMabhuKAW6P+Zow3NoviM2NyYGjDh+--r9ndEyiSkdAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6uMabhuKAW6P+Zow3NoviM2NyYGjDh+--r9ndEyiSkdAg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/12/2012 12:45 PM, Grant Likely wrote:
> I will take a look at it this week

Thanks

> but I cannot pick it up for v3.8 unless it is a regression bug fix fr=
om
> v3.6. It will have to wait for v3.9 and it can be merged into linux-n=
ext
> after the v3.8 merge window closes.

3.9 is fine. the gpio-twl4030 never reported the output state correctly=
, I
just found it out while doing some cleanups around the twl-core and boa=
rd files.

Thanks,
P=E9ter
