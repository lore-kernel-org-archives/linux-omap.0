From: Tony Lindgren <tony@atomide.com>
Subject: Re: RMKs comments on latest OMAP upstream patches
Date: Tue, 16 Oct 2007 13:17:30 -0700
Message-ID: <20071016201728.GD20513@atomide.com>
References: <46F29DB0.9060203@googlemail.com>
	<20070921015935.GA26096@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901F3ED6C@dlee13.ent.ti.com>
	<20070923212149.GB10076@atomide.com>
	<47150464.4060901@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <47150464.4060901@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [071016 11:37]:
> Tony Lindgren wrote:
>> * Woodruff, Richard <r-woodruff2@ti.com> [070921 01:31]:
>>>>> OMAP1:
>>>>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4570/1
>>>>>
>>>>> OMAP2:
>>>>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4571/1
>> Looks like Russell has applied these two patch series above!
>
> ... and Linus as well :)
>
> See changelog for patch-2.6.23-git9 (search for "ARM: OMAP:"):
>
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.23-git9.log

Great, I'll tag 2.6.23-omap1 soon, then let's do a pull.

> Btw: Do we have already any plans for next merge window which opens with 
> -rc5?

Yeh, let's try to get plat-omap and mach-omap1 synced.

Tony
