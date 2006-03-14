From: "Minjie Lin" <MLin@EmpowerTechnologies.com>
Subject: problem while configuring the DSP/BIOS LINK configuration tool
Date: Tue, 14 Mar 2006 10:40:14 -0700
Message-ID: <6632A2E3A760EA41B6A08F2A8B02C34C71CB60@BBSC-EX01.bbsconnect.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
This Dsplink is for 2.4 linux kernel, if you want use it for=20
2.6 kernel, need to port it to 2.6 kernel.
Regards,
Minjie
=20
=20
Hi all,
i am trying to execute the audio demo present in the user guide . i =
ported
my own kernel linux2.6.11.3 to the osk5912 board and mounted the =
rootfile
system successfully  using the NFS with *out using priview kit  *. now i
want to execute the audio demo which is given in the osk5912 userguide . =
for
that i am following the book
https://www-a.ti.com/downloads/sds_support/LinuxDspTools/doc/LinuxDspTool=
s_GettingStartedGuide_v98.pdf(
dsp development for TI OMAP5912) . NOW IN THAT DSP/BIOS LINK
configuration
tool for GPP SIDE OPERATING SYSTEM it is giving 5 options
1) montavista linux pro 3.1
2) montavista linux pro 3.0
3 montavista linux pro 3.1 preview kit
4)monterey linux
5) nucleus

i am not using priview kit  .now how can i execute the audio demo .
2) which option i have to choose among the above 4 .
3)is there any other procedures are available to execute audio demo =
means to
install DSP/BIOS LINK and the RF6 on my target board
any one come accross these problems??
thanks in advance
-- prafulla chandra.
