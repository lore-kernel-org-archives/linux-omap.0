From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] gpio: twl4030: Cache the direction and output states
 in private data
Date: Thu, 10 Jan 2013 14:09:35 +0100
Message-ID: <50EEBD8F.6040101@ti.com>
References: <1355996651-17805-1-git-send-email-peter.ujfalusi@ti.com> <CACRpkdZK8AA-osijVpbp7U-Wv0XUAVxDPQ3zxfCqWYb6WKjmwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZK8AA-osijVpbp7U-Wv0XUAVxDPQ3zxfCqWYb6WKjmwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Michael Trimarchi <michael@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On 01/10/2013 11:41 AM, Linus Walleij wrote:
> On Thu, Dec 20, 2012 at 10:44 AM, Peter Ujfalusi <peter.ujfalusi@ti.c=
om> wrote:
>=20
>> Use more coherent locking in the driver. Use bitfield to store the G=
PIO
>> direction and if the pin is configured as output store the status al=
so in a
>> bitfiled.
>> In this way we can just look at these bitfields when we need informa=
tion
>> about the pin status and only reach out to the chip when it is neede=
d.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi Grant,
>>
>> Changes sicne v2:
>> - Fixed the mutex_unlock found by Michael.
>> - Removed the debug prints addedd by v2 patch (remains from debuggin=
g)
>> - Removed one blank line between includes and the first comment sect=
ion.
>=20
> Sorry Peter this must have been missed somehow.
>=20
> This does not apply to the current v3.8-rc3, could you respin
> this on top of Torvalds' tree?

Grant applied the patch which this one depends on:
[1] https://patchwork.kernel.org/patch/1844511/

Not sure where.
There were a third patch in v2 as well. I'm not sure about the status o=
f that.

[1] + this patch applies cleanly on top of mainline.

Should I resend the series as v4 for your convenience?

--=20
P=E9ter
