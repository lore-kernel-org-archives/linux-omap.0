From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: 2420 H4 and kernel startup RAM error
Date: Thu, 5 Jan 2006 02:51:28 -0800 (PST)
Message-ID: <20060105105128.27635.qmail@web32912.mail.mud.yahoo.com>
References: <3d3153f60601050212x24ad061bhbc77d5a08e686af9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3d3153f60601050212x24ad061bhbc77d5a08e686af9@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ola Helm <ola.hel@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Ola Helm <ola.hel@gmail.com> wrote:

> Kernel command line: root=3D/dev/ram0 rw mem=3D32M console=3DttyS0,1152=
00n8
> initrd=3D0x80600000,8M ramdisk_size=3D8192

I believe that you are pointing out RAMDISK error you are getting while
booting the kernel. If that is the case then you have to load ramdisk
image (available on linux.omap.com site) to 0x80600000 location (either
through tftp / serial ).

Load kernel image in RAM at 0x80300000

#tftpboot 0x80300000 kernel.cc

Load ramdisk image at 0x80600000

#tftpboot 0x80600000 ramdisk.img

#bootm 0x80300000

Hope this helps !!!

---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20
