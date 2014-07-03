From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv5 05/15] hwspinlock/omap: add support for dt nodes
Date: Thu, 3 Jul 2014 10:25:01 +0300
Message-ID: <CAK=WgbZL9XbMtHpsQz8zuo5mbqSUnQhtjDoWPi2M2mfVxjaFNw@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-6-git-send-email-s-anna@ti.com> <CAK=WgbamDPN9EmKUu3+c3RbsQn1uhz5MGGvpWSSUJSUKyoH8Cw@mail.gmail.com>
 <53B460B4.9010200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:40946 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbaGCHZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2014 03:25:23 -0400
Received: by mail-lb0-f180.google.com with SMTP id w7so8892439lbi.11
        for <linux-omap@vger.kernel.org>; Thu, 03 Jul 2014 00:25:21 -0700 (PDT)
In-Reply-To: <53B460B4.9010200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 2, 2014 at 10:42 PM, Suman Anna <s-anna@ti.com> wrote:
> Yeah, I did this since we only had 1 instance, and used the same value
> as used in the non-DT legacy code. Once I fold back Patch 8 that adds
> the hwlock-base-id property, this will be assigned by reading that property.

Sounds good, thanks!
