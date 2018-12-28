From: Tony Lindgren <tony@atomide.com>
Subject: Re: cpcap-charger: generate events for userspace
Date: Fri, 28 Dec 2018 12:08:42 -0800
Message-ID: <20181228200842.GA6707@atomide.com>
References: <20181227195221.GA11920@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181227195221.GA11920@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181227 11:52]:
>     
> The driver doesn't generate uevents on charger connect/disconnect.
> This leads to UPower not detecting when AC is on or off... and that is
> bad.

Acked-by: Tony Lindgren <tony@atomide.com>
