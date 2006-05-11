From: Matthew Percival <matthew@capgo.com>
Subject: RE: how to burn u-boot into flash
Date: Fri, 12 May 2006 09:11:19 +1000
Message-ID: <1147389079.8931.4.camel@localhost.localdomain>
References: <4463493f.4b8848f8.630e.ffff9e56@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4463493f.4b8848f8.630e.ffff9e56@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> 	I have tried the third one and it tells me the u-boot.bin is not a
> hex format file. The only thing different is my FlashBurn DSK is a free one.
> Are you sure the non-free one can load u-boot.bin? I will consider buying
> one.

	Hmm... I could swear I have just used u-boot.bin with all three
programs (I have used both the free and non-free with FlashBurn).  It
may be possible that there is something funny with your file.  A
known-good image can be found here, if you want to check that:
http://tree.celinuxforum.org/CelfPubWiki/OSK?action=AttachFile&do=get&target=osk-u-boot.bin
Alternatively, u-boot.srec (in the same directory as u-boot.bin) is a
Motorola S-Record format file, which may be of use to you.

	-- Matthew
