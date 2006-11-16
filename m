From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Moving I2C2 init to plat-omap/devices.c  ?
Date: Fri, 17 Nov 2006 01:41:47 +0530
Message-ID: <455CC603.9050409@gmail.com>
References: <EA12F909C0431D458B9D18A176BEE4A508A01E5E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A508A01E5E@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard stated on 11/16/2006 8:28 PM:
> IP version would clarify some aspects around differences and errata.
> You would still end up with both (chip & IP) as the integration of the
> IP into a chip is an area where things are different also.  I find USB
> client to be one which can be confusing.  From 1510-2420 there are many
> bug fixes and many are not apparent by register differences.  This can
> result in older ones being broke or newer ones not running to their
> potential when sharing.
I think a V3.x driver, if defined to handle IP of range 3.0>= x <4.0,
then it can have backward compatibility based on subversion information.
I can think of more ways this will work than a omap-version based
approach.. this may not be the thread to discuss that however..


> 
> By adding enough layers of indirection/functional pointer tables you can
> usually merge things.  However, this can make the code harder to follow.
> If people wanted to take the time to merge I suspect that making the HS
> driver work in a backward compatible manner might be easier than
> upgrading the FS one.  Given what you know today would you agree with
> that?  Getting any code into the I2C tree might take a bit of effort.
I am pointing at the fact that using FIFO changes our bulk of our logic,
we need to be depending on a different set of interrupts, the transfer
logic is different etc.. makes 70-80% code look different I think.. yes
we can still have the same ARDY,NAK,timeout handling..
I am not sure to what extent..

> Tony floated an interesting idea about creating an embedded I2C using
> Daivd's frame work.  This might allow faster integration of performance
> related changes and the like with out fighting with SMB people.
> 
Err... I dont know.. is it more useful to get lm-sensor to look at that?
I dont think it makes sense to diverge off the lm-sensor line of thought
 since the client device support and framework in lmsensor is something
most folks like...but then... :) I am a wimp not ready to look at
something different :D

Regards,
Nishanth Menon
