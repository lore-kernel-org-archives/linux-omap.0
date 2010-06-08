From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3] serial: Add OMAP high-speed UART driver
Date: Tue, 8 Jun 2010 12:00:13 +0530
Message-ID: <AANLkTinod9geJbbfdOIhB465qi6xHqfH-1vL048Bc3fa@mail.gmail.com>
References: <33418.192.168.10.88.1275659646.squirrel@dbdmail.itg.ti.com>
	<201006070809.47853.luke@dashjr.org>
	<AANLkTimEtn-ef4ygY2Cu3ay4vAGHpCwtxrf8U9nW9NV8@mail.gmail.com>
	<201006071115.34881.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55403 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab0FHGaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 02:30:15 -0400
In-Reply-To: <201006071115.34881.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

On Mon, Jun 7, 2010 at 9:45 PM, Luke-Jr <luke@dashjr.org> wrote:
> On Monday 07 June 2010 08:28:51 am Govindraj wrote:
>> Link:
>> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summa
>> ry
>>
>> Branch:
>> pm-wip/uart
>
> This branch doesn't appear to have omap-serial.c at all...
>
>> If you are trying to use with any client device connected to uart
>> then we need to ensure the client driver speaks to omap-serial
>> dev entries.
>

You need apply the driver patch on top of this branch.

[PATCH v3] serial: Add OMAP high-speed UART driver.

> Does this mean anything beyond simply using ttyO* instead of ttyS*?
>

---
Regards,
Govindraj.R
