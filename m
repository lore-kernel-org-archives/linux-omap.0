From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Mon, 26 Feb 2007 11:12:17 -0400
Message-ID: <45E2F8D1.40004@indt.org.br>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
	<20070209165157.GB22121@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>
	<20070210174121.GA5291@atomide.com>
	<20070210190845.GA19642@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274295B9C49@dlee13.ent.ti.com>
	<20070220092331.GE14954@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070220092331.GE14954@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Tony Lindgren wrote:
> * Woodruff, Richard <r-woodruff2@ti.com> [070219 08:05]:
>>>> Thanks. Looks like we're still doing the MMC powerup wrong for omap
>>>> though. I made a patch for that a while back but it got forgotten
>>>> for some reason:
>>>>
>>>> http://lkml.org/lkml/2006/5/4/44
>>>>
>>>> I'll refresh that patch so we can make sure it works on all
>> platforms.
>>> Here are the refreshed patches to try.
>> The board does work with these patches also.  It's a cleaner way to fix
>> it up even if it is more than a line ;)
> 
> Great, let's plan on pushing them then. Anderson & Carlos, have you guys
> had a chance to test these two patches on other boards?
> 

Hi Tony,

Sorry about the delay.
Carlos tested on H2 and H3 and it is working, but seems that the patches are not working on H4. He is investigating what
is wrong and will send a response asap. We are using the latest git tree.

Regards,

Anderson Briglia
