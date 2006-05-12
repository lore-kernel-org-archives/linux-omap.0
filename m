From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: how to burn u-boot into flash
Date: Thu, 11 May 2006 21:06:27 -0500
Message-ID: <772F5D89C5E0734B8A86D85DFC6A2024034179DA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Matthew Percival <matthew@capgo.com>
Cc: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

 Just a thought....

 There three programs worked for the OSK (2 x 28F128J3 flash),
while xuxian has a custom board (1 x 28F256J3).

 If this is the case, they need slightly different procedure to
program.

 # I don't know why these utilities rejected to load
the *.bin file, though.

 Regards,
 Ishigami

-----Original Message-----
From: Matthew Percival
Sent: Friday, May 12, 2006 8:11 AM
To: Linux OMAP Open Source
Subject: RE: how to burn u-boot into flash

G'Day,

> 	I have tried the third one and it tells me the u-boot.bin is not
a
> hex format file. The only thing different is my FlashBurn DSK is a
free one.
> Are you sure the non-free one can load u-boot.bin? I will consider
buying
> one.

	Hmm... I could swear I have just used u-boot.bin with all three
programs (I have used both the free and non-free with FlashBurn).  It
may be possible that there is something funny with your file.  A
known-good image can be found here, if you want to check that:
http://tree.celinuxforum.org/CelfPubWiki/OSK?action=3DAttachFile&do=3Dget=
&ta
rget=3Dosk-u-boot.bin
Alternatively, u-boot.srec (in the same directory as u-boot.bin) is a
Motorola S-Record format file, which may be of use to you.

	-- Matthew

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
