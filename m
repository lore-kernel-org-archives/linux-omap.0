From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] cpsw: Fix interrupt storm among other things
Date: Mon, 28 Jan 2013 22:14:36 +0100
Message-ID: <87wquxdn7n.fsf@dell.be.48ers.dk>
References: <1359378668-26536-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359378668-26536-1-git-send-email-panto@antoniou-consulting.com>
	(Pantelis Antoniou's message of "Mon, 28 Jan 2013 15:11:08 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>, Matt Porter <mporter@ti.com>, Chase Maupin <chase.maupin@ti.com>, Jason Kridner <jdk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>>>>> "Pantelis" == Pantelis Antoniou <panto@antoniou-consulting.com> writes:

'among other things' is not a very descriptive commit message.

 Pantelis> Fix interrupt storm on bone A4 cause by non-by-the-book
 Pantelis> interrupt handling.  While at it, added a non-NAPI mode
 Pantelis> (which is easier to debug), plus some general fixes.

'bone A4' is also not very descriptive. There also was an A4 revision of
the "old" beaglebone. I guess you're instead referring to a new die
revision?

What is the impact of this change on earlier devices?

 Pantelis> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
 Pantelis> @@ -20,6 +20,7 @@ Required properties:
 Pantelis>  - cpts_clock_shift	: Denominator to convert input clock ticks into nanoseconds
 Pantelis>  - phy_id		: Specifies slave phy id
 Pantelis>  - mac-address		: Specifies slave MAC address
 Pantelis> +- disable-napi		: Disables driver NAPI

napi is not a hardware feature, so it doesn't belong here (if anything,
it should be linux,disable-napi).

-- 
Bye, Peter Korsgaard
