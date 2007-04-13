From: <sathish.madhava@wipro.com>
Subject: OneNAND Booting
Date: Fri, 13 Apr 2007 09:30:12 +0530
Message-ID: <42E999AD7A0E4647BF159F467EE4FBCB0155E1EB@BLR-SGM-MSG01.wipro.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear All,

I have some questions on OneNAND booting on OMAP2430SDP board.

=20

I am using X-loader 1.40 version with UBoot 1.1.3 version.

=20

I have created X-load.bin and converted it to X-load.raw.

Using CSST Tool I signed it to generated X-load.raw.ift.

I am burning X-load.raw.ift  to ONENAND on OMAP2430SDP board at address
0x20000000 and=20

I used UBoot to write UBoot.bin at Offset 0x0080000 using onenand write
command. ( I have verified the content using onenand read, it is OK )

=20

Now I change the switch settings to enable OneNand Booting, but all I am
getting on the console is only the following message.

=20

------------------------------------

Texas Instruments X-Loader 1.40

Detected Samsung MuxOneNAND1G Flash

Starting OS Bootloader...

------------------------------------

=20

But UBoot is not loading after this stage., I donot know whats wrong at
this stage.

=20

I read that for OneNAND booting, I need to create a X-loader image of
less than 1kb size and then merge this with UBoot image then burn the
merged file to OneNAND.

How do I create x-loader image of size only 1Kb ( it is currectly around
6Kb, does anybody have any links for that 1kb source file ).

What kind of merging has to be used to merge X-load image and U-Boot
image. After merging the files can I use CSST to burn it to OneNAND?

=20

Can somebody suggest me.

=20

Thanks and Regards

-Sathish

=20

=20

=20

=20

=20

=20
