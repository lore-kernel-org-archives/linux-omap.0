From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Fwd: OMAP 2430 nand/nor booting
Date: Mon, 04 Jun 2007 20:33:32 -0500
Message-ID: <4664BD6C.8010005@gmail.com>
References: <78d6ed630706021205t3d8885afv5129f50f4da04548@mail.gmail.com>	
	<78d6ed630706030702r1480faf5j3af7f1b5b64dd9ce@mail.gmail.com>	
	<4663F5F6.6030609@gmail.com>
	<78d6ed630706041106m24955647q2269b2001191f4e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630706041106m24955647q2269b2001191f4e6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Amit Gupta <amit_jobs05@inbox.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Amit / Aman,

Amit Gupta stated on 6/4/2007 1:06 PM:
> But i am sure that after reset of processor with NOR settings the
> reset address is not that of NOR. Its different because NOR shares its
> switch settings with mDOC and some other device.
>
What is your sysboot settings? if you do read the sysboot reg, u'd know
from where it did boot. there is something called internal and external
boot described in the TRM.
>
> Small Example which I carried out :-
>
> I had writtten small LCD program which I downloaded through CSST in
> NOR at addresss at location 0x04000000 and I ticked execute after
> download
> at location 0x04000000 and the LCD got correct vaoue and hence image
> executed sucessfully but
> when I reset the processor, the image did not executed and the LCD did
> not
> changed
>
Obviously, the CSST does something called peripheral boot. it has an
initialization code which setup all required regs.. when ur image boots,
dont expect that to be done automatically, unless you have put that code
in ur image.
> This makes sure that even with NOR settings the PC does not jumps to NOR
> strating location of 0X04000000 but rather it moves at an offset which
> is at
> location
> 0x08000000 i suppose( which I saw in case of sample image)
yes, the 0x0800... is the address ROM code programs for CS0 on NOR
flash. did u read GPMC regs to figure out the settings? GPMC can map
that Chip select to anywhere from 0x0 to 0x3000... so it does not make a
difference what CSST thinks the CS address is.. it configured it to be
0x0400.. this is the same address u-boot also does.. Essentially, from
what u stated, u did boot off NOR flash.. only ur code messed up somewhere..
>
> still what is important to know is the reset address and how the boot
> loader
> copies from NOR to that address.
It is simple: your reset address is baseaddress programmed in
GPMC_CS0_CONFIG7 reg+0x0

>
> With the NAND image is not at all executing, I dont understand why but I
> suppose I will get the clue once I get answer to this.
I suggest more reading of documentation.. it gives you a better picture
of boot sequence - which fortunately is simple once u trace it out.
>
>
> On 6/4/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
>>
>> Hi Amit,
>> Amit Gupta stated on 6/3/2007 9:02 AM:
Please do not TOP post while replying in email list.. most folks hate
having to get a 2 k mail when 100 bytes would have done. AND only in
text format.

Thanks and Regards,
Nishanth Menon
