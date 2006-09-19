From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: Re: Fwd: Problems loading ffs image
Date: Tue, 19 Sep 2006 17:31:28 -0300
Message-ID: <ae36f8040609191331l5c5059biec4427315221d81d@mail.gmail.com>
References: <ae36f8040609151022l1239fc8ft91e96ad26e7db4ed@mail.gmail.com>
	<ae36f8040609181359u40b0862cyfd380e33192d1a6d@mail.gmail.com>
	<ae36f8040609181400h1b1ef261v3c25fc5630351392@mail.gmail.com>
	<450F42F0.6060108@gmail.com>
	<ae36f8040609182146w2c81f262n308421935165dc07@mail.gmail.com>
	<450FCC8F.5050600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <450FCC8F.5050600@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi I've downloaded an fresh git
  tree, free of mtd patches and I still receiving the same error. The
console is related tot the image blocks errors ?
my u-boot env:

bootdelay=3D3
baudrate=3D115200
bootfile=3D"uImage"
etheraddr=3D00:0e:99:02:0a:4d
ethaddr=3D00:0E:99:02:0A:4D
bootargs=3Dmem=3D32M console=3DttyS0,115200n8 noinitrd rw ip=3Doff
root=3D/dev/mtdblock3 rootfstype=3Djffs2
filesize=3D142b34
fileaddr=3D10000000
netmask=3D255.255.254.0
ipaddr=3D192.168.1.1
serverip=3D192.168.1.3
bootcmd=3D0x00100000 0x10000000 142b34;bootm
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial


On 9/19/06, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> Lu=EDs Vit=F3rio Cargnini stated on 9/18/2006 11:46 PM:
> > yes I'm using the latest kernel and i have patched it with mtd-utils
> > oficial
> > patches from site, so i must rollback my patch of mtd ?
> >
> I had suspected something like 2.4/2.6.10+latest mtd. Try using the
> plain kernel with the mtd. I think mtd-utils 1.0 was released by david
> on mtd. further, MTD
> list(http://lists.infradead.org/mailman/listinfo/linux-mtd/) might be
> able to help you better on this. it may even be your mkfs.jffs2 options
> that goofed it up..
>
> Regards,
> Nishanth Menon
>


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
