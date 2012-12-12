From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/3] gpio: twl4030: Correct status reporting for outputs
Date: Wed, 12 Dec 2012 12:12:17 +0100
Message-ID: <50C86691.60005@ti.com>
References: <1354791127-20545-1-git-send-email-peter.ujfalusi@ti.com> <CACRpkdYZcEpN-BJy=3DPAQL+QgR+EyNeyABtAPE96+2hYxOQwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYZcEpN-BJy=3DPAQL+QgR+EyNeyABtAPE96+2hYxOQwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Grant,

On 12/07/2012 09:09 AM, Linus Walleij wrote:
> On Thu, Dec 6, 2012 at 11:52 AM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>=20
>> As Grant commneted on the first version:
>> https://lkml.org/lkml/2012/12/5/53
>>
>> Introduce bitfields to cache the directionand output status of the p=
ins so we
>> can report them correctly.
>> To do this I did some cleanup within the driver to get rid of the gl=
obal
>> variables and moved them under a private structure, changed the lock=
ing as well
>> to protect the bitfield operation.
>> As a last patch I added a note that the PWMA/B handling should not b=
e in this
>> driver at all.
>=20
> This looks good to me:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Since Grant was requesting the changes I'll let him decide to merge.

Would you have time to take a look at this set?

Thanks,
P=E9ter
