From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH v3] serial: Add OMAP high-speed UART driver
Date: Mon, 7 Jun 2010 11:15:16 -0500
Message-ID: <201006071115.34881.luke@dashjr.org>
References: <33418.192.168.10.88.1275659646.squirrel@dbdmail.itg.ti.com> <201006070809.47853.luke@dashjr.org> <AANLkTimEtn-ef4ygY2Cu3ay4vAGHpCwtxrf8U9nW9NV8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zinan.dashjr.org ([173.242.112.54]:56729 "EHLO zinan.dashjr.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab0FGQPv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Jun 2010 12:15:51 -0400
In-Reply-To: <AANLkTimEtn-ef4ygY2Cu3ay4vAGHpCwtxrf8U9nW9NV8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

On Monday 07 June 2010 08:28:51 am Govindraj wrote:
> Link:
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summa
> ry
> 
> Branch:
> pm-wip/uart

This branch doesn't appear to have omap-serial.c at all...

> If you are trying to use with any client device connected to uart
> then we need to ensure the client driver speaks to omap-serial
> dev entries.

Does this mean anything beyond simply using ttyO* instead of ttyS*?
