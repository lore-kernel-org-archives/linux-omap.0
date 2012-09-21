From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] pinctrl: pinctrl-single must be initialized early.
Date: Thu, 20 Sep 2012 17:09:22 -0700
Message-ID: <20120921000922.GQ28835@atomide.com>
References: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com>
 <1348070841-23354-2-git-send-email-panto@antoniou-consulting.com>
 <20120918182150.GY11762@atomide.com>
 <B7D59159-4456-468B-A414-9B57BCEE018D@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B7D59159-4456-468B-A414-9B57BCEE018D@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [120918 12:11]:
> 
> As long as we get the regulator to work early in the game no problem.
> I don't know if deferring the probe will work in this case.
> I could give it a shot and see if it works at all.

Did you have any luck with deferred probe here?

Tony
