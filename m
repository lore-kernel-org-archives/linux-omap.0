From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3] serial: Add OMAP high-speed UART driver
Date: Mon, 7 Jun 2010 18:58:51 +0530
Message-ID: <AANLkTimEtn-ef4ygY2Cu3ay4vAGHpCwtxrf8U9nW9NV8@mail.gmail.com>
References: <33418.192.168.10.88.1275659646.squirrel@dbdmail.itg.ti.com>
	<201006051348.30425.luke@dashjr.org>
	<AANLkTinRsFvGv0HPYtDjYUM5fwA_A04T8VeIQWe6dOC3@mail.gmail.com>
	<201006070809.47853.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <201006070809.47853.luke@dashjr.org>
Sender: linux-serial-owner@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 7, 2010 at 6:39 PM, Luke-Jr <luke@dashjr.org> wrote:
> On Monday 07 June 2010 01:49:05 am Govindraj wrote:
>> Hope your are trying to use Kevins Wip-UART branch.
>> Since platform data support is currently available in that branch.
>
> Nope... Google doesn't seem to know where this branch is, either. :/

Link:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary

Branch:
pm-wip/uart

>
>> ensure you have selected omap-serial driver
>
> I'm not using it for console, anyway.
>

If you are trying to use with any client device connected to uart
then we need to ensure the client driver speaks to omap-serial
dev entries.

The client device application may be designed to speak to
8250 entries probably you may need to check.

In that case you need to change device name to that of 8250
so that no change is needed in application though and in that way
we make it to speak with omap-serial.

---
Regards,
Govindraj.R
