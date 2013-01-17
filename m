From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] gpio: twl4030: Cache the direction and output states
 in private data
Date: Thu, 17 Jan 2013 14:45:07 +0100
Message-ID: <50F80063.5080803@ti.com>
References: <1355996651-17805-1-git-send-email-peter.ujfalusi@ti.com> <CACRpkdZK8AA-osijVpbp7U-Wv0XUAVxDPQ3zxfCqWYb6WKjmwQ@mail.gmail.com> <50EEBD8F.6040101@ti.com> <CACRpkdaj5mKk3hy9_QmjcDw3KhZt1Zdx1CXB6ZWmvbhhRWyndA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaj5mKk3hy9_QmjcDw3KhZt1Zdx1CXB6ZWmvbhhRWyndA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Michael Trimarchi <michael@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On 01/17/2013 11:43 AM, Linus Walleij wrote:
> On Thu, Jan 10, 2013 at 2:09 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>> On 01/10/2013 11:41 AM, Linus Walleij wrote:
>=20
>>> Sorry Peter this must have been missed somehow.
>>>
>>> This does not apply to the current v3.8-rc3, could you respin
>>> this on top of Torvalds' tree?
>>
>> Grant applied the patch which this one depends on:
>> [1] https://patchwork.kernel.org/patch/1844511/
>=20
> Hm, it is not in mainline, nor on Grant's "merge" or "next"
> branches so it must have fallen on the floor somehow.
>=20
> I applied both the patches not, thanks!

Thank you, I was planning to go through my pending patches tomorrow and=
 resend
or annoy maintainers with them.

Thanks again,
P=E9ter
