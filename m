From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
Date: Wed, 15 Nov 2017 18:13:51 +0100
Message-ID: <2CFA9F17-0E65-4804-9971-922500F5E919@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
 <9b4969c858d4c3801bb796f92dad5c580799b768.1510759152.git.hns@goldelico.com>
 <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
 <DC57A290-669C-4B3C-A4EE-2ABEA37F47CE@goldelico.com>
 <20171115164257.2mbbk7yqhq3puc5a@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171115164257.2mbbk7yqhq3puc5a@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, =?iso-8859-2?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, letux-kernel@openphoenux.org, Thierry Reding <treding@nvidia.com>, =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Ladislav,

> Am 15.11.2017 um 17:42 schrieb Ladislav Michl <ladis@linux-mips.org>:
> =

> On Wed, Nov 15, 2017 at 05:29:25PM +0100, H. Nikolaus Schaller wrote:
>> Hi Andreas,
>> =

>>> Am 15.11.2017 um 16:53 schrieb Andreas F=E4rber <afaerber@suse.de>:
>>> =

>>> Hi,
>>> =

>>> Am 15.11.2017 um 16:19 schrieb H. Nikolaus Schaller:
>>>> This allows to set CONFIG_W2SG0004_DEBUG which will
>>>> make the driver report more activities and it will turn on the
>>>> GPS module during boot while the driver assumes that it
>>>> is off. This can be used to debug the correct functioning of
>>>> the hardware. Therefore we add it as an option to the driver
>>>> because we think it is of general use (and a little tricky to
>>>> add by system testers).
>>>> =

>>>> Normally it should be off.
>>>> ---
>>> =

>>> If you want to merge this, it is lacking a Sob.
>> =

>> Whats is a "Sob" in this context (https://acronyms.thefreedictionary.com=
/SOB)?
> =

> https://acronyms.thefreedictionary.com/Signed-Off-By

Ah, ok. Too obvious to associate :) Tnx.

I did never think about that this could be missing. And I don't know why :(

> Also please read Documentation/process/submitting-patches.rst

We have automated things by calling checkpatch but it somwhow failed here.

BR and thanks,
Nikolaus
