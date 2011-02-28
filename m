From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [PATCH 1/1] twl4030_charger: Make the driver atomic notifier
 safe
Date: Mon, 28 Feb 2011 08:29:53 +0200
Message-ID: <20110228062953.GB2181@esdhcp034230>
References: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
 <1298634996-25722-2-git-send-email-heikki.krogerus@nokia.com>
 <AANLkTin81FMA-hA5C_1m0XTDkAozceLXdDbqhvqhqt31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:42402 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab1B1G37 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:29:59 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin81FMA-hA5C_1m0XTDkAozceLXdDbqhvqhqt31@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, balbi@ti.com, linux-omap@vger.kernel.org

On Sat, Feb 26, 2011 at 07:53:03PM +0200, ext Grazvydas Ignotas wrote:
> On Fri, Feb 25, 2011 at 1:56 PM, Heikki Krogerus
> <heikki.krogerus@nokia.com> wrote:
> > This queues work from the otg notification where the
> > i2c operations can be safely made. Needed for atomic otg
> > notifiers.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@nokia.com>
> > Cc: Grazvydas Ignotas <notasas@gmail.com>
> > Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> 
> seems to work fine.
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>

Anton, can you take this?

-- 
heikki
