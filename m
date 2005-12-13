From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: das U-boot loader on omap 1510
Date: Tue, 13 Dec 2005 10:10:40 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402D32C27@dlee02.ent.ti.com>
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
To: Mihail Georgiev <georgiev@students.cc.tut.fi>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Mihail,


> I am trying to flas u-boot loader on my OMAP system but i=20
> somehow not succeed with that...
> For now i am booting from ram - where i prevously load=20
> u-boot..and with bootm command start flashed linux..
> everything is ok..
> but i can't flash u-boot..or probably i do not know where i=20
> am wrong I am sure that bin version of u-boot is working...
>=20
> i use following commands:
> protect off 1:0-4
> erase 1:0-4
> loadb uboot.bin
> ...
> ....
> cp.b 0x10000000 0 0x....
> protect on 1:0-4
>=20
> Is thos somehow connected with configuration switch SW2- in=20
> two different tutorials i found two different configuration=20
> for flashing u-boot..
> Can you tell whether i am wrong with something or how exactly=20
> to tell to OMAP(with SW2) to boot my flashed u-boot...


For configuring SW2 on the Innovator board please see section 3.9.3 of
the following user guide:
http://focus.ti.com/lit/ug/spru667/spru667.pdf=20

There are two flash devices on the board and you should be able to use
either.=20

Regards,
Jon
