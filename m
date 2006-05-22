From: "Uri Kogan" <uri.kogan@givenimaging.com>
Subject: RE: osk hanging after decompressing the kernel
Date: Mon, 22 May 2006 13:56:24 +0300
Message-ID: <F3BD61925F12EE409D6994B43BE8D89352D0EA@GMAIL01.givenimaging.com>
References: <20060521221753.4A853E4D@resin04.mta.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20060521221753.4A853E4D@resin04.mta.everyone.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Try this one
Extract from OSK Newbie Guide:
If your OSK hangs after decompressing the kernel, that is due to a bug
in the factory U-Boot. If you upgrade your U-Boot, this problem with be
solved.
There is another solution in the same document.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
prafulla chandra
Sent: Monday, May 22, 2006 08:18
To: linux-omap-open-source@linux.omap.com
Subject: osk hanging after decompressing the kernel

Hi all,
I am using the preview kit that came with board. i compiled the kernel
successfully. but once i ported kernel to board it is running
successfully and displaying the messages verifying check sum .....o.k
.... decompresssing the kernel.............done  . after that it is not
showing any thing just standing there. why is it so . i have dissabled
the kernel frame buffer support also. where could be the problem?? in
bootloader or in kernel.
in past i ported successfully,linux2.6.11.3 on the same board using the
same u-boot 1.1.1.
