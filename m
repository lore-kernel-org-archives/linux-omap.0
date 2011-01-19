From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCHv2] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Wed, 19 Jan 2011 14:31:56 +0100
Message-ID: <4D36E7CC.5090303@corscience.de>
References: <1295426461-12459-1-git-send-email-weber@corscience.de> <AANLkTin0-joNuqxqL79j0wqPk_A5mtAgzEY=X=PeH=+C@mail.gmail.com> <20110119130049.GB9365@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110119130049.GB9365@m-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Andrei Emeltchenko <andrei.emeltchenko@nokia.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Am 19.01.2011 14:00, schrieb G, Manjunath Kondaiah:
> On Wed, Jan 19, 2011 at 03:01:39PM +0530, Govindraj wrote:
>> On Wed, Jan 19, 2011 at 2:11 PM, Thomas Weber <weber@corscience.de> wrote:
>>> Magic SysRq key is not working for OMAP on new serial
>>> console ttyOx because SUPPORT_SYSRQ is not defined
>>> for omap-serial.
>>>
>>> This patch defines SUPPORT_SYSRQ in omap-serial and
>>> enables handling of Magic SysRq character.
>>>
>>> Signed-off-by: Thomas Weber <weber@corscience.de>
>>
>> Looks fine to me.
>>
>> Acked-by: Govindraj.R <govindraj.raja@ti.com>
> I tried to use SysRq key on minicom after applying this patch, it looks
> like it is not triggering sysrq event.
> 
> Am I missing anything?
> 
> -Manjunath
> --
Hello Manjunath,

Do you have CONFIG_MAGIC_SYSRQ enabled?
Magic SysRq key in Kernel Hacking

I tested it on Devkit8000 (beagle board clone).

Thomas
