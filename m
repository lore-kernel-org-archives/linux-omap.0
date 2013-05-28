From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] dts: am33xx: Correct properties on gpmc node
Date: Tue, 28 May 2013 11:50:40 +0200
Message-ID: <87mwrfbfgv.fsf@dell.be.48ers.dk>
References: <1369729497-11897-1-git-send-email-larsi@wh2.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369729497-11897-1-git-send-email-larsi@wh2.tu-dresden.de> (Lars
	Poeschel's message of "Tue, 28 May 2013 10:24:57 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Lars Poeschel <larsi@wh2.tu-dresden.de>
Cc: poeschel@lemonage.de, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>>>>> "Lars" == Lars Poeschel <larsi@wh2.tu-dresden.de> writes:

 Lars> From: Lars Poeschel <poeschel@lemonage.de>
 Lars> The gpmc driver is actually looking for "gpmc,num-cs" and
 Lars> "gpmc,num-waitpins" properties in DT. The binding doc also states
 Lars> this.
 Lars> Correct the properties in the dts to provide the right values for the
 Lars> gpmc driver.

 Lars> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
