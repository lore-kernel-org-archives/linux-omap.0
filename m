From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: clock regression and note.
Date: Sat, 11 Aug 2007 00:18:05 +0300
Message-ID: <1186780685.738.2.camel@localhost.localdomain>
References: <3B6D69C3A9EBCA4BA5DA60D913027429019C4F91@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429019C4F91@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, 2007-08-10 at 15:29 -0500, ext Woodruff, Richard wrote:
> Hi Paul,
> 
> When booting 2430 it looks like its calculating the crystal rate wrong now. Likely one of your fixes needs a tweak for 2430.  I noticed the bogomips was too low.  Then I see the proc/omap_clocks was gone.  Right now a few user space entities read this to get cpurate.  

> Seems Igor told me the N800 user space monitor might do this also.  It would be nicer to leave this part out of the debug define.

Currently we are monitoring the current cpu frequency from cpufreq sysfs
entries, although i don't know yet if it will be the final
implementation.

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
