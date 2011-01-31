From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCHv3] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Mon, 31 Jan 2011 22:31:09 +0100
Message-ID: <AANLkTi=HxnPVu83CpodFA4rLipcz1Oie2co49S1=+1M6@mail.gmail.com>
References: <1295604084-27761-1-git-send-email-weber@corscience.de>
	<AANLkTikSznkcNwkVaPswx=zr8FFGQPVMw_AebF9ymZLE@mail.gmail.com>
	<8739oi7z4m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8739oi7z4m.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, manjugk@ti.com, gadiyar@ti.com, tony@atomide.com, govindraj@ti.com, gregkh@suse.de, andrei.emeltchenko@nokia.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 10:47 PM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Fri, Jan 21, 2011 at 3:31 PM, Thomas Weber <weber@corscience.de> =
wrote:
>>> Magic SysRq key is not working for OMAP on new serial
>>> console ttyOx because SUPPORT_SYSRQ is not defined
>>> for omap-serial.
>>>
>>> This patch defines SUPPORT_SYSRQ in omap-serial and
>>> enables handling of Magic SysRq character.
>>>
>>> Further there is an issue of losing first break character.
>>> Removing the reset of the lsr_break_flag fixes this issue.
>>>
>>> Signed-off-by: Thomas Weber <weber@corscience.de>
>>
>>
>> Acked-by: Govindraj.R <govindraj.raja@ti.com>
>> Tested-by: Manjunath G Kondaiah <manjugk@ti.com>
>>
>
> Acked-by: Kevin Hilman <khilman@ti.com>
>
> Greg, this one should go for .38-rc. =A0 Feel free to merge, or we ca=
n
> take it through the OMAP tree with your ack.
>
> Thanks,
>
> Kevin
>
> --

Hello,
should I rebase this patch, because it does not apply after movement
of driver/serial to driver/tty/serial?

Thomas
