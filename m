From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 0/9] ARM: OMAP2+: AM33XX: Misc fixes/updates
Date: Mon, 21 Jan 2013 10:37:06 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF1189@DBDE01.ent.ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
	<B5906170F1614E41A8A28DE3B8D121433ECF09E0@DBDE01.ent.ti.com>
 <87zk02aox3.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32924 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab3AUKhZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 05:37:25 -0500
In-Reply-To: <87zk02aox3.fsf@dell.be.48ers.dk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Peter,

On Mon, Jan 21, 2013 at 14:33:20, Peter Korsgaard wrote:
> >>>>> "V" == Bedia, Vaibhav <vaibhav.bedia@ti.com> writes:
> 
> Hi,
> 
>  >> Vaibhav Bedia (9):
>  >> ARM: OMAP2+: AM33XX: CM: Get rid of unncessary header inclusions
>  >> ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
>  >> ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
>  >> ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
>  >> ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
>  >> ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset
>  >> status bit
>  >> ARM: OMAP2+: AM33XX: Update the hardreset API
>  >> ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
>  >> ARM: OMAP2+: AM33XX: control: Add some control module registers and
>  >> APIs
>  >> 
> 
>  V> Any comments on these before I resend addressing the comments from Sergei?
> 
> Wouldn't the ocmram/wkup dt nodes need a reg property to define their
> size as I indirectly mentioned here:
> 
> http://thread.gmane.org/gmane.linux.ports.arm.omap/91405/focus=92061
> 

My apologies. I missed your comment on that patch and just responded to it.
Will add the reg property for the DT nodes in the next version.

Regards,
Vaibhav
