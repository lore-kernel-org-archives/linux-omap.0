From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi,
 regulator and mmc DTS updates
Date: Mon, 16 Apr 2012 22:29:58 +0200
Message-ID: <4F8C8146.6070603@ti.com>
References: <4F612C29.40608@ti.com> <20120315004638.GW12083@atomide.com>
 <201203150801.13183.arnd@arndb.de> <4F746CC0.9050507@ti.com>
 <CAOesGMg+xLrVNxF0XwO8poAtuduwEcxrXLN9pXa+T+y7kKMy7Q@mail.gmail.com>
 <CAOesGMjJMgQF9jUUUMbm22oaEzan6eLW+-kWN9iB85buJxp4Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMjJMgQF9jUUUMbm22oaEzan6eLW+-kWN9iB85buJxp4Dg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Olof,

On 4/15/2012 3:19 AM, Olof Johansson wrote:
> Benoit, Tony,
>
> On Thu, Mar 29, 2012 at 11:31 AM, Olof Johansson<olof@lixom.net>  wrote:
>> On Thu, Mar 29, 2012 at 7:08 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>> FYI, MMC DT adaptation just got merged, I2C, GPIO, SPI, regulator DT
>>> adaptation were already merged before, so it means that this branch can be
>>> merged to take advantage of all the DT adapted drivers.
>>
>> I've pulled this in as late/omap-dt, included in next/dt3 and
>> for-next. I'll let it sit in linux-next for at least one day before
>> it's sent in. Since it's just device tree additions, risk for
>> regressions should be low.
>
> As you've noticed, this didn't make it into 3.4 due to the window
> closing early. :(

Yes, I did :-(

> I've renamed the branch in arm-soc to omap/dt-missed-3.4 and merged it
> into next/dt for the 3.5 merge window.

OK, cool, I was about to ping you about that series. I'll then be able 
to use it as a stable base for further OMAP DT patches.

Thanks,
Benoit
