From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in
 i2c
Date: Thu, 01 Oct 2009 14:41:44 +0300
Message-ID: <4AC49578.9090906@nokia.com>
References: <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>	 <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>	 <87bpkso0dj.fsf@deeprootsystems.com> <1254383040.22468.130.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18646 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449AbZJALmF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 07:42:05 -0400
In-Reply-To: <1254383040.22468.130.camel@ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Kalle Jokiniemi wrote:
> On Wed, 2009-09-30 at 19:36 +0300, Kevin Hilman wrote:
>> Seems like the latency value should also be (optionally) passed in
>> pdata so this can be experimented with per-platform.
> 
> Well, it kind of is already, since we pass the function that sets the
> latency from platform code. And that function has the latency
> hard-coded.

Paul Walmsley suggested earlier that the latency value should be
calculated from bus specific parameters:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12358.html

A.
