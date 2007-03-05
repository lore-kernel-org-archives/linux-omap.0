From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] add ssi/Kconfig to arch/arm/Kconfig
Date: Mon, 05 Mar 2007 20:56:53 +0100
Message-ID: <45EC7605.8060808@googlemail.com>
References: <85ps7pgphq.fsf@orfeo.duckcorp.org>
	<45EAFDBA.9010406@googlemail.com>
	<85r6s4damj.fsf@orfeo.duckcorp.org>
	<20070305100136.GC17801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070305100136.GC17801@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, Nishanth Menon <menon.nishanth@gmail.com>, Imre Deak <imre.deak@solidboot.com>, Brian Swetland <swetland@google.com>, jekyll@mail.jekyll.idv.tw, lastjp_fr@yahoo.fr, swetland@android.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Arnaud Patard <arnaud.patard@rtp-net.org> [070304 12:25]:
> 
>>Dirk Behme <dirk.behme@googlemail.com> writes:
>>
>>
>>>Arnaud Patard (Rtp) wrote:
>>>
>>>>If one wants to use ssi/Kconfig on arm, it should be added to
>>>>arch/arm/Kconfig.
>>>
>>>Yes, I found this as well by getting
>>>
>>>sound/arm/Kconfig:55:warning: 'select' used by config symbol
>>>'SND_OMAP_TSC2101' refer to undefined symbol 'OMAP_TSC2101'
>>>sound/arm/Kconfig:56:warning: 'select' used by config symbol
>>>'SND_OMAP_TSC2101' refer to undefined symbol 'OMAP_UWIRE'
>>>
>>>Kconfig warnings.
>>
>>same here :)
>>
>>
>>>While touching this, what do you think about doing some more
>>>clean up:
>>>
>>>- omap_uwire.c is now in drivers/spi [], remove (old?) one from
>>>drivers/ssi
>>
>>I had the same patch but you send it before me :)
>>
>>
>>>- Replace OMAP_UWIRE in Kconfig by SPI_OMAP_UWIRE pointing
>>>to drivers/spi
>>>
>>>?
>>>
>>
>>Even if I'm not a omap dev, I'll be happy to see the ssi stuff go to
>>/dev/null. Unfortunately, grep is telling us that there are still users
>>of the old omap_uwire. Moreover, it seems that it's possible to build a
>>kernel without the OMAP_UWIRE and with the drivers using it. The drivers
>>using the old ssi stuff should either depends on it or select it...
>>(see drivers/video/omap/lcd_{p,h}2.c).
>>Until this is solved, we won't be able to remove it :(
> 
> 
> I agree, let's get rid of the old drivers/ssi, anything using it should
> be updated to use drivers/spi.

Yes.

All: Following files need update. Let's try the names in 
file headers:

* drivers/video/omap/lcd_h2.c

-> update to use drivers/spi/omap-uwire
-> Imre?

* drivers/video/omap/lcd_p2.c

-> update to use drivers/spi/omap-uwire
-> jekyll & B Jp & Brian Swetland?

* drivers/ssi/omap-tsc2101.{c,h}

-> update to use drivers/spi/omap-uwire and move it to 
drivers/spi
-> Nishanth?

Anything else?

Until this is done, only thing we can do to make Kconfig 
happy is

http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009220.html

Dirk
