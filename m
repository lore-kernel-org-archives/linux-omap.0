From: "Zaheer" <zaheer_mugad@mindtree.com>
Subject: Re: patch to enable mtd partitions in omap5912 for 2.6.8.
Date: Fri, 27 Apr 2007 09:29:01 +0530
Message-ID: <46317505.2090007@mindtree.com>
References: <46305277.90802@mindtree.com> <463098EB.6030006@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <463098EB.6030006@css-design.us>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Steve Poulsen <spoulsen@css-design.us>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Steve,
Currently 2.6.8 has support to boot only out of NFS, I would like to=20
boot out of flash and hence create partitions in the flash for the=20
filesystem.
I referred  to the "omap-flash.c" in the 2.4.20 kernel which comes along =

with the osk from Montavista. Its not working  when I try to use in=20
2.6.8 as the kernel crashes.

Regards,
Zaheer.
Steve Poulsen wrote:
> Zaheer,
>
> Does 2.6.8 have problems with MTD?  If not, you should just be able to =

> enable it in the kernel config.  Look at=20
> arch/arm/mach-omap1/board-osk.c as well.
>
> Steve
>
> Zaheer wrote:
>> Hello,
>>
>> Can anyone provide me with a patch for enabling MTD partitions on=20
>> omap5912 osk for 2.6.8 kernel.
>>
>> Thanks,
>> Zaheer
>>
>>
>> DISCLAIMER:
>> This message (including attachment if any) is confidential and may be =

>> privileged. Before opening attachments please check them for viruses=20
>> and defects. MindTree Consulting Limited (MindTree) will not be=20
>> responsible for any viruses or defects or any forwarded attachments=20
>> emanating either from within MindTree or outside. If you have=20
>> received this message by mistake please notify the sender by return =20
>> e-mail and delete this message from your system. Any unauthorized use =

>> or dissemination of this message in whole or in part is strictly=20
>> prohibited.  Please note that e-mails are susceptible to change and=20
>> MindTree shall not be liable for any improper, untimely or incomplete =

>> transmission.
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>



DISCLAIMER:
This message (including attachment if any) is confidential and may be =
privileged. Before opening attachments please check them for viruses and =
defects. MindTree Consulting Limited (MindTree) will not be responsible =
for any viruses or defects or any forwarded attachments emanating either =
from within MindTree or outside. If you have received this message by =
mistake please notify the sender by return  e-mail and delete this =
message from your system. Any unauthorized use or dissemination of this =
message in whole or in part is strictly prohibited.  Please note that =
e-mails are susceptible to change and MindTree shall not be liable for =
any improper, untimely or incomplete transmission.
