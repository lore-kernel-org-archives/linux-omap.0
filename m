From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/1] twl4030_charger: Make the driver atomic notifier
 safe
Date: Mon, 28 Feb 2011 17:32:44 +0300
Message-ID: <20110228143244.GA1074@oksana.dev.rtsoft.ru>
References: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
 <1298634996-25722-2-git-send-email-heikki.krogerus@nokia.com>
 <AANLkTin81FMA-hA5C_1m0XTDkAozceLXdDbqhvqhqt31@mail.gmail.com>
 <20110228062953.GB2181@esdhcp034230>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42615 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab1B1Ocs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 09:32:48 -0500
Received: by eyx24 with SMTP id 24so1304152eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:32:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110228062953.GB2181@esdhcp034230>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@nokia.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, balbi@ti.com, linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 08:29:53AM +0200, Heikki Krogerus wrote:
> On Sat, Feb 26, 2011 at 07:53:03PM +0200, ext Grazvydas Ignotas wrote:
> > On Fri, Feb 25, 2011 at 1:56 PM, Heikki Krogerus
> > <heikki.krogerus@nokia.com> wrote:
> > > This queues work from the otg notification where the
> > > i2c operations can be safely made. Needed for atomic otg
> > > notifiers.
> > >
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@nokia.com>
> > > Cc: Grazvydas Ignotas <notasas@gmail.com>
> > > Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> > 
> > seems to work fine.
> > Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> 
> Anton, can you take this?

Applied, thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
