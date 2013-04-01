From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Mon, 1 Apr 2013 13:01:44 +0300
Message-ID: <CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
	<CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
	<alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Apr 1, 2013 at 12:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Mon, 1 Apr 2013, Alexey Pelykh wrote:
>
>> Actually, I've tested my patch on DM3730,
>
> What board, bootloader, and test steps did you use?  Can you post a dmesg?

I've used LogicPD Torpedo Wireless SoM + DevKit board. Bootloader is
stock from their BSP, u-boot 2011.06 + patches from LogicPD.
I can provide dmesg of 3.8(inital kernel this patch was intented for)
a bit later during the day, and a bit more later same patch rebased
onto latest sources.
Also, I should mention that LogicPD does not support 3.8, so most
LogicPD-specific devices are not working.

And I'd like to point out that after patch gaps I've seen are not gone
completely, ~1 packet out of 200 at 1mbaud is still corrupted, but
only when PM is enabled in kernel,
what gives me a clue that it must be something in PM also. Maybe my
patch just reveals PM-specific issue. Have you tried without PM to
reproduce issues you're experiencing?

>
>> and, at least, can prove that original settings of UART are incorrect
>> according to TRM of processor.
>
> The TRM could be buggy or wrong; or your patch could be correct as far as
> the UART goes, but could be triggering a separate bug.  We're reaching the
> end of the v3.9-rc fixes period, so we need to deal with the v3.9-rc
> regression quickly so folks don't wind up with a broken v3.9 kernel.
> Then the issue can be debugged and tested, and the revised fix targeted
> for the v3.11 kernel.

Indeed, TRMs appear to contain wrong information, but I believe that
in this particular case, bug is somewhere around, but not in these
lines.
I believe if you take a look on related TRM pages, it seems quite
logical that configuration of SCR (before my patch) is not quite
proper:
 - trigger interrupt only when it's entirely empty, not when threshold
level is reached, what is incorrect, in my opinion.
 - (less influencing) Granularity of counter indicates opposite to
what is stated in comments

These issues may have never been experienced by others, since
originally I've hit them on 1mbaud speed, what is not supported by
original driver at all.

>
>> What settings of UART you were using to reproduce issue? I'd like to
>> kindly ask you to describe your test environment, since I've never
>> experiences issues that you've described nor in debug console, nor in
>> regular UART usage.
>
> Could you be more specific about what information you're looking for,
> beyond what's in:
>
> http://www.pwsan.com/omap/testlogs/test_v3.9-rc5/20130331205513/pm/37xxevm/37xxevm_log.txt
>
> ?  As you can see from the log, it's using UART1 at 115kbps -- init=/bin/sh,
> so no userspace to speak of.
>

Sorry, I've missed that file at all. After patch I've never expericed
any issues on 115200 speed of debug console, and it works flawlessly
for me.

> It's also worth mentioning that the 3730 Beagle XM here doesn't fail the
> PM test, UART3 at 230kbps in a "full" userspace:
>
> http://www.pwsan.com/omap/testlogs/test_v3.9-rc5/20130331205513/pm/3730beaglexm/3730beaglexm_log.txt
>
>
> - Paul
