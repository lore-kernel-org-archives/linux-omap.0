From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Pending July patches
Date: Tue, 08 Aug 2006 02:56:34 +0300
Message-ID: <44D7D332.3050101@cc.jyu.fi>
References: <20060803111721.GH8661@atomide.com>
	<20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
	<20060804110530.GC26416@atomide.com> <44D35C5C.8060602@cc.jyu.fi>
	<20060807152344.GH10387@atomide.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060807152344.GH10387@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * lamikr <lamikr@cc.jyu.fi> [060804 17:40]:
>> It would be nice if somebody could test the functionality of usbnet and
>> mmc/sd with omap1 devices (omap1510)
>> before tagging. I got the lcd working by using the fixes now already
>> applied to OMAP kernel but both the MMC/SD
>> and usbnet failed to work at least for me & h6300.
>> (2.6.16 kernel worked ok.)
>>
>> I can also try to test again these but for me it will go over the
weekend...
>
> No patches so I tagged it already :)
Well, I suppose2.6.17-omap2 tag means that it works with omap2 devices :-)

I tried that with my h6340 that but unfortunately I could not find fix
for the usbnet and MMC/SD card problems.
So it probably means that they are failing also for other OMAP1 devices?

I tested usbnet both with the DMA enabled and disabled in omap_udc.c
(#define USE_DMA / #undef USE_DMA) and with both of the options
the usb link was not created to my desktop.
I also tried to mount both the "Kingston Elite Pro 512 MB" SD card and
San Disk 256 MB RC-MMC MMC cards without success.

With 2.6.16 kernel, both the SD, MMC cards were working as well as the
usbnet.
Any idea, which would be the best place to add debug in in the MMC/SD
card subsystem to get more info?

Mika
