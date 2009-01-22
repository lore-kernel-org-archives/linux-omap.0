From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] TWL: USB: disable VUSB regulators when cable unplugged
Date: Thu, 22 Jan 2009 09:55:51 -0800
Message-ID: <200901220955.51986.david-b@pacbell.net>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com> <1232543718-18199-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:45296 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761541AbZAVRzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Jan 2009 12:55:54 -0500
In-Reply-To: <1232543718-18199-2-git-send-email-kalle.jokiniemi@digia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Wednesday 21 January 2009, Kalle Jokiniemi wrote:
> This patch disables USB regulators VUSB1V5, VUSB1V8, and VUSB3V1
> when the USB cable is unplugged to reduce power consumption.

Worked fine on a Beagle, now I'm trying to find out
what's borked on an Overo ...

- Dave

