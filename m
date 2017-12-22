From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v5 5/5] misc serdev: w2sg0004: add debugging code and Kconfig
Date: Fri, 22 Dec 2017 15:41:24 +0100
Message-ID: <A2720858-5172-4627-8133-C677E4B4DC72@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com> <5816bfb9e7cab68591c133e20696d6188ebe70de.1512114577.git.hns@goldelico.com> <20171222125150.GJ3374@localhost>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171222125150.GJ3374@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@baylibre.com>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


> Am 22.12.2017 um 13:51 schrieb Johan Hovold <johan@kernel.org>:
> 
> On Fri, Dec 01, 2017 at 08:49:38AM +0100, H. Nikolaus Schaller wrote:
>> This allows to set CONFIG_W2SG0004_DEBUG which will
>> make the driver report more activities and it will turn on the
>> GPS module during boot while the driver assumes that it
>> is off. This can be used to debug the correct functioning of
>> the hardware. Therefore we add it as an option to the driver
>> because we think it is of general use (and a little tricky to
>> add by system testers).
>> 
>> Normally it should be off.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/misc/Kconfig    |  8 ++++++++
>> drivers/misc/w2sg0004.c | 37 +++++++++++++++++++++++++++++++++++++
>> 2 files changed, 45 insertions(+)
> 
> I'd say say this does not belong in the kernel at all.

There are other examples of such DEBUG options for drivers.
E.g. CONFIG_LIBERTAS_DEBUG.

It helps the hardware developer to test things and should of course
be disabled in a production kernel.

During hardware bringup I am always happy if someone else has shared
such tools instead of omitting them. So that we do not have to invent
them (again) and hack into our own kernel.

Of course, this should be discussed and you are open to take it
or leave it.

> And even if the
> power-state test were to be allowed, most of the pr_debugs would
> need to go.

I see.

"/* If you are writing a driver, please use dev_dbg instead */"

Well, nobody actively reads this comment in the header file...
Maybe checkpatch could be teached to warn?

> You really should be using dev_dbg and friends, which can
> already be enabled selectively at run time using dynamic debugging.

Well, in this case it is not needed to dynamically turn it on/off.

BR and thanks,
Nikolaus Schaller
