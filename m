From: Ben Tucker <btucker@mpcdata.com>
Subject: RFBI worked example
Date: Thu, 6 Jan 2011 15:32:08 -0000
Message-ID: <b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46015 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab1AFPbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 10:31:16 -0500
Received: by iyi12 with SMTP id 12so14946288iyi.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 07:31:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com

Hi,

I am trying to setup an OMAP3530 based system for RFBI video output using
external triggering. Looking at the omap dss2 source code (and also
searching around) I cannot find any worked example of how to use the rfbi
driver. I know that RFBI has worked in the past for a Nokia N800 device.
Can you dig out any source code that shows how to use the RFBI driver?
In particular I need to see how the omap_rfbi_prepare_update() and
omap_rfbi_update() calls operate with their callback. I am thinking that I
should simply call omap_rfbi_update() in a thread and wait for the
completion call back after each call. I want to confirm that this is the
correct way to run the driver.

Thanks,
	Ben



Ben Tucker
Senior Software Engineer
MPC Data Limited
e-mail: <btucker@mpc-data.co.uk>      web: www.mpc-data.co.uk
tel: +44 (0) 1225 710600              fax: +44 (0) 1225 710601
ddi: +44 (0) 1225 710660

MPC Data Limited is a company registered in England and Wales with company
number 05507446
Registered Address: County Gate, County Way, Trowbridge, Wiltshire, BA14
7FJ
VAT no: 850625238

The information in this email and in the attached documents is
confidential and may be
legally privileged. Any unauthorized review, copying, disclosure or
distribution is
prohibited and may be unlawful. It is intended solely for the addressee.
Access to this
email by anyone else is unauthorized. If you are not the intended
recipient, please
contact the sender by reply email and destroy all copies of the original
message. When
addressed to our clients any opinions or advice contained in this email is
subject to
the terms and conditions expressed in the governing contract.
