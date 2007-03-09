From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
Date: Fri, 9 Mar 2007 00:40:33 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C476F28A7@dlee13.ent.ti.com>
References: <45F0FC9F.3070701@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45F0FC9F.3070701@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Pierre Ossman <drzeus@drzeus.cx>, kmpark@infradead.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Pierre,

If I am not wrong what you mean is,

If (card_is_4.0) then its HS {
	If (it supports 26 && 52) and ur controller can generate 52 Mhz
clk=20
	then configure MMC_CLK to operate at 52Mhz

	If (card supports only 26) then configure MMC_CLK at 26Mhz.

	If (card can support upto 52 but controller can only support
till 48)=20
	then configure MMC_CLK to 48 and issue a CMD4 to modify DSR (for
new=20
	timing values).

	Now this DSR timing depends on what Controller can offer and it
doesn't depend on the frequency as such. Is this what you mean?

}
Else{
Not an HS
}

Regards,
Khasim




>-----Original Message-----
>From: Pierre Ossman [mailto:drzeus@drzeus.cx]
>Sent: Friday, March 09, 2007 12:20 AM
>To: kmpark@infradead.org
>Cc: Syed Mohammed, Khasim; linux-omap-open-source@linux.omap.com
>Subject: Re: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
>
>Kyungmin Park wrote:
>> Yes, that's my understanding.
>>
>> If the card is 4.0 compliant and OMAP2 supports up to 48MHz. then we
use
>> this 48MHz clock.
>>
>> But current mmc code down-grade to 20MHz since it's not set
highspeed.
>>
>> If the card is 4.0 compliant and even though host don't support
highspeed
>> feature, we set the highspeed flags for support host max clocks.
>> I think highspeed depends on host clock. Is it right?
>>
>
>No, high-speed is a _timing_ capability, not one of frequency (although
the
>new
>timing allows a higher maximum frequency). Hence, maximum clock has
>_nothing_ to
>do with what it can support. All it can tell you is that reasonably,
this
>controller should support at least one of SD or MMC high-speed, but it
>cannot
>tell you which.
>
>Rgds
>Pierre
>
