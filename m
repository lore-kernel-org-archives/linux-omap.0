From: "xuxian" <lsfdxuxian@gmail.com>
Subject: RE: how to burn u-boot into flash
Date: Fri, 12 May 2006 12:21:32 +0800
Message-ID: <44640d5d.1e0abe25.1fce.ffffa54e@mx.gmail.com>
References: <1147389079.8931.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1147389079.8931.4.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Matthew Percival' <matthew@capgo.com>, 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello Mattew,

	I just tried your .bin file, but it still tells me that is not a
.hex format file. So strange! Could you tell me where your FlashBurn DSK
download? Is there something different between the software?
As to the u-boot.srec, I notice the start address is 0x11080000 using the
following command:
	arm-linux-objdump -x u-boot.srec
FlashBurn tells me trying to burn at 0x5080000 and override the size of
flash 0x2000000 when I burn u-boot.srec. So I change the start address to
0xc000000 the physical address. It can be burn but there is nothing on
console when restart. What could the problem be? Thank you for your time.

Best Regard,
xuxian

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Matthew
Percival
Sent: Friday, May 12, 2006 7:11 AM
To: Linux OMAP Open Source
Subject: RE: how to burn u-boot into flash

G'Day,

> 	I have tried the third one and it tells me the u-boot.bin is not a
> hex format file. The only thing different is my FlashBurn DSK is a free
one.
> Are you sure the non-free one can load u-boot.bin? I will consider buying
> one.

	Hmm... I could swear I have just used u-boot.bin with all three
programs (I have used both the free and non-free with FlashBurn).  It
may be possible that there is something funny with your file.  A
known-good image can be found here, if you want to check that:
http://tree.celinuxforum.org/CelfPubWiki/OSK?action=AttachFile&do=get&target
=osk-u-boot.bin
Alternatively, u-boot.srec (in the same directory as u-boot.bin) is a
Motorola S-Record format file, which may be of use to you.

	-- Matthew

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
