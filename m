From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Fwd: Problems loading ffs image
Date: Tue, 19 Sep 2006 20:09:09 -0500
Message-ID: <451094B5.3020904@gmail.com>
References: <EA12F909C0431D458B9D18A176BEE4A507B53B7B@dlee02.ent.ti.com>
	<ae36f8040609191412l48652267udcc193d8b8c953e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040609191412l48652267udcc193d8b8c953e4@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Assumption: mtd-utils
ftp://ftp.infradead.org/pub/mtd-utils/mtd-utils-1.0.0.tar.gz was used to
create the mkfs.jffs2

>cfi_cmdset_0001: Erase suspend on write enabled
>0x00020000-0x00040000 : "params"
Cmdset1+sectorsize=128K looks like a strataflash
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
> 0x9d8d instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
> 0x0b59 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000008:
> 0x4f8f instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c:
> 0xd159 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000010:
> 0xe226 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000014:
> 0x9318 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000018:
> 0x030a instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c:
> 0xb702 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020:
> 0x7044 instead
> VFS: Mounted root (jffs2 filesystem).
> Freeing init memory: 116K
> Warning: unable to open an initial console.
as karthik said: check ur inittab and console device settings esp since
ur using udev now a days..
> I'm using the mkfs.jffs2 of mtd-utils 1.00 as i said before.
> the command to create image is:
> mkfs.jffs2 -p -l -e 0x20000 -n -v -r ilfs/ -o instramed.jffs2
> 
<snip>
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000024:
> 0x6d97 instead
> Further such events for this erase block will not be printed
Try something simpler.
mkfs.jffs2 -d root_folder -o rootfs_image.jffs2 -e 0x20000
and flash rootfs_image.jffs2 to flash using the following command
(assuming you downloaded to memory at 0x80000000(if this is not the
address of SDRAM memory, change it) and have erased the flash from
0x04240000 to 0x06240000)
cp.b 0x80000000 0x04240000 (size of the filesystem)

> On 9/19/06, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>> You boot command doesn't look right...
>>         bootcmd=0x00100000 0x10000000 142b34;bootm
>>
yup. the bootargs also look good, but the bootcmd is faulty.

>>
>> Can you even read reasonable data in your flash device when the kernel
>> is on the way up?  It could be as simple as your memory timings are
>> wrong given your boot speed and they simply are read up incorrectly.
This cannot be true as the CFI probe did work.. so guess the strata
flash is active.


OK just in case nothing worked, as an last ditch alternate strategy, in
case you do have ethernet working:
boot out of NFS. have the filesystem you would like to have in the flash
  visible in the NFS filesystem.

Now, with the mtd-utils, do the following:
./flash_eraseall -j /dev/mtd/3
mount -t jffs2 /dev/mtdblock/3 /mnt
cd /mnt
cp -rvf <theflashfilesystemdirectory/*> .
ls -al

it should now look like
usr bin lib include tmp dev
etc..

if ur filesystem looks good (i'd use a filesystem that boots off NFS for
this so a good checkpoint if your filesystem has console and others will
be that), next:
cd
umount /mnt
cat /dev/mtd/3>anewImage.jffs2

you can now use the anewImage.jffs2

happy hunting..

Regards,
Nishanth Menon
