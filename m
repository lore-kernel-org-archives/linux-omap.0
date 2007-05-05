From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: Building Linux on OMAP-2430 SDP
Date: Fri, 4 May 2007 19:41:55 -0500
Message-ID: <782515bb0705041741t54b4cab5t7306830df1ef51f3@mail.gmail.com>
References: <782515bb0705020515l4a96c0f7wd15759185503d7c8@mail.gmail.com>
	<KIEKKGBMLLBPKHIELIEEOEJJCBAA.raghuts@tivr.co.in>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_69196_5517610.1178325715992"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <KIEKKGBMLLBPKHIELIEEOEJJCBAA.raghuts@tivr.co.in>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Raghu TS <raghuts@tivr.co.in>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

------=_Part_69196_5517610.1178325715992
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Raghu,
Please *dont* top post.
On 5/4/07, Raghu TS <raghuts@tivr.co.in> wrote:
> However I am not able to build the Linux kernel. I downloaded the kernel
> source and trying to configure the kernel is failing. In particular, steps
> 2-4 in Section-7.1.2 are working fine. However when I try to make 'uImage',
> I am getting an error that "mkimage" command not found and U-boot images
Note that you need "mkimage" from the u-boot build :).. thanks - I
will update the document on this. go to u-boot/tools/mkimage (if you
have build it), copy this to a path present in ur $PATH variable like
~/bin etc..

> will not be built. After this message, though there is a message which says
> "Image arch/arm/boot/uImage is ready", there wont' be any such image.
Good eye.. That is a bug.... :)... somebody fix me :)...mebbe needs to
go to vgers list.
Source of error(2007-02-14):
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=8c7e4498adfdb4aea5a0d056590ec18d099ba062
on not finding it, it should have returned 1 and not 0.

Attached patch for the same. ( lazy question @tony: should it go to
arm list or is it fine here?).

Regards,
Nishanth Menon

------=_Part_69196_5517610.1178325715992
Content-Type: application/octet-stream; name=mkuboot.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1bcls8q
Content-Disposition: attachment; filename="mkuboot.patch"

ZGlmZiAtLWdpdCBhL3NjcmlwdHMvbWt1Ym9vdC5zaCBiL3NjcmlwdHMvbWt1Ym9vdC5zaAppbmRl
eCA0YjA2YzVlLi42YzkxNTI2IDEwMDc1NQotLS0gYS9zY3JpcHRzL21rdWJvb3Quc2gKKysrIGIv
c2NyaXB0cy9ta3Vib290LnNoCkBAIC0xMSw3ICsxMSw3IEBAIGlmIFsgLXogIiR7TUtJTUFHRX0i
IF07IHRoZW4KIAlpZiBbIC16ICIke01LSU1BR0V9IiBdOyB0aGVuCiAJCSMgRG9lc24ndCBleGlz
dAogCQllY2hvICcibWtpbWFnZSIgY29tbWFuZCBub3QgZm91bmQgLSBVLUJvb3QgaW1hZ2VzIHdp
bGwgbm90IGJlIGJ1aWx0JyA+JjIKLQkJZXhpdCAwOworCQlleGl0IDE7CiAJZmkKIGZpCiAK
------=_Part_69196_5517610.1178325715992
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_69196_5517610.1178325715992--
