From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Mon, 6 Jul 2015 10:20:56 -0500
Message-ID: <CAL_JsqK193CBPwvDpPvpDSbGFRfkpxpox45parCoC+ofWE4hUA@mail.gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <20150506114417.GI30910@pali> <20150625050138.GL4156@atomide.com>
 <201507061423.23505@pali> <20150706123126.GG10705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150706123126.GG10705@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 6, 2015 at 7:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150706 05:25]:
>>
>> into which file should I put documentation about new DT properties?
>
> If it's Linux generic like linux,revision, then how about

Just "revision" at the top level please. I'd prefer a string still,
but either is fine.

Rob
