From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 0/8] Split powerdomain framework into plat
 specfic/independent
Date: Wed, 13 Oct 2010 09:06:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010130858560.16871@utopia.booyaka.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53061 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab0JMPG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Oct 2010 11:06:26 -0400
In-Reply-To: <1285245291-26442-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com

Hi Rajendra,

On Thu, 23 Sep 2010, Rajendra Nayak wrote:

> OMAP4 powerdomains have some inherent differences as compared
> to OMAP2/3 powerdomains, starting with register offsets being different
> to clubbing of multiple controls into one register and in some cases
> splitting of control into multiple registers.
> There are also new features like lowpowerstatechange bits and features
> like HW SAR which are no longer present in the older form.
> 
> Supporting all these in the existing powerdomain framework would mean adding
> a lot of cpu_is_* checks which makes code unmaintainable going fwd.
> 
> Hence this RFC series is an attempt to split the existing powerdomain framework
> into platform independent part (which does error checking, usecounting et al)
> which can be reused across OMAP's and hook up platform specific functions to
> do low level programming which varies across OMAP's.
> 
> The series has a dependency on the following patch series
> http://marc.info/?l=linux-omap&m=128146137929118&w=2
> http://marc.info/?l=linux-omap&m=128464495603506&w=2
> 
> This series along with all the dependent series patches can be
> found here
> git://gitorious.org/omap-pm/linux.git powerdomain-split

I'm happy with the basic approach here, to split the powerdomain code via 
function pointers.  There were some minor comments on those patches; 
you've probably seen them already.  Similar issues exist in some of the 
other powerdomain split patches (e.g., many functions should be static, 
etc.)  Also please make sure the changes don't add any sparse warnings; I 
noticed some when doing a test build:

arch/arm/mach-omap2/powerdomains.c:52:5: warning: symbol 
'_get_mem_bank_onstate_mask' was not declared. Should it be static?
arch/arm/mach-omap2/powerdomains.c:72:5: warning: symbol 
'_get_mem_bank_retst_mask' was not declared. Should it be static?
arch/arm/mach-omap2/powerdomains.c:92:5: warning: symbol 
'_get_mem_bank_stst_mask' was not declared. Should it be static?
 
...

Aside from those minor issues, the other major issue to clear up is the 
PRM/CM API for OMAP4 that is referenced in your mail, which of course will 
impact these patches too.  Will take a close look at those -


- Paul
