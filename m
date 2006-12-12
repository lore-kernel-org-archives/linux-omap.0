From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: need help with video output
Date: Mon, 11 Dec 2006 23:53:24 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4706D0DB@dlee13.ent.ti.com>
References: <2717eaf60612101951s625a00f5t856ee22eff86ee24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <2717eaf60612101951s625a00f5t856ee22eff86ee24@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: hsu shawn <shanghsu@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I didn't get what exactly you were interested in. I assume you wanted to
enable TV-out.=20

To enable TV-out=20
<*> Video out library
	<*> Video out driver   =20
	[*] TV out support

TV-out support should be enabled by executing the default 2430
defconfig. In order to direct the output from a pipeline on to TV, you
have to use SYSFS entries, do a=20

echo "tv" > /sys/class/disp_control/omap_display/graphics (it can be
graphics or video1 or video2).

This switches the out put from a pipeline to either TV or LCD. For a
quick try, you can direct graphics onto TV, you should see Linux penguin
on TV.=20

On 2430 SDP you should use the TV-out connector that is present on
Processor board and not the one on UI (near keypad) board.

Let me know if you need any further info.

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of hsu
shawn
Sent: Sunday, December 10, 2006 9:52 PM
To: linux-omap-open-source@linux.omap.com
Subject: need help with video output

Dear all,

My environment is OMAP2430 with kernel_2.6.14 and U-boot_1.1.3.

Now, I tried to enable video output function via A/V connector on 2430
processor card.

Is anyone had tried this function and can give me some suggestions about
how
to enable video output on OMAP2430?

Several items I had enabled in my menuconfig. Device Drivers/Multimedia
devices/Video for Linux/OMAP24xx V4L2 drivers/(Video out library, Video
out
driver)

Thanks a lot.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
