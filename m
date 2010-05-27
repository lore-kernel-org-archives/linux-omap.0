From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH v2] serial: Add OMAP high-speed UART driver
Date: Thu, 27 May 2010 11:00:19 -0500
Message-ID: <201005271100.41305.luke@dashjr.org>
References: <58269.192.168.10.88.1274708590.squirrel@dbdmail.itg.ti.com> <87wruqmg85.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zinan.dashjr.org ([173.242.112.54]:47765 "EHLO zinan.dashjr.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509Ab0E0QHf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 May 2010 12:07:35 -0400
In-Reply-To: <87wruqmg85.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wednesday 26 May 2010 05:48:58 pm Kevin Hilman wrote:
> FYI... this also works on OMAP2.
> 
> I tested it on my n810 along with UART hwmod conversion and it works
> just fine there.

Is it somehow different from the basic 8250 driver on OMAP2? I've been 
struggling to figure out why my N810's GPS isn't working when I change kernels 
(I've already made sure ttyS0 is the correct major/minor and adjusted the GPIO 
calls; gpiodriver is talking to the chip, but not getting anywhere).
