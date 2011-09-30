From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5 v12] mfd: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Fri, 30 Sep 2011 13:01:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109301259570.12185@utopia.booyaka.com>
References: <1317306247-1103-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317306247-1103-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org


Hi Keshava,

by the way, when you repost these, can you split this into two series -- 
one for the arch/arm/*omap* changes, and the other for changes that should 
go in through the MFD tree?  Then just note in the second series that it 
has a dependency on the first.  That will make it easier to merge these 
patches, and should cut down on the number of cc's that are necessary for 
most of these patches.


thanks

- Paul
