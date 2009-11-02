From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCHv2 1/3] OMAP UART: Add omap-serial driver support.
Date: Mon, 2 Nov 2009 09:20:18 +0200
Message-ID: <20091102072018.GC31062@gw.healthdatacare.com>
References: <35817.192.168.10.88.1256713979.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48283 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbZKBHUR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 02:20:17 -0500
Received: by bwz27 with SMTP id 27so5941804bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 01 Nov 2009 23:20:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <35817.192.168.10.88.1256713979.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Oct 28, 2009 at 12:42:59PM +0530, Govindraj.R wrote:
> >From a3f0e5a13c1bc5046110cae513878183df2215c6 Mon Sep 17 00:00:00 2001
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Wed, 28 Oct 2009 12:21:03 +0530
> Subject: [PATCHv2 1/3] OMAP UART: Add omap-serial driver support.
> 
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
> 
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |  155 +++
>  drivers/serial/Kconfig                        |   23 +
>  drivers/serial/Makefile                       |    1 +
>  drivers/serial/omap-serial.c                  | 1778 +++++++++++++++++++++++++
>  include/linux/serial_core.h                   |    3 +
>  5 files changed, 1960 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
>  create mode 100644 drivers/serial/omap-serial.c

One thing that I noticed with this driver is that it causes
huge amount of interrupts on my OMAP3430 (don't know whether
it is intentional, however):

# grep 'OMAP UART3' /proc/interrupts
 74:       9630        INTC  OMAP UART3
# grep 'OMAP UART3' /proc/interrupts
 74:       9869        INTC  OMAP UART3
# grep 'OMAP UART3' /proc/interrupts
 74:      10094        INTC  OMAP UART3
# grep 'OMAP UART3' /proc/interrupts
 74:      10334        INTC  OMAP UART3
# grep 'OMAP UART3' /proc/interrupts
 74:      10574        INTC  OMAP UART3

I didn't investigate this further but this didn't happen
with the old driver.

Br,
MW
