From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/13 v3] OMAP: GPIO: Add gpio dev_attr and correct clks in OMAP4 hwmod struct
Date: Thu, 17 Jun 2010 09:42:43 -0700
Message-ID: <87ocf9mwzg.fsf@deeprootsystems.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
	<1276614348-5201-2-git-send-email-charu@ti.com>
	<1276614348-5201-3-git-send-email-charu@ti.com>
	<1276614348-5201-4-git-send-email-charu@ti.com>
	<1276614348-5201-5-git-send-email-charu@ti.com>
	<1276614348-5201-6-git-send-email-charu@ti.com>
	<1276614348-5201-7-git-send-email-charu@ti.com>
	<1276614348-5201-8-git-send-email-charu@ti.com>
	<1276614348-5201-9-git-send-email-charu@ti.com>
	<1276614348-5201-10-git-send-email-charu@ti.com>
	<1276614348-5201-11-git-send-email-charu@ti.com>
	<4C17ACE8.6000805@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B62A@dbde02.ent.ti.com>
	<4C1891F7.40101@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B9B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53141 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996Ab0FQQms (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 12:42:48 -0400
Received: by pwi1 with SMTP id 1so56193pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 09:42:47 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B9B3@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Wed\, 16 Jun 2010 21\:11\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>> 
>> So please, don't do that.
>> 
>> BTW, you didn't answer the first answer, do you really need that?
>> 
> It is used in save/restore context which would be called
> from sram_idle path.

Cleaning this up should be considered instead of keeping around the
bank count.

The save/restore should be done per-bank whenever the bank usage count
goes to zero (or changes from zero.)

If you don't want to address that cleanup in this series, add it to
the TODO list for the cleanups and use the current variable, but it's
value should be set when iterating over the number of hwmods as
suggested by Benoit.

Kevin
