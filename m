From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Wed, 28 Mar 2012 18:34:15 +0530
Message-ID: <CAM=Q2cusJgTm9wEmmSNjidYBE=sMWDb7F8YDV4G=br700g3CZw@mail.gmail.com>
References: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il>
	<4F72E1F9.3020400@ti.com>
	<4F72F253.5020606@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52901 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab2C1NEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Mar 2012 09:04:15 -0400
In-Reply-To: <4F72F253.5020606@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, Alan Stern <stern@rowland.harvard.edu>, "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Munegowda, Keshava" <keshava_mgowda@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Igor,

On Wed, Mar 28, 2012 at 4:43 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Shubhrajyoti,
>
> On 03/28/12 12:03, Shubhrajyoti wrote:
>> On Tuesday 27 March 2012 07:38 PM, Igor Grinberg wrote:
>>> When PHY reset pin is connected to a GPIO on external GPIO chip
>>> (e.g. I2C), we should not call the gpio_set_value() function, but
>>> gpio_set_value_cansleep().
>> Why so ? Whats the error otherwise ?
>
> Otherwise, we get a very confusing warnings:

Yes I guessed so thanks for the patch.
