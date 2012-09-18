From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] i2c: OMAP fix driver initialization message
Date: Tue, 18 Sep 2012 11:24:47 -0700
Message-ID: <20120918182447.GA11762@atomide.com>
References: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com>
 <1348070841-23354-4-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348070841-23354-4-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [120918 11:13]:
> The message spit out when the i2c-omap driver load is printing
> the platform device's id as a bus number. However when booting
> from OF id is -1, which is not so nice.
> 
> Fix it by printing the adapter number.
> 
> [    0.210467] omap_i2c 44e0b000.i2c: bus -1 rev2.4.0 at 400 kHz
> 	vs
> [    0.210467] omap_i2c 44e0b000.i2c: bus 0 rev2.4.0 at 400 kHz
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>

Acked-by: Tony Lindgren <tony@atomide.com>
