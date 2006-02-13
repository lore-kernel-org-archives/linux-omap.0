From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: changing core frequency in omap 5912
Date: Mon, 13 Feb 2006 10:55:44 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF4038CD242@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <u-boot-users-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: u-boot-users-admin@lists.sourceforge.net
Errors-To: u-boot-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:u-boot-users@lists.sourceforge.net>
List-Help: <mailto:u-boot-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=u-boot-users>
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>, vshrirama@gmail.com
Cc: u-boot-users@lists.sourceforge.net, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Sriram, HK,


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Hiroki Kaminaga
> Sent: Monday, February 13, 2006 2:19 AM
> To: vshrirama@gmail.com
> Cc: u-boot-users@lists.sourceforge.net; linux-omap-open-
> source@linux.omap.com
> Subject: Re: changing core frequency in omap 5912
>=20
> Hi,
>=20
> >     How do i change the cpu core frequency in omap 5912.
> >
> >     I tried changing the DPLL registers. but u-boot hangs.
>=20
> writing clock control value(0x050f) to address(0xfffece00)?
>=20
>=20

You need to take care when modifying the DPLL1 and the ARM_CKCTL
register. Simply configuring the DPLL1 for 192MHz will not work, as by
default uboot configures the device for what is know as "fully scalable
mode", where the ARM, DSP and Traffic Controller (TC) run at the DPLL1
speed. The TC can NOT operate at 192MHz. It is limited to 96MHz.
Therefore, before configuring the DPLL1 and ARM_CKCTL, you need to put
the device into "synchronous scalable" mode where the ARM, DSP and TC
can run at different speeds determined by the ARM_CKCTL register.=20

So here is what you need to do:

1). Make sure the DPLL1 is in bypass
2). Configure the ARM_SYSST for "synchronous scalable" mode
3). Configure the ARM_CKCTL register so that the different clock domains
operate no faster than the maximum speed for that particular domain. See
"OMAP5912 Global Clock Rules" in the OMAP5912 Errata guide for a list
showing the maximum speed for each clock domain
(http://focus.ti.com/docs/prod/folders/print/omap5912.html)
4). Configure DPLL1.=20

Regards,
Jon


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
