From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] of/base: Take NULL string into account for property
 with multiple strings
Date: Wed, 4 Jan 2012 00:34:39 -0700
Message-ID: <20120104073439.GB15503@ponder.secretlab.ca>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
 <1323095036-3739-2-git-send-email-b-cousson@ti.com>
 <4EEF4401.1060303@gmail.com>
 <4F030D69.5010709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57400 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2ADHem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 02:34:42 -0500
Received: by iaeh11 with SMTP id h11so32145280iae.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Jan 2012 23:34:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F030D69.5010709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 03, 2012 at 03:15:05PM +0100, Cousson, Benoit wrote:
> Hi Grant,
> 
> On 12/19/2011 3:02 PM, Rob Herring wrote:
> >On 12/05/2011 08:23 AM, Benoit Cousson wrote:
> >>The current implementation just ignore any NULL string inserted in a
> >>multiple strings property.
> >>In some cases we can have a property with a fix number of strings but
> >>not necessarily used, like for example in a list of valid pinmux modes.
> >>
> >>  prop = "uart_rx", "uart_tx", "", "", "safe_mode";
> >>
> >>Do no skip NULL string and take them into account in
> >>of_property_read_string_index and of_property_count_strings.
> >>
> >>Reported-by: Tony Lindgren<tony@atomide.com>
> >>Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>Cc: Grant Likely<grant.likely@secretlab.ca>
> >>Cc: Rob Herring<rob.herring@calxeda.com>
> >
> >Applied. The others need Grant's agreement.
> 
> New year gentle ping.

merged both; should appear in linux-next tomorrow.

g.

