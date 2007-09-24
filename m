From: "Nazim Khan" <nazim.asad@gmail.com>
Subject: Re: regarding USB
Date: Mon, 24 Sep 2007 10:20:07 +0530
Message-ID: <ef9503490709232150n7b2b4d75h7ff1b93516cce5c5@mail.gmail.com>
References: <5DF83221BE20114E9C331F665ACBC080039ABD36@dbde01.ent.ti.com>
	<327144.2130.qm@web60922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <327144.2130.qm@web60922.mail.yahoo.com>
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
To: radha k <radha_kodirekka@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Looks like your USB Memory device does not have any partitions.
Is that right?
if thats the case then your device is actually sdb, not sdb1.
Create proper device node for sdb using following command check it out again.
# mknod /dev/sdb b 8 16

- Naz

On 9/22/07, radha k <radha_kodirekka@yahoo.com> wrote:
>
> HI sir
>  I am  doing: /dev # mknod /dev/sdb1 b 8 1, because
> sdb1 node is not getting created for me as soon as i
> connect USB.Therefore i am creating it manually.
>
>   Kindly let me know how to proceed.
>      Thanking you in advance,
> With regards,
> Radha.K
>
>
> --- "Pandita, Vikram" <vikram.pandita@ti.com> wrote:
>
> > I am not doing: /dev # mknod /dev/sdb1 b 8 1
> > I directly mount the /dev/sdb1 node.
> >
> > >-----Original Message-----
> > >From: radha k [mailto:radha_kodirekka@yahoo.com]
> > >Sent: Friday, September 21, 2007 3:34 PM
> > >To: Pandita, Vikram
> > >Cc: linux-omap-open-source@linux.omap.com
> > >Subject: RE: regarding USB
> > >
> > >Hi
> > >
> > >after connecting USBto OSK5912 i am geeting messge
> > >like this
> > >
> > >Instead of SDA1 i am geeting SDB1
> > >so i created a node for sdb1
> > >and i mounted usb using sdb1 node
> > >still i am getting error
> > >
> > >
> > >
> > >usb 1-1: new full speed USB device using ohci and
> > >address 4
> > >usb 1-1: Product: Mass Storage Device
> > >usb 1-1: Manufacturer: JetFlash
> > >usb 1-1: SerialNumber: 0M9K8ZBK
> > >usb 1-1: configuration #1 chosen from 1 choice
> > >scsi3 : SCSI emulation for USB Mass Storage devices
> > >scsi 3:0:0:0: Direct-Access     JetFlash TS1GJFV30
> > >   8.07 PQ: 0 ANSI: 2
> > >sd 3:0:0:0: [sdb] 2007038 512-byte hardware sectors
> > >(1028 MB)
> > >sd 3:0:0:0: [sdb] Write Protect is off
> > >sd 3:0:0:0: [sdb] Assuming drive cache: write
> > through
> > >sd 3:0:0:0: [sdb] 2007038 512-byte hardware sectors
> > >(1028 MB)
> > >sd 3:0:0:0: [sdb] Write Protect is off
> > >sd 3:0:0:0: [sdb] Assuming drive cache: write
> > through
> > > sdb:<7>usb-storage: queuecommand called
> > > sdb1
> > >sd 3:0:0:0: [sdb] Attached SCSI removable disk
> > >sd 3:0:0:0: Attached scsi generic sg1 type 0
> > >
> > >/dev # mknod /dev/sdb1 b 8 1
> > >/dev # mount -t vfat /dev/sdb1 /mnt/usb
> > >mount: Mounting /dev/sdb1 on /mnt/usb failed: No
> > such
> > >device or address
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> >
> ____________________________________________________________________________________
> > >Luggage? GPS? Comic books?
> > >Check out fitting gifts for grads at Yahoo! Search
> >
> >http://search.yahoo.com/search?fr=oni_on_mail&p=graduation+gifts&cs=bz
> >
>
>
>
>       ____________________________________________________________________________________
> Check out the hottest 2008 models today at Yahoo! Autos.
> http://autos.yahoo.com/new_cars.html
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
