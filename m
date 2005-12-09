From: "Kanagesh R" <kanagesh@india.com>
Subject: Re: Booting problem !!
Date: Fri, 09 Dec 2005 15:25:17 +0800
Message-ID: <20051209072517.16BD67B3DE@ws5-10.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kavita Kalra <kavita.dsp@gmail.com>, nitesh ranjan <nit_ranjan@yahoo.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


----- Original Message -----
From: "Kavita Kalra" <kavita.dsp@gmail.com>
To: "nitesh ranjan" <nit_ranjan@yahoo.com>
Subject: Re: Booting problem !!
Date: Fri, 9 Dec 2005 11:52:13 +0530

>=20
> Hi ....i hv just started working on omap5912.
>=20
> And while trying to load the kernel image encountered the same
> problem.Theprocessor hanged after i gave the command bootm...........I
> had to reload
> the uImage again . I am not sure whether it will help u or not but it may=
 be
> becoz of the size of kernel that u entered may be different .In my case it
> was this.
> But i m struck at the same point once again........I am using the procedu=
re
> mentioned in the documentation that is provided with the kit but it says
> minicom does not work properly with uboot.....i saw in your mail that u r
> using minicom.........is it working fine?
>=20
> Pls excuse me 4 my ignorance  but i m confused how to enter kernel
> parameters .using hyperterminal........the command is
> setenv bootargs console=3Dttys0,115200n8 noinitrd rw ip=3Ddhcp root=3D/de=
v/nfs
> nfsroot=3Dserverip:/home/username/montavista/filesys,nolock mem=3D30M
> saveenv
> Is it jst a command to enter the parameters or it requires the linux syst=
em
> ON at that particular moment?
>=20
> if yes then hw to communicate with linux on one system and hyperterminal =
on
> winxp of some other system..........does it require some configurational
> setup ?Or should i configure minicom for this purpose......?
> pls suggest ???
>=20
>=20

I work with an OSK and I use minicom on linux to connect to the board.  Min=
icom=20
works perfectly fine with u-boot.=20



--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
