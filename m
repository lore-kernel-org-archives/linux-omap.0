From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH] ARM: dts: AM437x GP EVM support
Date: Wed, 13 Nov 2013 12:34:29 +0530
Message-ID: <5283247D.7010106@ti.com>
References: <1384255468-2453-1-git-send-email-afzal@ti.com> <20131112142206.GD31721@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131112142206.GD31721@saruman.home>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <bcousson@baylibre.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tuesday 12 November 2013 07:52 PM, Felipe Balbi wrote:
> On Tue, Nov 12, 2013 at 04:54:26PM +0530, Afzal Mohammed wrote:
>> From: Lokesh Vutla <lokeshvutla@ti.com>

>> AM437x GP EVM DTS with pinmux information to make I2C on EVM usable.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>

> could you instead send the much more complete version we already have
> at [1] ? It's pointless to repatch all of that in this file if we *know*
> those are already working.

By taking those changes and testing on mainline, I couldn't get mmc
working and was not confident about ethernet changes, I2C changes were
verified and boot test was done (with DT clock series). I posted only
the changes that I felt confident.

Basic DT file and I2C are dependency for others, it was necessary to
remove dependencies at the earliest.

Regards
Afzal

> [1] http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tree/arch/arm/boot/dts/am437x-gp-evm.dts?h=ti-linux-3.12.y


