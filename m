From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: droid 4: connection refused from voltage_now
Date: Wed, 4 Jul 2018 21:45:56 +0200
Message-ID: <20180704194556.GA9189@lenoch>
References: <20180704171156.GA3158@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994656AbeGDTp5Fkb55 (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Wed, 4 Jul 2018 21:45:57 +0200
Content-Disposition: inline
In-Reply-To: <20180704171156.GA3158@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 04, 2018 at 07:11:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> I started to use droid 4 as my primary phone... so I have battery
> monitor running for hours... Once every few days it dies with
> "connection refused" error reading battery's "voltage_now". I restart
> it and it continues working...

Ha! What exactly that "connection refused" means? Is it ECONNREFUSED (111)?
I have custom at91 based board here with few custom power supply drivers
and it sometimes ends with voltage_now of my driver being unreadable.
(I modified userspace code and waiting what's in errno in case reading fails)

> That was with v4.17; in v4.18, I'm getting "red screen" a lot.

Tests are also done v4.17.
Adding linux-pm@vger.kernel.org as it seems to be subsytem, specific.

	ladis
