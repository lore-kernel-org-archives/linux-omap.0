From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] cpsw: Fix interrupt storm among other things
Date: Wed, 30 Jan 2013 10:34:12 +0200
Message-ID: <A613CB66-4225-4BDC-8EB2-B1F1B3C465CA@antoniou-consulting.com>
References: <1359378668-26536-1-git-send-email-panto@antoniou-consulting.com> <87wquxdn7n.fsf@dell.be.48ers.dk>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87wquxdn7n.fsf@dell.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>, Matt Porter <mporter@ti.com>, Chase Maupin <chase.maupin@ti.com>, Jason Kridner <jdk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Jan 28, 2013, at 11:14 PM, Peter Korsgaard wrote:

>>>>>> "Pantelis" == Pantelis Antoniou <panto@antoniou-consulting.com> writes:
> 
> 'among other things' is not a very descriptive commit message.
> 
> Pantelis> Fix interrupt storm on bone A4 cause by non-by-the-book
> Pantelis> interrupt handling.  While at it, added a non-NAPI mode
> Pantelis> (which is easier to debug), plus some general fixes.
> 
> 'bone A4' is also not very descriptive. There also was an A4 revision of
> the "old" beaglebone. I guess you're instead referring to a new die
> revision?
> 
> What is the impact of this change on earlier devices?
> 

Same driver works perfectly fine with the PG1.0 bone version I have.
If you take a look at the TRM it should be pretty obvious why the change
was needed.

> Pantelis> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> Pantelis> @@ -20,6 +20,7 @@ Required properties:
> Pantelis>  - cpts_clock_shift	: Denominator to convert input clock ticks into nanoseconds
> Pantelis>  - phy_id		: Specifies slave phy id
> Pantelis>  - mac-address		: Specifies slave MAC address
> Pantelis> +- disable-napi		: Disables driver NAPI
> 
> napi is not a hardware feature, so it doesn't belong here (if anything,
> it should be linux,disable-napi).
> 

Point taken.

> -- 
> Bye, Peter Korsgaard

Regards

-- Pantelis
