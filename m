From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 0/5] ATAGs to DT patches
Date: Fri, 27 Nov 2015 21:55:31 -0800
Message-ID: <565941D3.3080405@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com> <5659282F.8020104@gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5659282F.8020104@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/27/2015 8:06 PM, Frank Rowand wrote:
> On 7/6/2015 1:26 PM, Pali Roh=C3=A1r wrote:
>> This patch series converts some legacy ATAGs into DT and provide the=
m to
>> userspace. It is needed for userspace applications which needs some
>> informations from legacy bootloaders which are not DT compatible.
>>
>> Patch series is for now without DT documentation files. It was teste=
d in
>> QEMU for Nokia N900. File /proc/cpuinfo contains correct "Revision" =
line
>> from ATAG_REVISION and /proc/atags contains full ATAGs structure.
>=20
> Pali,
>=20
> Is this needed just for the N900, or are there other devices that nee=
d it?
> If so, which devices?

Nevermind...  I've re-read the earlier threads.

-Frank
