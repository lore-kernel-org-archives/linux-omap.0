From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 04/22] input/ti_am33x_tsc: Order of TSC wires, made configurable
Date: Thu, 4 Jul 2013 19:57:26 +0530
Message-ID: <51D5864E.20401@ti.com>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-5-git-send-email-bigeasy@linutronix.de> <51D5592F.6050208@ti.com> <51D55D80.6080803@linutronix.de> <51D57AF9.2020001@ti.com> <51D57DBC.3050503@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43842 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3GDO1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 10:27:45 -0400
In-Reply-To: <51D57DBC.3050503@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org

On 7/4/2013 7:20 PM, Sebastian Andrzej Siewior wrote:
> On 07/04/2013 03:39 PM, Sekhar Nori wrote:
>> Yes, I noticed that after sending the mail. To me it does not make sense
>> to make changes to accept something as platform data only to remove
>> platform data itself later.
> 
> The patches were made earlier and it was easier that way to take
> everything and simple remove the platform part later.

Okay, then. If the maintainers do not have objection, I am fine too!

Regards,
Sekhar
