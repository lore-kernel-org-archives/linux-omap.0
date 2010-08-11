From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3] serial: Add OMAP high-speed UART driver
Date: Wed, 11 Aug 2010 18:40:34 +0530
Message-ID: <AANLkTimPqo3+xAPO=mYjVydW3BHrF_F4xxO0nUahOs=N@mail.gmail.com>
References: <33418.192.168.10.88.1275659646.squirrel@dbdmail.itg.ti.com>
	<201006070809.47853.luke@dashjr.org>
	<AANLkTimEtn-ef4ygY2Cu3ay4vAGHpCwtxrf8U9nW9NV8@mail.gmail.com>
	<201006071115.34881.luke@dashjr.org>
	<AANLkTinod9geJbbfdOIhB465qi6xHqfH-1vL048Bc3fa@mail.gmail.com>
	<20100707120241.GN1920@atomide.com>
	<AANLkTinq3Hx_2gGbuyvbGnNpSfQ75B3vJU9WU66GAzd4@mail.gmail.com>
	<87zkwvinz3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87zkwvinz3.fsf@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Luke-Jr <luke@dashjr.org>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 10, 2010 at 12:59 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Wed, Jul 7, 2010 at 5:32 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Govindraj <govindraj.ti@gmail.com> [100608 09:24]:
>>>> On Mon, Jun 7, 2010 at 9:45 PM, Luke-Jr <luke@dashjr.org> wrote:
>>>> > On Monday 07 June 2010 08:28:51 am Govindraj wrote:
>>>> >> Link:
>>>> >> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summa
>>>> >> ry
>>>> >>
>>>> >> Branch:
>>>> >> pm-wip/uart
>>>> >
>>>> > This branch doesn't appear to have omap-serial.c at all...
>>>> >
>>>> >> If you are trying to use with any client device connected to uart
>>>> >> then we need to ensure the client driver speaks to omap-serial
>>>> >> dev entries.
>>>> >
>>>>
>>>> You need apply the driver patch on top of this branch.
>>>>
>>>> [PATCH v3] serial: Add OMAP high-speed UART driver.
>>>
>>> Do we still have a dependency to pm-wip/uart branch? Can you please
>>> check if you can rebase all these patches on top of linux-omap for-next
>>> branch?
>>
>> pm-wip uart branch is having all the mach-omap2/serail.c changes along with
>> hwmod data file updation and serial hwmod usage.
>>
>> The driver patch [serial: Add OMAP high-speed UART driver]
>> was tested against wip/uart branch.
>>
>> I will re-base all these patches for-next branch,
>> and will post driver and board support patches from pm-wip/uart as a
>> single series.
>
> Any update on this?
>
> FWIW, I rebased the pm-wip/uart part on top of latest
> pm-wip/hwmods-omap4 but from here, you should take over responsibility
> for pm-wip/uart.
>

Yes sure, Will test and post to LO from pm-wip/uart.

Thanks,
Govindraj.R


> Kevin
>
