From: "sandeep prabhu" <sandeep.mitian@gmail.com>
Subject: u-boot delay on OMAP2430 SDP
Date: Sun, 21 Jan 2007 19:37:41 +0530
Message-ID: <c04186510701210607w769944apb47cb0c576cb2431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1494539293=="
Return-path: <u-boot-users-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=u-boot-users>
List-Post: <mailto:u-boot-users@lists.sourceforge.net>
List-Help: <mailto:u-boot-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=subscribe>
Sender: u-boot-users-bounces@lists.sourceforge.net
Errors-To: u-boot-users-bounces@lists.sourceforge.net
To: Linux-omap-open-source@linux.omap.com, u-boot-users@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

--===============1494539293==
Content-Type: multipart/alternative;
	boundary="----=_Part_194737_24115635.1169388461574"

------=_Part_194737_24115635.1169388461574
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am using the "u-boot_16.3.tar.gz" ( u-boot version 1.1.4 ) sources
downloaded from the "linux.omap.com" site, for booting the OMAP2430 SDP board
from NOR flash. I built the sources for booting from NOR flash and burn it
using the CSST tool onto the OMAP2430 SDP board. It takes around 2 to 4
minutes for u-boot command prompt. I am also not able to boot the linux
kernel with this version.

I have tried to track exactly where is it getting delayed, as it hangs for
2-3 minutes in  function "dram_init"  in file
"board/omap2430sdp/omap2430sdp.c". But it doesnt hang at the same code
everytime I test, the problem is not consistent.
I have tried with Icache both enabling and disabling, but it did not make
any difference.

Could anyone give some pointers about what could be the issue ?

Thanks in advance,

-- 
Warm Regards,
Sandeep

------=_Part_194737_24115635.1169388461574
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br clear="all">Hi,<br><br>I am using the &quot;<span style="font-weight: bold;">u-boot_16.3.tar.gz</span>&quot; ( u-boot version 1.1.4 ) sources downloaded from the &quot;<span style="font-weight: bold;"><a href="http://linux.omap.com">
linux.omap.com</a></span>&quot; site, for booting the <span style="font-weight: bold;">OMAP2430 SDP </span>board from NOR flash. I built the sources for booting from NOR flash and burn it using the CSST tool onto the  <span style="font-weight: bold;">
OMAP2430 SDP </span>board. It takes around 2 to 4 minutes for u-boot command prompt. I am also not able to boot the linux kernel with this version.<br><br>I have tried to track exactly where is it getting delayed, as it hangs for 2-3 minutes in&nbsp; function &quot;dram_init&quot;&nbsp;  in file &quot;board/omap2430sdp/omap2430sdp.c&quot;. But it doesnt hang at the same code everytime I test, the problem is not consistent.
<br>I have tried with Icache both enabling and disabling, but it did not make any difference.<br><br>Could anyone give some pointers about what could be the issue ?<br><br>Thanks in advance,<br><br>-- <br>Warm Regards,<br>
Sandeep

------=_Part_194737_24115635.1169388461574--


--===============1494539293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1494539293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
U-Boot-Users mailing list
U-Boot-Users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/u-boot-users

--===============1494539293==--
